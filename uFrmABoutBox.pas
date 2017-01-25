unit uFrmABoutBox;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

uses uFrmMain;

{$R *.dfm}

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  ProductName.Caption := cAppName;
  Version.Caption := 'ред. ' + cAppVer;
  Copyright.Caption := 'soft_of_AVI (C) 2004';
  Comments.Caption := 'avi_udp@mail.ru';
end;

end.
 
