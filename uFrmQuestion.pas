unit uFrmQuestion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uFrmMain, Grids, RXGrids, uMdlBase;

type
  TBase = record
    id, page, number, arcticle, text1, var1, var2, var3, text2: string;
  end;


  TfrmQuestion = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    grdQuestion: TStringGrid;
    grdQuestion1: TStringGrid;
    grdQuestion2: TStringGrid;
    lblN1: TLabel;
    lblN: TLabel;
    lblN2: TLabel;
    lblP1: TLabel;
    lblP: TLabel;
    lblP2: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdQuestionDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button2Click(Sender: TObject);
    procedure grdQuestion1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure grdQuestion2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure grdQuestionSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure grdQuestion1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure grdQuestion2SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
     { Public declarations }
    function CrackWords(AStr: string; var ABase: TBase): boolean;
    function GetAnswer(APos: integer; var AArray :TArrayAnswer): integer;    
  end;

const
  cFonSize = 10;

var
  frmQuestion: TfrmQuestion;
  FileStream: TFileStream;

implementation

uses uFrmReport;

{$R *.dfm}


function TfrmQuestion.CrackWords(AStr: string; var ABase: TBase): boolean;

function GetNext(AStr: string; ACode: char; var ARetStr: string): string;
var i: integer;
    RetValue : string;
begin
  RetValue := '';
   i := Pos(ACode, AStr);

   if (i = 0) then i := length(AStr);

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
end;

procedure SetTextToGrid(var AGrid: TStringGrid; ACol: integer; AText: string);
var WidthChar, WidthText, WidthAdd: integer;
begin
  AGrid.Canvas.Font := AGrid.Font;
  WidthChar := AGrid.Canvas.TextWidth(' ');
  AGrid.Cells[ACol, 0] := AText;
  WidthText := AGrid.Canvas.TextWidth(AGrid.Cells[ACol, 0]);
  if (ACol in [2..4])  then
    begin
      WidthAdd := 10;
      if AText <> '' then AGrid.Cells[ACol, 0] := ' ' + AText;
     end
  else
     begin
       WidthAdd := 2;
      end;
  if ACol = 0 then
    begin
      WidthAdd := 0;
      WidthChar := 0;
    end;

  AGrid.ColWidths[ACol] :=  WidthText + WidthAdd * WidthChar;
end;

procedure SetLineTextToGrid(AGrid: TStringGrid;var fs: System.text);
var tempStr: string;
begin
  Readln(fs, tempStr); CrackWords(tempStr, Base); FilePos := FilePos + 1;

  with frmQuestion do
    begin
      SetTextToGrid(AGrid, 0, '');
      SetTextToGrid(AGrid, 1, Base.text1);
      SetTextToGrid(AGrid, 2, Base.var1);
      SetTextToGrid(AGrid, 3, Base.var2);
      SetTextToGrid(AGrid, 4, Base.var3);
      SetTextToGrid(AGrid, 5, Base.Text2);

     if Base.id = 'ID' then
       begin
        SetTextToGrid(AGrid, 1, '');
        SetTextToGrid(AGrid, 2, '');
        SetTextToGrid(AGrid, 3, '');
        SetTextToGrid(AGrid, 4, '');
        SetTextToGrid(AGrid, 5, '');
      end;

    end;

end;

procedure GetQuestionOnScreen(var fs: System.text);
begin
  SetLineTextToGrid(frmQuestion.grdQuestion1, fs);

  frmQuestion.lblN1.Caption := Base.number;
  frmQuestion.lblP1.Caption := Base.page;

  SetLineTextToGrid(frmQuestion.grdQuestion,fs); QuestPos := QuestPos + 1;

  frmQuestion.lblN.Caption := Base.number;
  frmQuestion.lblP.Caption := Base.page;

  SetLineTextToGrid(frmQuestion.grdQuestion2,fs);

  frmQuestion.lblN2.Caption := Base.number;
  frmQuestion.lblP2.Caption := Base.page;  

  BackTextFile(fs, Base);
  BackTextFile(fs, Base);

end;

procedure TfrmQuestion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if MessageBox(Handle, 'Вы точно хотите прервать тест?',
     PChar(Application.Title), MB_YESNO) <> ID_YES then
     begin
       Action := caNone;
     end else
     begin
        CloseFile(FileBase);
     end;
end;

procedure TfrmQuestion.Button3Click(Sender: TObject);
begin
  if FilePos >= 114 then Exit;
  GetQuestionOnScreen(FileBase);
end;

procedure TfrmQuestion.FormShow(Sender: TObject);
begin
  AssignFile(FileBase, ExtractFilePath(Application.ExeName)+FileNameBase);
  Reset(FileBase);
  GetQuestionOnScreen(FileBase);
