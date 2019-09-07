object fr_find: Tfr_find
  Left = 455
  Top = 128
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Поиск объекта'
  ClientHeight = 423
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 480
    Height = 389
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 12
      Top = 158
      Width = 36
      Height = 16
      Caption = 'Код :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 234
      Top = 158
      Width = 38
      Height = 16
      Caption = 'Имя :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 478
      Height = 21
      Align = alTop
      Caption = 'Составление условия поиска:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object rg_objects: TRadioGroup
      Left = 1
      Top = 22
      Width = 478
      Height = 77
      Align = alTop
      Caption = 'ОБЪЕКТЫ : '
      Columns = 2
      ItemIndex = 7
      Items.Strings = (
        'НС'
        'КНС'
        'куст скважин'
        'скважина'
        'насосный агрегат'
        'водовод'
        'задвижка'
        'узел')
      TabOrder = 1
      OnClick = rg_objectsClick
    end
    object RadioGroup1: TRadioGroup
      Left = 1
      Top = 99
      Width = 478
      Height = 48
      Align = alTop
      Caption = 'Поиск по свойству объекта: '
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Код ID'
        'Имени объекта')
      TabOrder = 2
      OnClick = RadioGroup1Click
    end
    object ed_id: TRxSpinEdit
      Left = 60
      Top = 154
      Width = 103
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object ed_name: TEdit
      Left = 290
      Top = 156
      Width = 179
      Height = 21
      Enabled = False
      TabOrder = 4
    end
    object gr_result: TDBGrid
      Left = 1
      Top = 246
      Width = 478
      Height = 142
      Align = alBottom
      DataSource = ds_find
      Options = [dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 5
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object bt_find: TBitBtn
    Left = 4
    Top = 394
    Width = 89
    Height = 25
    Caption = 'Найти'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = bt_findClick
  end
  object bt_exit: TBitBtn
    Left = 397
    Top = 394
    Width = 79
    Height = 25
    Caption = 'Выход'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = bt_exitClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
      03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
      0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
      0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
      0333337F777FFFFF7F3333000000000003333377777777777333}
    NumGlyphs = 2
  end
  object bt_goto_object: TButton
    Left = 162
    Top = 394
    Width = 125
    Height = 25
    Caption = 'Перейти к объекту'
    TabOrder = 3
    OnClick = bt_goto_objectClick
  end
  object cds_find: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 396
    Top = 204
  end
  object ds_find: TDataSource
    DataSet = cds_find
    Left = 346
    Top = 206
  end
end
