object frmReport: TfrmReport
  Left = 70
  Top = 144
  Width = 596
  Height = 390
  Caption = 'frmReport'
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object frMain: TfrReport
    InitialZoom = pzDefault
    ModalPreview = False
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    OnBeginBand = frMainBeginBand
    OnGetValue = frMainGetValue
    Left = 24
    Top = 24
    ReportForm = {18000000}
  end
end
