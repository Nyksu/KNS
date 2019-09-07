object fr_shop_dep: Tfr_shop_dep
  Left = 357
  Top = 155
  BorderStyle = bsSingle
  Caption = 'Цех - месторождение'
  ClientHeight = 486
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 472
    Height = 453
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 470
      Height = 21
      Align = alTop
      Caption = 'Связь цехов с месторождениями'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object gr_shop_dep: TDBGrid
      Left = 6
      Top = 294
      Width = 461
      Height = 152
      DataSource = ds_dep_shop
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'dp_sh'
          Title.Alignment = taCenter
          Title.Caption = 'Связь Цеха с Месторождением'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -13
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 438
          Visible = True
        end>
    end
    object gr_dep: TDBGrid
      Left = 239
      Top = 34
      Width = 226
      Height = 219
      DataSource = ds_dep
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Alignment = taCenter
          Title.Caption = 'Месторождение'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 202
          Visible = True
        end>
    end
    object gr_shop: TDBGrid
      Left = 6
      Top = 34
      Width = 226
      Height = 219
      DataSource = ds_shop
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'Цех'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clGreen
          Title.Font.Height = -13
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 202
          Visible = True
        end>
    end
    object bt_connect: TBitBtn
      Left = 172
      Top = 262
      Width = 135
      Height = 25
      Caption = 'Связать'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = bt_connectClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        33333333333FFF3333333333339993333333333333888F333333333333999333
        3333333333888F3333333333339993333333333333888F333333333333999333
        3333333FFF888FFFFF3333999999999993333388888888888F33339999999999
        93333388888888888F3333999999999993333388888888888333333333999333
        3333333333888F3333333333339993333333333333888F333333333333999333
        3333333333888F33333333333399933333333333338883333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object bt_del: TBitBtn
      Left = 438
      Top = 268
      Width = 27
      Height = 21
      Hint = 'Развязать'#13#10'(удалить связь)'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = bt_delClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333FFFFFFFFFFF3333CCCCCCCCCCC3333388888888888F3333CCCCCCCCCC
        C3333388888888888F3333CCCCCCCCCCC3333388888888888333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
  end
  object bt_close: TBitBtn
    Left = 378
    Top = 458
    Width = 91
    Height = 25
    Caption = 'Закрыть'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = bt_closeClick
    Kind = bkClose
  end
  object cds_shop: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 112
    Top = 84
  end
  object cds_dep: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 334
    Top = 88
  end
  object cds_dep_shop: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = cds_dep_shopAfterOpen
    AfterClose = cds_dep_shopAfterClose
    Left = 198
    Top = 350
  end
  object ds_shop: TDataSource
    DataSet = cds_shop
    Left = 146
    Top = 86
  end
  object ds_dep: TDataSource
    DataSet = cds_dep
    Left = 376
    Top = 98
  end
  object ds_dep_shop: TDataSource
    DataSet = cds_dep_shop
    Left = 228
    Top = 348
  end
end