end;

procedure SetAnswer(ACol, APos: integer; var AArray :TArrayAnswer);
begin
  if ACol in [2..4] then
    AArray[APos] := ACol - 1;
end;

function TfrmQuestion.GetAnswer(APos: integer; var AArray :TArrayAnswer): integer;
begin
  GetAnswer :=  AArray[APos] + 1;
end;

procedure TfrmQuestion.grdQuestionDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
if (ACol in [2..4]) and (grdQuestion.Cells[ACol, 0] <> '') then
  begin
    grdQuestion.Canvas.Pen.Mode := pmMask;
    grdQuestion.Canvas.Pen.Color := clBlack;
    grdQuestion.Canvas.Pen.Width := 2;
    grdQuestion.Canvas.Brush.Color := clWhite;
    grdQuestion.Canvas.Rectangle(Rect.Left + 2, Rect.Top + 2, Rect.Right - 4, Rect.Bottom - 4);

  if GetAnswer(QuestPos, ArrayAnswer) = ACol then
   begin
      grdQuestion.Canvas.Pen.Mode := pmMask;
      grdQuestion.Canvas.Pen.Color := clBlack;
      grdQuestion.Canvas.Ellipse(Rect.Right - 24, Rect.Top + 6, Rect.Right - 12, Rect.Bottom - 6);
   end;
  end;
end;

procedure TfrmQuestion.Button2Click(Sender: TObject);
begin
  if FilePos <= 1 then Exit;

  BackTextFile(FileBase, Base);
  BackTextFile(FileBase, Base);
  GetQuestionOnScreen(FileBase);
  QuestPos := QuestPos - 2;  
end;

procedure TfrmQuestion.grdQuestion1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
if (ACol in [2..4]) and (grdQuestion1.Cells[ACol, 0] <> '') then
  begin
    grdQuestion1.Canvas.Pen.Mode := pmMask;
    grdQuestion1.Canvas.Pen.Color := clBlack;
    grdQuestion1.Canvas.Pen.Width := 2;
    grdQuestion1.Canvas.Rectangle(Rect.Left + 2, Rect.Top + 2, Rect.Right - 4, Rect.Bottom - 4);

  if GetAnswer(QuestPos - 1, ArrayAnswer) = ACol then
   begin
      grdQuestion1.Canvas.Pen.Mode := pmMask;
      grdQuestion1.Canvas.Pen.Color := clBlack;
      grdQuestion1.Canvas.Ellipse(Rect.Right - 24, Rect.Top + 6, Rect.Right - 12, Rect.Bottom - 6);
   end;
  end;
end;

procedure TfrmQuestion.grdQuestion2DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
if (ACol in [2..4]) and (grdQuestion2.Cells[ACol, 0] <> '') then
  begin
    grdQuestion2.Canvas.Pen.Mode := pmMask;
    grdQuestion2.Canvas.Pen.Color := clBlack;
    grdQuestion2.Canvas.Pen.Width := 2;
    grdQuestion2.Canvas.Rectangle(Rect.Left + 2, Rect.Top + 2, Rect.Right - 4, Rect.Bottom - 4);

  if GetAnswer(QuestPos + 1, ArrayAnswer) = ACol then
   begin
      grdQuestion2.Canvas.Pen.Mode := pmMask;
      grdQuestion2.Canvas.Pen.Color := clBlack;
      grdQuestion2.Canvas.Ellipse(Rect.Right - 24, Rect.Top + 6, Rect.Right - 12, Rect.Bottom - 6);
   end;

  end;

end;

procedure TfrmQuestion.grdQuestionSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  SetAnswer(ACol, QuestPos, ArrayAnswer);
  grdQuestion.Repaint;
  CanSelect := False;
end;

procedure TfrmQuestion.grdQuestion1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  SetAnswer(ACol, QuestPos - 1, ArrayAnswer);
  grdQuestion1.Repaint;
  CanSelect := False;
end;

procedure TfrmQuestion.grdQuestion2SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  SetAnswer(ACol, QuestPos + 1, ArrayAnswer);
  grdQuestion2.Repaint;
  CanSelect := False;
end;

procedure TfrmQuestion.Button4Click(Sender: TObject);
begin
   frmReport.frMain.LoadFromFile('main.frf');
   frmReport.frMain.ShowReport;
end;

procedure TfrmQuestion.FormCreate(Sender: TObject);
begin
  grdQuestion1.Font.Size := cFonSize;
  grdQuestion.Font.Size := cFonSize;
  grdQuestion2.Font.Size := cFonSize;
end;

end.
