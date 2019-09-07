object fr_vrp_edit: Tfr_vrp_edit
  Left = 482
  Top = 140
  BorderStyle = bsSingle
  Caption = 'ВРП'
  ClientHeight = 222
  ClientWidth = 511
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
    Width = 511
    Height = 183
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object lb_place: TLabel
      Left = 72
      Top = 38
      Width = 30
      Height = 16
      Alignment = taRightJustify
      Caption = 'НС :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 19
      Top = 69
      Width = 83
      Height = 16
      Alignment = taRightJustify
      Caption = 'Название :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 45
      Top = 100
      Width = 57
      Height = 16
      Alignment = taRightJustify
      Caption = 'Номер :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 56
      Top = 130
      Width = 46
      Height = 16
      Alignment = taRightJustify
      Caption = 'Вода :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pn_shapka: TPanel
      Left = 1
      Top = 1
      Width = 509
      Height = 21
      Align = alTop
      Caption = 'Атрибуты ВРП'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object ed_place: TDBLookupComboBox
      Left = 113
      Top = 35
      Width = 345
      Height = 21
      DataField = 'ns_id'
      KeyField = 'id'
      ListField = 'name'
      ListSource = ds_shop
      TabOrder = 0
    end
    object ed_name: TDBEdit
      Left = 113
      Top = 66
      Width = 282
      Height = 21
      DataField = 'name'
      DataSource = ds_ns
      TabOrder = 1
    end
    object ed_nomer: TRxDBCalcEdit
      Left = 113
      Top = 97
      Width = 86
      Height = 21
      DataField = 'nomer'
      DataSource = ds_ns
      Alignment = taLeftJustify
      NumGlyphs = 2
      TabOrder = 2
    end
    object ed_water: TDBLookupComboBox
      Left = 114
      Top = 128
      Width = 299
      Height = 21
      DataField = 'water'
      DataSource = ds_ns
      KeyField = 'id'
      ListField = 'Name'
      ListSource = ds_water
      TabOrder = 3
    end
  end
  object bt_ok: TBitBtn
    Left = 6
    Top = 190
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = bt_okClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object bt_exit: TBitBtn
    Left = 431
    Top = 190
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = bt_exitClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object cds_shop: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 416
    Top = 22
  end
  object cds_ns: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 414
    Top = 54
  end
  object ds_shop: TDataSource
    DataSet = cds_shop
    Left = 388
    Top = 26
  end
  object ds_ns: TDataSource
    DataSet = cds_ns
    Left = 388
    Top = 56
  end
  object cds_water: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'Name'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
      end
      item
        Name = 'CHANGEINDEX'
      end>
    Params = <>
    StoreDefs = True
    Left = 430
    Top = 104
    Data = {
      3E0000009619E0BD0100000018000000020000000000030000003E0002696404
      00010000000000044E616D650100490000000100055749445448020002006400
      0000}
    object cds_waterid: TIntegerField
      FieldName = 'id'
    end
    object cds_waterName: TStringField
      FieldName = 'Name'
      Size = 100
    end
  end
  object ds_water: TDataSource
    DataSet = cds_water
    Left = 468
    Top = 110
  end
end
