object dmMain: TdmMain
  OldCreateOrder = False
  Left = 427
  Top = 496
  Height = 245
  Width = 313
  object connMain: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;Data Source='#1041#1072#1079#1072' ' +
      #1076#1072#1085#1085#1099#1093' MS Access;Initial Catalog=.\db\grammar.mdb'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Left = 40
    Top = 56
  end
  object qryWords: TADOQuery
    Connection = connMain
    Parameters = <>
    SQL.Strings = (
      'select * from WORDS')
    Left = 121
    Top = 56
    object qryWordsword_id: TAutoIncField
      FieldName = 'word_id'
      ReadOnly = True
    end
    object qryWordsword_page: TIntegerField
      FieldName = 'word_page'
    end
    object qryWordsword_number1: TIntegerField
      FieldName = 'word_number1'
    end
    object qryWordsword_number2: TWideStringField
      FieldName = 'word_number2'
      Size = 3
    end
    object qryWordsword_begin: TWideStringField
      FieldName = 'word_begin'
      Size = 100
    end
    object qryWordsword_end: TWideStringField
      FieldName = 'word_end'
      Size = 100
    end
    object qryWordsword_to_choiced: TIntegerField
      FieldName = 'word_to_choiced'
    end
  end
  object qryVars: TADOQuery
    Connection = connMain
    CursorType = ctStatic
    DataSource = dsWords
    Parameters = <
      item
        Name = 'word_id'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'select * from VARIANTS'
      'where word_id = :word_id')
    Left = 201
    Top = 48
    object qryVarsvariant_id: TAutoIncField
      FieldName = 'variant_id'
      ReadOnly = True
    end
    object qryVarsword_id: TIntegerField
      FieldName = 'word_id'
    end
    object qryVarsvariant_number: TIntegerField
      FieldName = 'variant_number'
    end
    object qryVarsvariant_word: TWideStringField
      FieldName = 'variant_word'
      Size = 50
    end
  end
  object dsWords: TDataSource
    DataSet = qryWords
    Left = 72
    Top = 24
  end
end
