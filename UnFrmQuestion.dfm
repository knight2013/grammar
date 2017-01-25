object frmQuestion: TfrmQuestion
  Left = 235
  Top = 207
  Width = 692
  Height = 315
  Caption = 'frmQuestion'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object lblBegin: TDBText
    Left = 48
    Top = 120
    Width = 49
    Height = 16
    AutoSize = True
    DataField = 'word_begin'
    DataSource = dsWords
  end
  object lblEnd: TDBText
    Left = 256
    Top = 120
    Width = 38
    Height = 16
    AutoSize = True
    DataField = 'word_end'
    DataSource = dsWords
  end
  object lblPage: TDBText
    Left = 176
    Top = 8
    Width = 47
    Height = 16
    AutoSize = True
    DataField = 'word_page'
    DataSource = dsWords
  end
  object Label1: TLabel
    Left = 88
    Top = 8
    Width = 81
    Height = 16
    Caption = #1057#1090#1088#1072#1085#1080#1094#1072' '#8470
  end
  object lblNumber: TDBText
    Left = 176
    Top = 24
    Width = 62
    Height = 16
    AutoSize = True
    DataField = 'word_number1'
    DataSource = dsWords
  end
  object Label2: TLabel
    Left = 104
    Top = 24
    Width = 65
    Height = 16
    Caption = #1042#1086#1087#1088#1086#1089' '#8470
  end
  object lblAnswer: TDBText
    Left = 176
    Top = 40
    Width = 58
    Height = 16
    AutoSize = True
    DataField = 'word_to_choiced'
    DataSource = dsWords
  end
  object Label3: TLabel
    Left = 88
    Top = 40
    Width = 84
    Height = 16
    Caption = #1042#1072#1096' '#1086#1090#1074#1077#1090' '#8470
  end
  object Label4: TLabel
    Left = 88
    Top = 56
    Width = 175
    Height = 16
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1074#1072#1088#1080#1072#1085#1090' '#1086#1090#1074#1077#1090#1072':'
  end
  object lblVars: TDBText
    Left = 152
    Top = 120
    Width = 50
    Height = 16
    AutoSize = True
    DataField = 'variant_word'
    DataSource = dsVars
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnPrev: TButton
    Left = 504
    Top = 232
    Width = 75
    Height = 25
    Caption = #1053#1072#1079#1072#1076
    TabOrder = 0
    OnClick = btnPrevClick
  end
  object btnNext: TButton
    Left = 592
    Top = 232
    Width = 75
    Height = 25
    Caption = #1042#1087#1077#1088#1077#1076
    TabOrder = 1
    OnClick = btnNextClick
  end
  object cbxVars: TDBLookupComboBox
    Left = 272
    Top = 48
    Width = 145
    Height = 24
    DataField = 'word_to_choiced'
    DataSource = dsWords
    KeyField = 'variant_number'
    ListField = 'variant_word'
    ListSource = dsVars
    TabOrder = 2
  end
  object btnExit: TButton
    Left = 16
    Top = 232
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = btnExitClick
  end
  object dsWords: TDataSource
    DataSet = dmMain.qryWords
    OnDataChange = dsWordsDataChange
    Left = 8
    Top = 8
  end
  object dsVars: TDataSource
    DataSet = dmMain.qryVars
    OnDataChange = dsVarsDataChange
    Left = 40
    Top = 8
  end
end
