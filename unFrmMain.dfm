object frmMain: TfrmMain
  Left = 143
  Top = 117
  Width = 736
  Height = 564
  Caption = 'frmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mnuMain
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object StatusBar1: TStatusBar
    Left = 0
    Top = 474
    Width = 728
    Height = 25
    Panels = <>
  end
  object scrlMain: TScrollBox
    Left = 0
    Top = 0
    Width = 728
    Height = 474
    HorzScrollBar.Range = 1000
    HorzScrollBar.Tracking = True
    VertScrollBar.Range = 1000
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Align = alClient
    AutoScroll = False
    TabOrder = 1
    object imgPage: TImage
      Left = 0
      Top = -8
      Width = 1000
      Height = 1000
      AutoSize = True
      IncrementalDisplay = True
      Proportional = True
      Stretch = True
    end
    object imgCheck: TImage
      Left = 656
      Top = 216
      Width = 12
      Height = 12
      Picture.Data = {
        07544269746D61706E000000424D6E000000000000003E000000280000000C00
        00000C0000000100010000000000300000000000000000000000020000000000
        000000000000FFFFFF00FFF00000EFF00000E7F00000C7F00000C3F0000099F0
        000099F00000FCF00000FE700000FF700000FFB00000FFF00000}
      Transparent = True
      Visible = False
    end
  end
  object XPManifest: TXPManifest
    Left = 656
    Top = 64
  end
  object dlgPrint: TPrintDialog
    Left = 656
    Top = 96
  end
  object mnuMain: TMainMenu
    Left = 656
    Top = 136
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N2: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100'...'
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = #1047#1072#1082#1088#1099#1090#1100
        OnClick = N3Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object N5: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = N5Click
      end
    end
    object N6: TMenuItem
      Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      object mnuBegin: TMenuItem
        Caption = #1053#1072#1095#1072#1090#1100' '#1090#1077#1089#1090
        OnClick = mnuBeginClick
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object N7: TMenuItem
        Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
        object N10: TMenuItem
          Caption = #1055#1077#1095#1072#1090#1100
          OnClick = N10Click
        end
        object N11: TMenuItem
          Caption = #1069#1082#1089#1087#1086#1088#1090
        end
      end
    end
    object N12: TMenuItem
      Caption = '?'
      object N13: TMenuItem
        Caption = #1055#1086#1084#1086#1097#1100
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object N14: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      end
    end
  end
  object dlgOpen: TOpenDialog
    DefaultExt = '*.mdb'
    Filter = #1060#1072#1081#1083#1099' Grammar|*.mdb'
    InitialDir = 'db'
    Left = 656
    Top = 176
  end
  object dlgPrinterSetup: TPrinterSetupDialog
    Left = 656
    Top = 240
  end
end
