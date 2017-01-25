unit uMdlBase;

interface

uses Classes, SysUtils, Dialogs;

type
  TBase = record
    id, page, number, arcticle, text1, var1, var2, var3, text2: string;
  end;

type
  TArrayAnswer = array [1..150] of integer;

var
  FilePos: integer = 1;
  QuestPos : integer = 1;
  PagePos: byte = 1;
  Base: TBase;

  FileBase, FileAnswer: System.Text;
  FileNameBase: string = 'base.txt';
  ArrayAnswer: TArrayAnswer;

  procedure BackTextFile(var fs: System.Text; Base: TBase);
  function CrackWords(AStr: string; var ABase: TBase): string;
  function PrepareWord(ABase: TBase; AArray :TArrayAnswer): TStrings;
  function PreparePage(APathBase, AUserName: string; APage: byte; var fs: System.Text; AArray: TArrayAnswer ): TStrings;
  procedure SetAnswerToArray(AWord: string; var AArray: TArrayAnswer);
  function SetPageToHTML(APathBase, AUserName: string; APage: byte; var fs: System.Text; AArray: TArrayAnswer ): TStrings;
implementation

procedure BackTextFile(var fs: System.Text; Base: TBase);
var i : integer;
begin
   Reset(fs);
   i := 1;
   while (not Eof(fs)) and (i < FilePos) do
   begin
     Readln(fs);
     i := i + 1;
   end;
   FilePos := FilePos - 1;
end;

function CrackWords(AStr: string; var ABase: TBase): string;

function GetNext(AStr: string; ACode: char; var ARetStr: string): string;
var i: integer;
    RetValue : string;
begin
  RetValue := '';
   i := Pos(ACode, AStr);

   if (i = 0) then i := length(AStr)+1;

   RetValue := Copy(AStr, 1, i-1);
   ARetStr := Copy(AStr, i+1, length(AStr));

  GetNext := RetValue;
end;

