unit UnFrmQuestion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, DB;

type
  TfrmQuestion = class(TForm)
    btnPrev: TButton;
    btnNext: TButton;
    lblBegin: TDBText;
    lblEnd: TDBText;
    dsWords: TDataSource;
    dsVars: TDataSource;
    cbxVars: TDBLookupComboBox;
    lblPage: TDBText;
    Label1: TLabel;
    lblNumber: TDBText;
    Label2: TLabel;
    lblAnswer: TDBText;
    Label3: TLabel;
    btnExit: TButton;
    Label4: TLabel;
    lblVars: TDBText;
    procedure btnNextClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure dsWordsDataChange(Sender: TObject; Field: TField);
    procedure dsVarsDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQuestion: TfrmQuestion;

implementation

{$R *.dfm}



procedure TfrmQuestion.btnNextClick(Sender: TObject);
begin
  dsWords.DataSet.Next;
end;

procedure TfrmQuestion.btnPrevClick(Sender: TObject);
begin
  dsWords.DataSet.Prior;
end;

procedure TfrmQuestion.btnExitClick(Sender: TObject);
begin
  if MessageBox(Handle, 'Вы точно хотите прервать тест?', PChar(Application.Title), MB_YESNOCANCEL) = ID_YES then Close;
end;

procedure TfrmQuestion.dsWordsDataChange(Sender: TObject; Field: TField);
begin
  lblVars.Left := lblBegin.Left + lblBegin.Width + 8;
  lblEnd.Left := lblVars.Left + lblVars.Width + 8;
end;

procedure TfrmQuestion.dsVarsDataChange(Sender: TObject; Field: TField);
begin
  lblVars.Left := lblBegin.Left + lblBegin.Width + 8;
  lblEnd.Left := lblVars.Left + lblVars.Width + 8;
end;

end.


