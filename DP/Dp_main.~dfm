object fr_main_dp: Tfr_main_dp
  Left = 195
  Top = 208
  Width = 696
  Height = 480
  Caption = 'Перекачка данных'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 419
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 186
      Top = 22
      Width = 3
      Height = 396
      Cursor = crHSplit
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 686
      Height = 21
      Align = alTop
      Caption = 'Объединение данных из разных БД'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 1
      Top = 22
      Width = 185
      Height = 396
      Align = alLeft
      TabOrder = 1
      object bt_make: TButton
        Left = 6
        Top = 364
        Width = 71
        Height = 25
        Caption = 'Перелить!'
        TabOrder = 0
        OnClick = bt_makeClick
      end
    end
    object Panel4: TPanel
      Left = 189
      Top = 22
      Width = 498
      Height = 396
      Align = alClient
      TabOrder = 2
      object Splitter2: TSplitter
        Left = 1
        Top = 211
        Width = 496
        Height = 3
        Cursor = crVSplit
        Align = alTop
      end
      object Panel5: TPanel
        Left = 1
        Top = 1
        Width = 496
        Height = 210
        Align = alTop
        BevelOuter = bvLowered
        TabOrder = 0
        object Label1: TLabel
          Left = 6
          Top = 6
          Width = 81
          Height = 20
          Caption = 'Источник'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ed_source: TFilenameEdit
          Left = 6
          Top = 28
          Width = 255
          Height = 21
          Filter = 'Все файлы (*.*)|*.*|DB|*.gdb'
          NumGlyphs = 1
          TabOrder = 0
          Text = '*.gdb'
        end
        object ls_source: TListBox
          Left = 268
          Top = 1
          Width = 227
          Height = 208
          Align = alRight
          ItemHeight = 13
          TabOrder = 1
        end
        object sw_source: TRxSwitch
          Left = 8
          Top = 56
          Width = 50
          Height = 60
          Caption = 'sw_source'
          TabOrder = 2
          OnOn = sw_sourceOn
          OnOff = sw_sourceOff
        end
      end
      object Panel6: TPanel
        Left = 1
        Top = 214
        Width = 496
        Height = 181
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 1
        object Label2: TLabel
          Left = 6
          Top = 8
          Width = 85
          Height = 20
          Caption = 'Приемник'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ed_target: TFilenameEdit
          Left = 6
          Top = 30
          Width = 255
          Height = 21
          Filter = 'Все файлы (*.*)|*.*|DB|*.gdb'
          NumGlyphs = 1
          TabOrder = 0
          Text = '*.gdb'
        end
        object ls_targer: TListBox
          Left = 268
          Top = 1
          Width = 227
          Height = 179
          Align = alRight
          ItemHeight = 13
          TabOrder = 1
        end
        object sw_target: TRxSwitch
          Left = 8
          Top = 58
          Width = 50
          Height = 60
          Caption = 'sw_target'
          TabOrder = 2
          OnOn = sw_targetOn
          OnOff = sw_targetOff
        end
      end
    end
  end
  object BitBtn1: TBitBtn
    Left = 4
    Top = 426
    Width = 81
    Height = 25
    Caption = 'Выход'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkClose
  end
  object DB_s: TIBDatabase
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 284
    Top = 25
  end
  object tr_s: TIBTransaction
    Active = False
    DefaultDatabase = DB_s
    Left = 316
    Top = 25
  end
  object q_source: TIBQuery
    Database = DB_s
    Transaction = tr_s
    CachedUpdates = False
    Left = 352
    Top = 25
  end
  object DB_t: TIBDatabase
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 290
    Top = 240
  end
  object tr_t: TIBTransaction
    Active = False
    DefaultDatabase = DB_t
    Left = 322
    Top = 240
  end
  object q_target: TIBQuery
    Database = DB_t
    Transaction = tr_t
    CachedUpdates = False
    Left = 360
    Top = 240
  end
end
