object frmMain: TfrmMain
  Left = 171
  Top = 167
  Width = 760
  Height = 425
  Caption = 'frmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object wbMain: TWebBrowser
    Left = 0
    Top = 56
    Width = 752
    Height = 316
    Align = alClient
    TabOrder = 0
    OnDownloadComplete = wbMainDownloadComplete
    OnBeforeNavigate2 = wbMainBeforeNavigate2
    ControlData = {
      4C000000B94D0000A92000000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126201000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 372
    Width = 752
    Height = 19
    Panels = <
      item
        Text = #1057#1090#1088#1072#1085#1080#1094#1072':'
        Width = 100
      end
      item
        Text = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
        Width = 250
      end
      item
        Text = #1054#1090#1082#1088#1099#1090' '#1088#1077#1079#1091#1083#1100#1090#1072#1090' '#1076#1083#1103':'
        Width = 300
      end
      item
        Width = 50
      end>
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 752
    Height = 56
    AutoSize = True
    Bands = <
      item
        Break = False
        Control = ActionMainMenuBar1
        HorizontalOnly = True
        ImageIndex = -1
        MinWidth = 150
        Width = 748
      end
      item
        Control = ToolBar1
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 22
        MinWidth = 150
        Width = 436
      end
      item
        Break = False
        Control = pnlBegin
        ImageIndex = -1
        MinWidth = 141
        Width = 154
      end
      item
        Break = False
        Control = pnlRemain
        HorizontalOnly = True
        ImageIndex = -1
        MinWidth = 141
        Width = 154
      end>
    OnChange = CoolBar1Change
    object ToolBar1: TToolBar
      Left = 9
      Top = 28
      Width = 423
      Height = 22
      ButtonHeight = 21
      ButtonWidth = 56
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      ParentShowHint = False
      ShowCaptions = True
      ShowHint = True
      TabOrder = 0
      object ToolButton2: TToolButton
        Left = 0
        Top = 0
        Action = actBack
      end
      object ToolButton1: TToolButton
        Left = 56
        Top = 0
        Action = actNext
      end
      object ToolButton4: TToolButton
        Left = 112
        Top = 0
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object ToolButton3: TToolButton
        Left = 120
        Top = 0
        Action = actRefresh
      end
    end
    object ActionMainMenuBar1: TActionMainMenuBar
      Left = 9
      Top = 0
      Width = 735
      Height = 25
      UseSystemFont = False
      ActionManager = ActionManager1
      Caption = 'ActionMainMenuBar1'
      ColorMap.HighlightColor = 15660791
      ColorMap.BtnSelectedColor = clBtnFace
      ColorMap.UnusedColor = 15660791
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = True
      ParentColor = True
      Spacing = 0
    end
    object Panel1: TPanel
      Left = 9
      Top = 0
      Width = 735
      Height = 25
      BevelOuter = bvNone
      TabOrder = 2
    end
    object pnlRemain: TPanel
      Left = 603
      Top = 27
      Width = 141
      Height = 25
      Alignment = taRightJustify
      BevelOuter = bvNone
      Caption = #1054#1089#1090#1072#1083#1086#1089#1100': 00:45:00'
      TabOrder = 3
    end
    object pnlBegin: TPanel
      Left = 447
      Top = 27
      Width = 141
      Height = 25
      Alignment = taRightJustify
      BevelOuter = bvNone
      Caption = #1053#1072#1095#1072#1083#1086': 00:45:00'
      TabOrder = 4
    end
  end
  object ActionList1: TActionList
    Left = 632
    Top = 88
    object actReg: TAction
      Category = #1060#1072#1081#1083
      Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
      Hint = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      OnExecute = actRegExecute
    end
    object actBegin: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = #1053#1072#1095#1072#1090#1100' '#1090#1077#1089#1090
      OnExecute = actBeginExecute
    end
    object actOpenResult: TAction
      Category = #1060#1072#1081#1083
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090
      OnExecute = actOpenResultExecute
    end
    object actExit: TAction
      Category = #1060#1072#1081#1083
      Caption = #1042#1099#1093#1086#1076
      OnExecute = actExitExecute
    end
    object actPrint: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = #1055#1077#1095#1072#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072
      OnExecute = actPrintExecute
    end
    object actExport: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' HTML'
      OnExecute = actExportExecute
    end
    object actSaveResult: TAction
      Category = #1060#1072#1081#1083
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090
      OnExecute = actSaveResultExecute
    end
    object actOptions: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
    end
    object actNext: TAction
      Category = #1057#1090#1088#1072#1085#1080#1094#1072
      Caption = #1042#1087#1077#1088#1077#1076
      Enabled = False
      Hint = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1089#1090#1088#1072#1085#1080#1094#1072
      OnExecute = Button3Click
    end
    object actBack: TAction
      Category = #1057#1090#1088#1072#1085#1080#1094#1072
      Caption = #1053#1072#1079#1072#1076
      Enabled = False
      Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1089#1090#1088#1072#1085#1080#1094#1072
      OnExecute = Button2Click
    end
    object actRefresh: TAction
      Category = #1057#1090#1088#1072#1085#1080#1094#1072
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Enabled = False
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1090#1088#1072#1085#1080#1094#1091
      OnExecute = btnRefreshClick
    end
    object actAbout: TAction
      Category = '?'
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      OnExecute = actAboutExecute
    end
    object actCheck: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
      OnExecute = actCheckExecute
    end
    object actStop: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = #1055#1088#1077#1088#1074#1072#1090#1100' '#1090#1077#1089#1090
      Enabled = False
      OnExecute = actStopExecute
    end
  end
  object XPManifest1: TXPManifest
    Left = 504
    Top = 88
  end
  object dlgOpen: TOpenDialog
    Filter = '*.dat'
    Left = 568
    Top = 88
  end
  object ppMain: TPageProducer
    ScriptEngine = 'JScript'
    Left = 536
    Top = 88
  end
  object imgMain: TImageList
    Left = 664
    Top = 88
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Items = <
              item
                Action = actReg
              end
              item
                Action = actOpenResult
              end
              item
                Action = actSaveResult
              end
              item
                Action = actExit
              end>
            Caption = #1060#1072#1081#1083
          end
          item
            Items = <
              item
                Action = actBegin
              end
              item
                Action = actStop
              end
              item
                Action = actCheck
              end
              item
                Action = actPrint
              end
              item
                Action = actExport
                Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' &HTML'
              end
              item
                Action = actOptions
              end>
            Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
          end
          item
            Items = <
              item
                Action = actNext
              end
              item
                Action = actBack
              end
              item
                Action = actRefresh
              end>
            Caption = #1057#1090#1088#1072#1085#1080#1094#1072
          end
          item
            Items = <
              item
                Action = actAbout
              end>
            Caption = '?'
          end>
        ActionBar = ActionMainMenuBar1
      end>
    LinkedActionLists = <
      item
        ActionList = ActionList1
        Caption = 'ActionList1'
      end>
    Left = 601
    Top = 91
    StyleName = 'XP Style'
    object Action1: TAction
      Category = #1060#1072#1081#1083
      Caption = 'Action1'
    end
    object Action2: TAction
      Category = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Caption = 'Action2'
    end
    object Action3: TAction
      Category = #1057#1090#1088#1072#1085#1080#1094#1072
      Caption = 'Action3'
    end
    object Action4: TAction
      Category = '?'
      Caption = 'Action4'
    end
  end
  object tmrMain: TTimer
    Enabled = False
    OnTimer = tmrMainTimer
    Left = 472
    Top = 88
  end
end
