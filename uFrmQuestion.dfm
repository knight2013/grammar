object frmQuestion: TfrmQuestion
  Left = 107
  Top = 182
  BorderStyle = bsDialog
  Caption = #1058#1077#1089#1090#1080#1088#1086#1074#1072#1085#1080#1077
  ClientHeight = 130
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblN1: TLabel
    Left = 8
    Top = 24
    Width = 23
    Height = 20
    Caption = 'N1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblN: TLabel
    Left = 8
    Top = 40
    Width = 13
    Height = 20
    Caption = 'N'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblN2: TLabel
    Left = 8
    Top = 56
    Width = 23
    Height = 20
    Caption = 'N2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblP1: TLabel
    Left = 744
    Top = 24
    Width = 22
    Height = 20
    Caption = 'P1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblP: TLabel
    Left = 744
    Top = 40
    Width = 12
    Height = 20
    Caption = 'P'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblP2: TLabel
    Left = 744
    Top = 56
    Width = 22
    Height = 20
    Caption = 'P2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 0
    Top = 8
    Width = 34
    Height = 13
    Caption = #1053#1086#1084#1077#1088
  end
  object Label2: TLabel
    Left = 728
    Top = 8
    Width = 48
    Height = 13
    Caption = #1057#1090#1088#1072#1085#1080#1094#1072
  end
  object Label3: TLabel
    Left = 328
    Top = 8
    Width = 45
    Height = 13
    Caption = #1042#1086#1087#1088#1086#1089#1099
  end
  object Button1: TButton
    Left = 7
    Top = 93
    Width = 60
    Height = 28
    Caption = #1055#1088#1077#1088#1074#1072#1090#1100
    ModalResult = 3
    TabOrder = 0
  end
  object Button2: TButton
    Left = 647
    Top = 94
    Width = 60
    Height = 27
    Caption = #1053#1072#1079#1072#1076
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 712
    Top = 94
    Width = 60
    Height = 27
    Caption = #1042#1087#1077#1088#1077#1076
    TabOrder = 2
    OnClick = Button3Click
  end
  object grdQuestion: TStringGrid
    Left = 39
    Top = 45
    Width = 690
    Height = 20
    TabStop = False
    BorderStyle = bsNone
    ColCount = 7
    Ctl3D = False
    FixedColor = clWhite
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    Options = []
    ParentCtl3D = False
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 3
    OnDrawCell = grdQuestionDrawCell
    OnSelectCell = grdQuestionSelectCell
    ColWidths = (
      64
      64
      64
      64
      64
      64
      64)
  end
  object grdQuestion1: TStringGrid
    Left = 39
    Top = 26
    Width = 690
    Height = 19
    TabStop = False
    BorderStyle = bsNone
    ColCount = 7
    Ctl3D = False
    FixedColor = clBackground
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    Options = []
    ParentCtl3D = False
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 4
    OnDrawCell = grdQuestion1DrawCell
    OnSelectCell = grdQuestion1SelectCell
  end
  object grdQuestion2: TStringGrid
    Left = 39
    Top = 65
    Width = 690
    Height = 19
    TabStop = False
    BorderStyle = bsNone
    ColCount = 7
    Ctl3D = False
    FixedColor = clBackground
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    Options = []
    ParentCtl3D = False
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 5
    OnDrawCell = grdQuestion2DrawCell
    OnSelectCell = grdQuestion2SelectCell
  end
end
