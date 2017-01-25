unit uFrmReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FR_DSet, FR_DBSet, FR_Class, ExtCtrls, FR_E_TXT, FR_E_HTM, uMdlBase;

type
  TfrmReport = class(TForm)
    frMain: TfrReport;
    procedure frMainGetValue(const ParName: String; var ParValue: Variant);
    procedure frMainBeginBand(Band: TfrBand);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReport: TfrmReport;
  ALeft, AWidth : integer;

implementation

uses uFrmQuestion, uFrmMain;


{$R *.dfm}



procedure TfrmReport.frMainGetValue(const ParName: String;
  var ParValue: Variant);
  var APar: string;
begin

  if ParName = 'Article' then
    begin
      ParValue := Base.arcticle;
      ParValue := ParValue + ' ';
      if Trim(ParValue) = '!' then
        begin
          frMain.FindObject('lblArticle').Visible := False
        end
      else
        begin
          frMain.FindObject('lblArticle').Visible := True;
        end;
      AWidth := Canvas.TextWidth(ParValue);
      ALeft := frMain.FindObject('lblArticle').x;
      frMain.FindObject('lblArticle').dx := AWidth;
    end;

  if ParName = 'Text1' then
    begin
      ParValue := Base.text1;
      ParValue := ParValue + ' ';
      frMain.FindObject('lblText1').x := ALeft + AWidth;
      ALeft := frMain.FindObject('lblText1').x;
      AWidth := Canvas.TextWidth(Base.text1);
      frMain.FindObject('lblText1').dx := AWidth;


    end;

  if ParName = 'Vars1' then
    begin
      ParValue := Base.var1;
      ParValue := ParValue + ' ';
      if Trim(ParValue) = ''
        then frMain.FindObject('lblVars1').Visible := False
        else frMain.FindObject('lblVars1').Visible := True;
      frMain.FindObject('lblVars1').x := ALeft + AWidth;
      ALeft := frMain.FindObject('lblVars1').x;
      AWidth := Canvas.TextWidth(ParValue);
      frMain.FindObject('lblVars1').dx := AWidth;

      if  ArrayAnswer[StrToInt(Base.id)] = 1 then
        begin
          frMain.FindObject('pctCheck').Visible := True;
          frMain.FindObject('pctCheck').x := ALeft + AWidth div 2;
        end;

    end;

  if ParName = 'Vars2' then
    begin
      ParValue := Base.var2;
      ParValue := ParValue + ' ';
      if Trim(ParValue) = ''
        then frMain.FindObject('lblVars2').Visible := False
        else frMain.FindObject('lblVars2').Visible := True;
      frMain.FindObject('lblVars2').x := ALeft + AWidth;
      ALeft := frMain.FindObject('lblVars2').x;
      AWidth := Canvas.TextWidth(ParValue);
      frMain.FindObject('lblVars2').dx := AWidth;

      if  ArrayAnswer[StrToInt(Base.id)] = 2 then
        begin
          frMain.FindObject('pctCheck').Visible := True;
          frMain.FindObject('pctCheck').x := ALeft + AWidth div 2;
        end;

    end;

  if ParName = 'Vars3' then
    begin
      ParValue := Base.var3;
      ParValue := ParValue + ' ';
      if Trim(ParValue) = ''
        then frMain.FindObject('lblVars3').Visible := False
        else frMain.FindObject('lblVars3').Visible := True;
      frMain.FindObject('lblVars3').x := ALeft + AWidth;
      ALeft := frMain.FindObject('lblVars3').x;
      AWidth := Canvas.TextWidth(ParValue);
      frMain.FindObject('lblVars3').dx := AWidth;

      if  ArrayAnswer[StrToInt(Base.id)] = 3 then
        begin
          frMain.FindObject('pctCheck').Visible := True;
          frMain.FindObject('pctCheck').x := ALeft + AWidth div 2;
        end;

    end;

  if ParName = 'Text2' then
    begin
      if Trim(Base.text2) = '__' then ParValue := '  ' else ParValue := Base.text2;
      ParValue := ParValue + ' ';
      frMain.FindObject('lblText2').x := ALeft + AWidth;
      ALeft := frMain.FindObject('lblText2').x;
      AWidth := Canvas.TextWidth(ParValue);
      frMain.FindObject('lblText2').dx := AWidth;
    end;

  if ParName = 'Number' then
    begin
      ParValue := Base.number;
    end;
  if ParName = 'Name' then
    begin
      ParValue := USerName;
    end;


end;

procedure TfrmReport.frMainBeginBand(Band: TfrBand);
  var tempStr: string;
begin
frMain.FindObject('pctCheck').Visible := False;
if Band.Name = 'MasterData1' then
  begin
    Canvas.Font.Name := 'Arial';
    Canvas.Font.Style := [fsBold];
    Canvas.Font.Size := 10;
    if not Eof(FileBase) then
         begin
          Readln(FileBase, tempStr);
          CrackWords(tempStr, Base);
          FilePos := FilePos + 1;
          QuestPos := QuestPos + 1;
        end
    else Band.Visible := False;

  end;
end;

end.
