unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, XPMan, DB, ADODB, ExtCtrls,
  FR_Class, XPStyleActnCtrls, ActnList, ActnMan, ToolWin, ActnCtrls,
  ActnMenus, ExtActns, StdActns, ComCtrls, Menus;

type
  TForm1 = class(TForm)
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
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    ScrollBox1: TScrollBox;
    imgPage: TImage;
    procedure Button1Click(Sender: TObject);
    procedure WebBrowser1BeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var Flags: OleVariant;
  page: System.Text;
begin
end;

procedure TForm1.WebBrowser1BeforeNavigate2(Sender: TObject;
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

end.

