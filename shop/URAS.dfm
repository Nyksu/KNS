object fr_t_ras: Tfr_t_ras
  Left = 415
  Top = 258
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Узлы раздела'
  ClientHeight = 422
  ClientWidth = 414
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 414
    Height = 375
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 412
      Height = 21
      Align = alTop
      Caption = 'Выборка по периоду'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object ls_period: TListBox
      Left = 10
      Top = 28
      Width = 121
      Height = 335
      ItemHeight = 13
      TabOrder = 1
      OnClick = ls_periodClick
    end
    object gr_ras: TDBGrid
      Left = 142
      Top = 28
      Width = 263
      Height = 335
      DataSource = ds_ras
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'unit_id'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Visible = True
        end>
    end
  end
  object bt_go_obj: TBitBtn
    Left = 250
    Top = 388
    Width = 155
    Height = 25
    Caption = 'Перейти к узлу'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = bt_go_objClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4FFFFFFFFFFFFFFF44FF
      FFFFFFFFFFFF444FFFFF444444444444FFFF4444444444444FFF444444444444
      FFFFFFFFFFFF444FFFFFFFFFFFFF44FFFFFFFFFFFFFF4FFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Margin = 6
    Spacing = -1
  end
  object bt_close: TBitBtn
    Left = 8
    Top = 388
    Width = 87
    Height = 25
    Caption = 'Закрыть'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = bt_closeClick
  end
  object ds_ras: TDataSource
    DataSet = cds_ras
    Left = 236
    Top = 180
  end
  object cds_res: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 96
  end
  object cds_ras: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 184
    Top = 192
    Data = {
      530000009619E0BD010000001800000003000000000003000000530007756E69
      745F69640400010000000000046E616D65010049000000010005574944544802
      000200280007706C616E5F696404000100000000000000}
    object cds_rasunit_id: TIntegerField
      DisplayLabel = 'Код узла'
      FieldName = 'unit_id'
    end
    object cds_rasname: TStringField
      DisplayLabel = 'Имя'
      FieldName = 'name'
      Size = 40
    end
    object cds_rasplan_id: TIntegerField
      FieldName = 'plan_id'
      Visible = False
    end
  end
end
