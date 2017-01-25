unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, XPStyleActnCtrls, ActnMan, ToolWin, ActnCtrls,
  ActnMenus, XPMan, Grids, Menus, HTTPApp, HTTPProd, OleCtrls, SHDocVw, uMdlBase,
  StdCtrls, ComCtrls, ImgList, ExtCtrls;

type
  TfrmMain = class(TForm)
    ActionList1: TActionList;
    actReg: TAction;
    actBegin: TAction;
    actOpenResult: TAction;
    actSaveResult: TAction;
    actExit: TAction;
    actPrint: TAction;
    actExport: TAction;
    XPManifest1: TXPManifest;
    actOptions: TAction;
    dlgOpen: TOpenDialog;
    wbMain: TWebBrowser;
    ppMain: TPageProducer;
    StatusBar1: TStatusBar;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    actNext: TAction;
    actBack: TAction;
    actRefresh: TAction;
    imgMain: TImageList;
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionManager1: TActionManager;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    actAbout: TAction;
    Action4: TAction;
    actCheck: TAction;
    Panel1: TPanel;
    actStop: TAction;
    tmrMain: TTimer;
    pnlRemain: TPanel;
    pnlBegin: TPanel;
    procedure actRegExecute(Sender: TObject);
    procedure actBeginExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actSaveResultExecute(Sender: TObject);
    procedure actOpenResultExecute(Sender: TObject);
    procedure wbMainBeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure wbMainDownloadComplete(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actCheckExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
    procedure actStopExecute(Sender: TObject);
    procedure tmrMainTimer(Sender: TObject);
    procedure CoolBar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cAppName = 'Grammar';
  cAppVer = '2.2 beta';
  cMaxPage = 1;
  cTestTime = '00:00:45';

var
  frmMain: TfrmMain;
  UserName: string;
  vPathApp: string;
  UserFullAccess: boolean = False;
  vCancel: boolean;
  vBegin, vTime: TTime;



implementation

uses uFrmReg, uFrmQuestion, uFrmReport, Math, uFrmABoutBox;

{$R *.dfm}

procedure TfrmMain.actRegExecute(Sender: TObject);
begin
  actSaveResult.Enabled := False;
  actOpenResult.Enabled := False;
  actPrint.Enabled := False;
  actExport.Enabled := False;
  actOptions.Enabled := False;
  actBegin.Enabled := False;
  actCheck.Enabled := False;

 if frmReg.ShowModal = mrOK then
   begin
     UserName := frmReg.cbxUserName.Text;
     UserFullAccess :=False;
     if (UserName = 'Администратор') and (frmReg.edtPassword.Text = '1977' ) then
       begin
         UserFullAccess := True;
         actSaveResult.Enabled := True;
         actOpenResult.Enabled := True;
         actPrint.Enabled := True;
         actExport.Enabled := True;
         actOptions.Enabled := True;
         actBegin.Enabled := True;
         actCheck.Enabled := True;
       end;
    actSaveResult.Enabled := True;
    actBegin.Enabled := True;
   end;
  StatusBar1.Panels[1].Text := 'Пользователь: ' + UserName;
  StatusBar1.Panels[2].Text := 'Результат пользователя: ' + UserName;
end;

procedure TfrmMain.actBeginExecute(Sender: TObject);
var i: integer;
begin
  vBegin := StrToTime(TimeToStr(Now));
  vTime := StrToTime(cTestTime);

  pnlBegin.Caption := 'Начало: '+FormatDateTime('hh:nn:ss', vBegin);

  actBegin.Enabled := False;
// actStop.Enabled := True;


  for i := 1 to 150 do ArrayAnswer[i] := 0;

  PagePos := 1;
  SetPageToHTML(vPathApp, UserName, PagePos, FileBase, ArrayAnswer);
  vCancel := False;
  wbMain.Navigate(vPathApp + 'page.htm');
  vCancel := True;

  if not UserFullAccess then tmrMain.Enabled := True;
end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.actPrintExecute(Sender: TObject);
var tempStr: string;
begin
   AssignFile(FileBase, vPathApp+ 'base#.txt');
   Reset(FileBase);
   QuestPos := 1;
   FilePos := 0;
   Readln(FileBase, tempStr);

   frmReport.Font.Name := 'Arial';
   frmReport.Font.Size := 10;

   frmReport.frMain.LoadFromFile(vPathApp+'main.frf');
   frmReport.frMain.ShowReport;
   CloseFile(FileBase);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  frmMain.Caption := cAppName + ' ред.' + cAppVer;
  Application.Title := frmMain.Caption;
  vPathApp := ExtractFilePath(Application.ExeName);

  actOpenResult.Enabled := False;
  actPrint.Enabled := False;
  actExport.Enabled := False;
  actOptions.Enabled := False;
  actBegin.Enabled := False;


end;

procedure TfrmMain.actSaveResultExecute(Sender: TObject);
var AFileName: string;
    i: integer;
begin
 AFileName := vPathApp + 'Answer\'+UserName+'.dat';
 if FileExists(AFileName) then
  if MessageBox(Handle, PChar('Файл уже существует под именем ' + UserName + '. Вы точно хотите заменить сохраненные данные?'), PChar(Application.Title), MB_YesNo) <> ID_YES
    then Exit;

      AssignFile(FileAnswer, AFileName);
      ReWrite(FileAnswer);
      For i := 1 to 150 do
        Write(FileAnswer, ArrayAnswer[i]);
      CloseFile(FileAnswer);

  ShowMessage('Файл записан под именем : ' + #13 + AFileName);
end;

procedure TfrmMain.actOpenResultExecute(Sender: TObject);
var ADirName: string;
    i: integer;
    s: string[1];
begin
 ADirName := vPathApp + 'Answer';
 dlgOpen.InitialDir := ADirName;
 if dlgOpen.Execute = True then
   begin
      AssignFile(FileAnswer, dlgOpen.FileName);
      Reset(FileAnswer);
      For i := 1 to 150 do
       begin
        Read(FileAnswer, s);
       ArrayAnswer[i] := StrToInt(s);
       end;
      CloseFile(FileAnswer);
   end;
 actRefresh.Execute;
 StatusBar1.Panels[2].Text := 'Результат пользователя: ' + Copy(ExtractFileName(dlgOpen.FileName), 1, length(ExtractFileName(dlgOpen.FileName))-4);;
end;


procedure TfrmMain.wbMainBeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
begin
  SetAnswerToArray(VarToStr(URL), ArrayAnswer);
  Cancel := vCancel;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  if PagePos + 1 > cMaxPage then Exit;
  PagePos := PagePos + 1;
  SetPageToHTML(vPathApp, UserName, PagePos, FileBase, ArrayAnswer);
  vCancel := False;
  wbMain.Navigate(vPathApp + 'page.htm'); wbMain.Refresh2;
  vCancel := True;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  if PagePos - 1 < 1 then Exit;
  PagePos := PagePos - 1;
  SetPageToHTML(vPathApp, UserName, PagePos, FileBase, ArrayAnswer);
  vCancel := False;
  wbMain.Navigate(vPathApp + 'page.htm'); wbMain.Refresh2;
  vCancel := True;
end;

procedure TfrmMain.btnRefreshClick(Sender: TObject);
begin
  SetPageToHTML(vPathApp, UserName, PagePos, FileBase, ArrayAnswer);
  vCancel := False;
  wbMain.Navigate(vPathApp + 'page.htm'); wbMain.Refresh2;
  vCancel := True;
end;

procedure TfrmMain.wbMainDownloadComplete(Sender: TObject);
begin
  actNext.Enabled := True;
  actBack.Enabled := True;
  actRefresh.Enabled := True;

  StatusBar1.Panels[0].Text := 'Страница: ' + IntToStr(PagePos);
end;

procedure TfrmMain.actAboutExecute(Sender: TObject);
begin
  AboutBox := TAboutBox.Create(self);
  AboutBox.ShowModal;
  AboutBox.Free;
end;

procedure TfrmMain.actCheckExecute(Sender: TObject);
var AFileName: string;
    i: integer;
    s: string[1];
    vRight: integer;
    vUser: string;
begin
 vRight := -50;
 AFileName := vPathApp + 'base$.txt';
     AssignFile(FileAnswer, AFileName);
      Reset(FileAnswer);
      For i := 1 to 150 do
       begin
        Read(FileAnswer, s);
        if ArrayAnswer[i] = StrToInt(s) then vRight := vRight + 1;
       end;
  CloseFile(FileAnswer);
  vUser :=  Copy(ExtractFileName(dlgOpen.FileName), 1, length(ExtractFileName(dlgOpen.FileName))-4);
  ShowMessage('Результат пользователя ' + vUser + ': ' + #13 + IntToStr(vRight) + ' из 100');
end;

procedure TfrmMain.actExportExecute(Sender: TObject);
var AFileName: string;
    i: integer;
    vUser: string;
begin
 vUser :=  Copy(ExtractFileName(dlgOpen.FileName), 1, length(ExtractFileName(dlgOpen.FileName))-4);

 AFileName := vPathApp + 'Export\'+vUser+'.htm';
 if FileExists(AFileName) then
  if MessageBox(Handle, PChar('Файл уже существует под именем ' + vUser + '. Вы точно хотите заменить сохраненные данные?'), PChar(Application.Title), MB_YesNo) <> ID_YES
    then Exit;

   CopyFile(PChar(vPathApp + 'page.htm'),  PChar(AFileName), False);
   ShowMessage('Файл экспортирован под именем : ' + #13 + AFileName);
end;


procedure TfrmMain.actStopExecute(Sender: TObject);
begin
  actBegin.Enabled := True;
  actStop.Enabled := False;
  tmrMain.Enabled := False;
end;

procedure TfrmMain.tmrMainTimer(Sender: TObject);
begin
  vTime := vTime - StrToTime('00:00:01');
  pnlRemain.Caption := 'Осталось: '+FormatDateTime('hh:nn:ss', vTime);

  if vTime <= StrToTime('00:00:00') then
    begin
      actStop.Execute;
      tmrMain.Enabled := False;
      actReg.Enabled := False;

      ShowMessage('Время, отведенное на тест закончилось!!!');
    end;
end;

procedure TfrmMain.CoolBar1Change(Sender: TObject);
begin
  pnlBegin.Left := pnlRemain.Left + 10;
end;

end.
