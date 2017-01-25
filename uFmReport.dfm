object fmReport: TfmReport
  Left = 288
  Top = 209
  Width = 619
  Height = 238
  Caption = 'fmReport'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object imgTemp: TImage
    Left = 24
    Top = 56
    Width = 153
    Height = 25
  end
  object frMain: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    Left = 24
    Top = 24
    ReportForm = {18000000}
  end
  object frdsVars: TfrDBDataSet
    DataSet = dmMain.qryVars
    Left = 88
    Top = 24
  end
  object frdsWords: TfrDBDataSet
    DataSet = dmMain.qryWords
    Left = 56
    Top = 24
  end
end
