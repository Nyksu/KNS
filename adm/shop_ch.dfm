object fr_openshop: Tfr_openshop
  Left = 196
  Top = 287
  Width = 445
  Height = 383
  Caption = '���������� �����'
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
    Width = 437
    Height = 243
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 3
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 435
      Height = 21
      Align = alTop
      Caption = '������������������ ����'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object DBGrid1: TDBGrid
      Left = 26
      Top = 38
      Width = 383
      Height = 189
      DataSource = ds_shop
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 1
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
          Title.Caption = '������������'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -13
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 355
          Visible = True
        end>
    end
  end
  object bt_add_shop: TBitBtn
    Left = 10
    Top = 256
    Width = 187
    Height = 25
    Caption = '�������� ���'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = bt_add_shopClick
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
  object bt_del_shop: TBitBtn
    Left = 292
    Top = 256
    Width = 137
    Height = 25
    Caption = '������� ���'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = bt_del_shopClick
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
    Left = 354
    Top = 322
    Width = 75
    Height = 25
    Caption = '�����'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = bt_exitClick
  end
  object bt_edit: TBitBtn
    Left = 10
    Top = 290
    Width = 187
    Height = 25
    Caption = '�������� ��������'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = bt_editClick
  end
  object cds_shop: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = cds_shopAfterOpen
    AfterClose = cds_shopAfterClose
    Left = 168
    Top = 118
  end
  object ds_shop: TDataSource
    DataSet = cds_shop
    Left = 134
    Top = 116
  end
end
