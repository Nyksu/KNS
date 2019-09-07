object fr_pumpt_spr: Tfr_pumpt_spr
  Left = 408
  Top = 123
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Справочник насосных агрегатов'
  ClientHeight = 286
  ClientWidth = 564
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
    Width = 564
    Height = 243
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 4
      Top = 4
      Width = 555
      Height = 233
      DataSource = ds_pump_type
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
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
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'Наименование'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -13
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 440
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'wheel_count'
          Title.Caption = 'Число колес'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 90
          Visible = True
        end>
    end
  end
  object bt_add: TBitBtn
    Left = 10
    Top = 256
    Width = 117
    Height = 25
    Caption = 'Добавить'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
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
    Left = 140
    Top = 256
    Width = 107
    Height = 25
    Caption = 'Удалить'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
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
  object bt_exit: TBitBtn
    Left = 484
    Top = 256
    Width = 75
    Height = 25
    Caption = 'ВЫХОД'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = bt_exitClick
  end
  object bt_edit: TBitBtn
    Left = 258
    Top = 256
    Width = 99
    Height = 25
    Caption = 'Изменить'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = bt_editClick
  end
  object cds_pump_type: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = cds_pump_typeAfterOpen
    AfterClose = cds_pump_typeAfterClose
    Left = 480
    Top = 52
  end
  object ds_pump_type: TDataSource
    DataSet = cds_pump_type
    Left = 250
    Top = 96
  end
end
