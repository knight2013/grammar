unit unFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, XPMan, DB, ADODB, ExtCtrls,
  FR_Class, XPStyleActnCtrls,uDBProcedures, Menus, ComCtrls, Printers;

type
  TfrmMain = class(TForm)
    XPManifest: TXPManifest;
    dlgPrint: TPrintDialog;
    mnuMain: TMainMenu;
    StatusBar1: TStatusBar;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    scrlMain: TScrollBox;
    imgPage: TImage;
    dlgOpen: TOpenDialog;
    imgCheck: TImage;
    mnuBegin: TMenuItem;
    N7: TMenuItem;
    dlgPrinterSetup: TPrinterSetupDialog;
    procedure Button1Click(Sender: TObject);
    procedure WebBrowser1BeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure FormShow(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure mnuBeginClick(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cAppName = 'Grammar';
  cAppVersion = '1.0.0.0';

  cHeaderSize = 95;
  cXLeft = 15;
  cXNumber = 20;
  cYSpace = 20;

  cFontSize = 10;
  cFontName = 'Arial Cyr';

var
  frmMain: TfrmMain;

implementation

uses unDmMain, UnFrmQuestion, uFrmReport;

{$R *.dfm}

type
  TImageClick = class(TImage)
  private
    Box: TRect;
  public
    Text: string;
    Checked: boolean;
    Font: TFont;
    procedure ShowText(AX, AY: integer; var AW, AH: integer);
  end;

procedure TImageClick.ShowText(AX, AY: integer; var AW, AH: integer);
begin
  Canvas.Pen.Mode := pmMask;
  if Font <> nil then Canvas.Font := Font;
  Canvas.TextOut(AX, AY, Text);
  AW := Canvas.TextWidth(Text);
  AH := Canvas.TextHeight(Text);
  Box := Rect(AX, AY, AX + AW, AY - AH);
  Canvas.Rectangle(Box);
  if Checked then
    begin
      Canvas.MoveTo(AX, AY - AH);
      Canvas.LineTo(AX + 5, AY);
      Canvas.LineTo(AX + 10, AY - AH);
    end;
   Show;
end;

var
  ImageClick1 : TImageClick;

function GetRightVar(AX, AY: integer; var AImage: TImage; AWords : TADOQuery; AVars : TADOQuery; var ATextWidth: integer): integer;
var
  AChoiced : integer;
  AText, ACurText, ASpace : string;
  ARect, ARectCheck: TRect;

begin
ARectCheck := Rect(0, 0, 12, 12);
AChoiced := 0;
ASpace := '    ';
AText := ' ';
AX := AX + AImage.Canvas.TextWidth(ACurText) + AImage.Canvas.TextWidth(ASpace) div 2;
AVars.First;
  while not AVars.Eof do
    begin
      ACurText := Trim(AVars.FieldByName('variant_word').AsString);
      AText := AText + ACurText + ASpace;
      AImage.Canvas.TextOut(AX, AY, ACurText + ASpace);
      ARect := Rect(AX - AImage.Canvas.TextWidth(ASpace) div 2, AY, AX + AImage.Canvas.TextWidth(ACurText) + AImage.Canvas.TextWidth(ASpace) div 2, AY + AImage.Canvas.TextHeight(ACurText));
      AImage.Canvas.Rectangle(ARect);
      if AVars.FieldByName('variant_number').AsInteger = AWords.FieldByName('word_to_choiced').AsInteger
         then begin
          AChoiced := AVars.FieldByName('variant_number').AsInteger;
          ARectCheck := Rect(0, 0, 12, 12);
          AImage.Canvas.CopyMode := cmSrcAnd;
          AImage.Canvas.CopyRect(Rect(ARect.Left, ARect.Top, ARect.Left + 12, ARect.Top + 12), frmMain.imgCheck.Picture.Bitmap.Canvas, ARectCheck);
          AImage.Canvas.CopyMode := cmSrcCopy;
         end;

      AVars.Next;
      AX := AX + AImage.Canvas.TextWidth(ACurText + ASpace);
    end;

    ATextWidth := AImage.Canvas.TextWidth(AText);
    GetRightVar := AChoiced;
end;

function TextOutWithResult(var AImage: TImage; AWords, AVars : TADOQuery; AHeaderExists: boolean): boolean;
var AX, AY, AValue, AEr: integer;
    ATextWidth: integer;
    AText : string;
begin
 if AHeaderExists
  then AY := cHeaderSize + AWords.FieldByName('word_Number1').AsInteger * cYSpace
  else AY := AWords.FieldByName('word_Number1').AsInteger * cYSpace;

  if Trim(AWords.FieldByName('word_number2').AsString) = ''
     then AImage.Canvas.Font.Style := [fsBold]
     else AImage.Canvas.Font.Style := [];

  AX := cXLeft;
  AText := Trim(AWords.FieldByName('word_number2').AsString);
  AImage.Canvas.TextOut(AX, AY, AText);
  ATextWidth := AImage.Canvas.TextWidth(AText);

  AX := cXLeft + cXNumber;
  AText := Trim(AWords.FieldByName('word_begin').AsString) + ' ';
  AImage.Canvas.TextOut(AX, AY, AText);
  ATextWidth := AImage.Canvas.TextWidth(AText);

  AX := cXLeft + cXNumber + ATextWidth;
  GetRightVar(AX, AY, AImage, AWords, AVars, ATextWidth);
  ATextWidth := ATextWidth + AImage.Canvas.TextWidth(AText);

  AX := cXLeft + cXNumber + ATextWidth;
  AText := Trim(AWords.FieldByName('word_end').AsString);
  AImage.Canvas.TextOut(AX, AY, AText);
end;

function TextOutWithResult1(var AImage: TImage; AWords, AVars : TADOQuery; AHeaderExists: boolean): boolean;
var AX, AY, AValue, AEr: integer;
    ATextWidth: integer;
    AText : string;
    Image: TImage;
begin
 if AHeaderExists
  then AY := cHeaderSize + AWords.FieldByName('word_Number1').AsInteger * cYSpace
  else AY := AWords.FieldByName('word_Number1').AsInteger * cYSpace;

  Image := TImage.Create(AImage);

  if Trim(AWords.FieldByName('word_number2').AsString) = ''
     then Image.Canvas.Font.Style := [fsBold]
     else Image.Canvas.Font.Style := [];

  AX := cXLeft;
  AText := Trim(AWords.FieldByName('word_number2').AsString);
  Image.Canvas.TextOut(AX, AY, AText);
  ATextWidth := Image.Canvas.TextWidth(AText);
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var Flags: OleVariant;
  page: System.Text;
begin
end;

procedure TfrmMain.WebBrowser1BeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
begin
  //Record choiced in html to data base
  if trim(copy(URL, length(URL) - 1, 2)) = '_1' then
  begin
    ShowMessage('Navigate is prepare for ' + copy(URL, length(URL) - 1, 2));
    Cancel := True;
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Caption := cAppName + ' ред.' + cAppVersion;
end;

procedure TfrmMain.N2Click(Sender: TObject);
var AW, AH: integer;
begin

if dlgOpen.Execute then
  begin
    dmMain.connMain.Connected := False;
    dmMain.connMain.ConnectionString := SetConnString('', '', dlgOpen.FileName);
    dmMain.connMain.Connected := True;
  end;

  dmMain.qryWords.Open;
  dmMain.qryVars.Open;

  imgPage.Picture.Bitmap := nil;
  imgPage.Canvas.Pen.Mode := pmMask;
  imgPage.Canvas.Font.Size := cFontSize;
  imgPage.Canvas.Font.Name := cFontName;
  TextOutWithResult(imgPage, dmMain.qryWords, dmMain.qryVars, True);
    dmMain.qryWords.Next;
  TextOutWithResult(imgPage, dmMain.qryWords, dmMain.qryVars, True);

  imgPage.Picture.Bitmap.Modified := False;
end;

procedure TfrmMain.N3Click(Sender: TObject);
begin
    dmMain.connMain.Connected := False;
end;


procedure TfrmMain.mnuBeginClick(Sender: TObject);
var
  frmQuestion: TfrmQuestion;
begin
  frmQuestion := TfrmQuestion.Create(self);
  frmQuestion.ShowModal;
  frmQuestion.Free;
end;

procedure TfrmMain.N10Click(Sender: TObject);
var
  ARectSrc: Trect;
begin
  ARectSrc := Rect(0, 0, 1000, 1000);
//  imgPage.Picture.Bitmap.Width := Printer.PageWidth - 30;
//  imgPage.Picture.Bitmap.Height := Printer.PageHeight - 30;
  imgPage.Canvas.Rectangle(ARectSrc);
  With Printer do
  begin
    BeginDoc;
//    Canvas.Rectangle(ARectSrc);
//    Canvas.Refresh;
    Canvas.CopyMode := cmSrcAnd;
    Canvas.CopyRect(ARectSrc, imgPage.Picture.Bitmap.Canvas, Rect(15, 15, Printer.PageWidth, Printer.PageHeight));
    Canvas.CopyMode := cmSrcCopy;
    EndDoc;
  end;
end;

procedure TfrmMain.N5Click(Sender: TObject);
begin
  Close;
end;

end.


