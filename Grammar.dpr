program Grammar;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {frmMain},
  uFrmReg in 'uFrmReg.pas' {frmReg},
  uFrmQuestion in 'uFrmQuestion.pas' {frmQuestion},
  uFrmReport in 'uFrmReport.pas' {frmReport},
  uMdlBase in 'uMdlBase.pas',
  uFrmABoutBox in 'uFrmABoutBox.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmReg, frmReg);
  Application.CreateForm(TfrmReport, frmReport);
  Application.Run;
end.
