unit dmMain;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDm = class(TDataModule)
    connMain: TADOConnection;
    qryWords: TADOQuery;
    qryWordsword_id: TAutoIncField;
    qryWordsword_page: TIntegerField;
    qryWordsword_number1: TIntegerField;
    qryWordsword_number2: TWideStringField;
    qryWordsword_begin: TWideStringField;
    qryWordsword_end: TWideStringField;
    qryWordsword_to_choiced: TIntegerField;
    qryVars: TADOQuery;
    qryVarsvariant_id: TAutoIncField;
    qryVarsword_id: TIntegerField;
    qryVarsvariant_number: TIntegerField;
    qryVarsvariant_word: TWideStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dm: TDm;

implementation

{$R *.dfm}

end.