begin
   Base.id := GetNext(AStr, #9, AStr);
   Base.page := GetNext(AStr, #9, AStr);
   Base.number := GetNext(AStr, #9, AStr);
   Base.arcticle := GetNext(AStr, #9, AStr);
   Base.text1 := GetNext(AStr, #9, AStr);
   Base.var1 := GetNext(AStr, #9, AStr);
   Base.var2 := GetNext(AStr, #9, AStr);
   Base.var3 := GetNext(AStr, #9, AStr);
   Base.text2 := GetNext(AStr, #9, AStr);

   CrackWords := Base.id;
end;


procedure SetAnswerToArray(AWord: string; var AArray: TArrayAnswer);
var AQuestion, AVar: integer;
    tStr, tFullStr: string;
    i: integer;
begin
  for i := length (AWord) downto 1 do
    begin
      if AWord[i] = 'q' then Break;
    end;
  if i <= 1 then Exit;

  tFullStr := Copy(AWord, i, length(AWord));

  tStr := Copy(tFullStr, 2, Pos('v', tFullStr)-2);
  AQuestion := StrToInt(tStr);
  tStr := Copy(tFullStr, length(tStr)+3, length(tFullStr));
  AVar := StrToInt(tStr);

  AArray[AQuestion] := AVar;
end;

function PrepareWord(ABase: TBase; AArray :TArrayAnswer): TStrings;
var AText: TStrings;

  function IsSelected(ABase: TBase; AVar: byte): string;
  begin
    if ABase.id = 'ID' then ABase.id := '0';
    if AArray[StrToInt(ABase.id)] = AVar
    then
        IsSelected := 'checked'
    else
      IsSelected := '';
  end;

begin

if Base.id = 'ID' then Exit;

AText := TStringList.Create;	{ construct the list object }
AText.Add('<form name="form" >');

 if (Trim(ABase.arcticle) <> '') and (Trim(ABase.arcticle) <> '!')
  then AText.Add('<b>'+ABase.arcticle+'.</b>');

if (Trim(ABase.text2) <> '') or (Trim(ABase.text2) = '__')
  then begin
          if (Trim(ABase.text2) = '__') then ABase.text2 := '';

          AText.Add('<B> '+ABase.text1 + ' ... ' + ABase.text2 + '</B>');

          AText.Add('<table width="100%" border="0" >');
          AText.Add('<tr><td width="5%">A)<input type="radio" name="selectname" onclick=gotourl("q'+ABase.id+'v1") '+IsSelected(ABase, 1)+' value = "" /></td><td>'+ ABase.var1 +'</td></tr>');
          AText.Add('<tr><td width="5%">B)<input type="radio" name="selectname" onclick=gotourl("q'+ABase.id+'v2") '+IsSelected(ABase, 2)+' value = "" /></td><td>'+ ABase.var2 +'</td></tr>');
          AText.Add('<tr><td width="5%">C)<input type="radio" name="selectname" onclick=gotourl("q'+ABase.id+'v3") '+IsSelected(ABase, 3)+' value = "" /></td><td>'+ ABase.var3 +'</td></tr>');
//        AText.Add('<tr><td width="5%"><input type="radio" name="selectname" onclick=gotourl("q'+ABase.id+'v0") '+IsSelected(ABase, 0)+' value = "" /></td><td>I don''t know</tr><tr><td colspan="2"></td></tr>');
          AText.Add('</table>');
       end
  else begin
          if Trim(ABase.arcticle) = '!'
            then  AText.Add('<b>' + ABase.text1 + '</b>')
            else AText.Add(ABase.text1);
       end;

AText.Add('</form>');

PrepareWord := AText;
end;


function CreateHead(AUserName: string): TStrings;
var tempStr: string;
  AStrs: TStrings;
begin

  AStrs := TStringList.Create;

  AStrs.Add('<p><font size=10><b>Oxford Placement Test 1</b><br>');
  AStrs.Add('<b><i>Crammar Test</i> PART 1</b></font></p>');
  AStrs.Add('<table border =1 width = 75%><tr valign = middle><td ><br>');
  AStrs.Add('&nbsp;Name <U>' + AUserName+ '</U>');
  AStrs.Add('<table width =90%><tr><td>Total Listening</td><td>____ / 100</td>');
  AStrs.Add('<td>Total Grammar Part 2</td><td>____ / 50</td></tr><tr>');
  AStrs.Add('<td>Total Grammar Part 1</td><td>____ / 50</td>');
  AStrs.Add('<td><b>Grand Total</b></td><td>____ / 200</td></tr>');
  AStrs.Add('</table><br></td></tr></table>');

  CreateHead := AStrs;
end;


function PreparePage(APathBase, AUserName: string; APage: byte; var fs: System.Text; AArray: TArrayAnswer ): TStrings;
var tempStr: string;
  AStrs: TStrings;
begin
  FilePos := 0;

  AStrs := TStringList.Create;

  AssignFile(fs, APathBase + FileNameBase);
  Reset(fs);

  Readln(fs, tempStr); Base.page := '0';
  while (StrToInt(Base.page) <> APage) and (Eof(fs) = False) do
    begin
      Readln(fs, tempStr); CrackWords(tempStr, Base); FilePos := FilePos + 1;
    end;

  AStrs.Add('');
  AStrs.Add('<html><head></head><body>');

  if APage  = 1 then
    begin
      AStrs.AddStrings(CreateHead(AUserName));
    end;

  while (StrToInt(Base.page) = APage) and (Eof(fs) = False) do
    begin
      AStrs.AddStrings(PrepareWord(Base, AArray));
      Readln(fs, tempStr); CrackWords(tempStr, Base); FilePos := FilePos + 1;
    end;

  if  (Eof(fs) = True) then  AStrs.AddStrings(PrepareWord(Base, AArray));

  CloseFile(fs);

  AStrs.Add('</body></html>');
  AStrs.Add('<SCRIPT> function gotourl(f) {location.href = f;}</SCRIPT>');

  PreparePage := AStrs;
end;

function SetPageToHTML(APathBase, AUserName: string; APage: byte; var fs: System.Text; AArray: TArrayAnswer ): TStrings;
var HTMLFile: system.text;
    sl: TStrings;
    i: integer;
begin
  AssignFile(HTMLFile, APathBase + 'page.htm');
  ReWrite(HTMLFile);
  sl := TStringList.Create;
  sl :=  PreparePage(APathBase, AUserName, APage, FileBase, ArrayAnswer);

  for i := 1 to sl.Count - 1 do
    Writeln(HTMLFile, sl.Strings[i]);

  sl.Free;
  CloseFile(HTMLFile);
end;


end.
