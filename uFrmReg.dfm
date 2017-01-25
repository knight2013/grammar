object frmReg: TfrmReg
  Left = 374
  Top = 207
  BorderStyle = bsDialog
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
  ClientHeight = 118
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 14
    Width = 95
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1089#1074#1086#1077' '#1080#1084#1103':'
  end
  object Label2: TLabel
    Left = 9
    Top = 54
    Width = 41
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100':'
  end
  object cbxUserName: TComboBox
    Left = 113
    Top = 14
    Width = 163
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Text = #1053#1086#1074#1099#1081' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    Items.Strings = (
      #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088)
  end
  object Button1: TButton
    Left = 148
    Top = 76
    Width = 61
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 212
    Top = 76
    Width = 60
    Height = 29
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object edtPassword: TEdit
    Left = 112
    Top = 48
    Width = 161
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
    Text = 'edtPassword'
  end
end
