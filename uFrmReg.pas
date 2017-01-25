unit uFrmReg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmReg = class(TForm)
    cbxUserName: TComboBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    edtPassword: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReg: TfrmReg;

implementation

{$R *.dfm}

end.
