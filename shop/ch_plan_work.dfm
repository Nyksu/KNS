object fr_change_plan_work: Tfr_change_plan_work
  Left = 392
  Top = 207
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Выбор плана работы насосных агрегатов (НА)'
  ClientHeight = 499
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 271
    Height = 499
    Align = alLeft
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 308
      Width = 97
      Height = 13
      Caption = 'Наименование :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 24
      Top = 354
      Width = 81
      Height = 13
      Caption = 'Коментарий :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object gr_plans: TDBGrid
      Left = 1
      Top = 66
      Width = 269
      Height = 135
      Align = alTop
      DataSource = ds_plans
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
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
          Font.Style = [fsBold]
          Title.Alignment = taCenter
          Title.Caption = 'Наименование плана'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 230
          Visible = True
        end>
    end
    object ed_name: TEdit
      Left = 24
      Top = 324
      Width = 223
      Height = 21
      Enabled = False
      TabOrder = 1
    end
    object ed_coment: TMemo
      Left = 24
      Top = 370
      Width = 223
      Height = 89
      Enabled = False
      ScrollBars = ssBoth
      TabOrder = 2
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 269
      Height = 44
      Align = alTop
      BevelOuter = bvLowered
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object lb_active_plan: TLabel
        Left = 4
        Top = 26
        Width = 261
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Нет активных планов работы НА !'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clLime
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Panel3: TPanel
        Left = 1
        Top = 1
        Width = 267
        Height = 21
        Align = alTop
        Caption = 'Активный план работы :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 45
      Width = 269
      Height = 21
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'Список доступных планов :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object DBMemo1: TDBMemo
      Left = 1
      Top = 201
      Width = 269
      Height = 89
      Align = alTop
      DataField = 'coment'
      DataSource = ds_plans
      ScrollBars = ssBoth
      TabOrder = 5
    end
    object bt_save: TBitBtn
      Left = 24
      Top = 466
      Width = 75
      Height = 25
      Caption = 'Сохранить'
      Enabled = False
      TabOrder = 6
      OnClick = bt_saveClick
    end
    object bt_cancel: TBitBtn
      Left = 172
      Top = 466
      Width = 75
      Height = 25
      Caption = 'Отменить'
      Enabled = False
      TabOrder = 7
      OnClick = bt_cancelClick
    end
  end
  object bt_setplan: TBitBtn
    Left = 280
    Top = 22
    Width = 119
    Height = 25
    Caption = 'Установить'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = bt_setplanClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333333333333333333333333333333333333333333333FF333333333333
      3000333333FFFFF3F77733333000003000B033333777773777F733330BFBFB00
      E00033337FFF3377F7773333000FBFB0E000333377733337F7773330FBFBFBF0
      E00033F7FFFF3337F7773000000FBFB0E000377777733337F7770BFBFBFBFBF0
      E00073FFFFFFFF37F777300000000FB0E000377777777337F7773333330BFB00
      000033333373FF77777733333330003333333333333777333333333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    Margin = 6
    NumGlyphs = 2
    Spacing = -1
  end
  object bt_add: TBitBtn
    Left = 278
    Top = 326
    Width = 119
    Height = 25
    Caption = 'Добавить'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = bt_addClick
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
    Margin = 6
    NumGlyphs = 2
    Spacing = -1
  end
  object bt_del: TBitBtn
    Left = 278
    Top = 356
    Width = 119
    Height = 25
    Caption = 'Удалить'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
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
    Margin = 6
    NumGlyphs = 2
    Spacing = -1
  end
  object bt_edit: TBitBtn
    Left = 278
    Top = 386
    Width = 119
    Height = 25
    Caption = 'Изменить'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = bt_editClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333FFF3333333333333707333333333333F777F3333333333370
      F033333333F33F7737F333333733370F0733333337F3F77377333333300370F0
      73333333377F77377333333330F00F073333333337377377333333330FFFF073
      333333337F333773333333330FFFF03333333333733337F333333330FFFFFF03
      33333337F3333F7FF3333330FFFFF00733333337333FF7773333330FFFF00333
      3333337F3FF773333333330FF00333333333337FF7733333333330F003333333
      333337F773333333333330033333333333333773333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    Margin = 6
    NumGlyphs = 2
    Spacing = -1
  end
  object bt_exit: TBitBtn
    Left = 278
    Top = 470
    Width = 119
    Height = 25
    Caption = 'Выход'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
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
    Margin = 6
    NumGlyphs = 2
    Spacing = -1
  end
  object cds_plans: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 124
    Top = 126
  end
  object ds_plans: TDataSource
    DataSet = cds_plans
    Left = 92
    Top = 126
  end
end
