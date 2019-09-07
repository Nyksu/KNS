object fr_kust_edit: Tfr_kust_edit
  Left = 339
  Top = 328
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Куст скважин'
  ClientHeight = 209
  ClientWidth = 426
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
    Width = 426
    Height = 173
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object lb_place: TLabel
      Left = 99
      Top = 102
      Width = 39
      Height = 16
      Alignment = taRightJustify
      Caption = 'КНС :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 95
      Top = 138
      Width = 43
      Height = 16
      Alignment = taRightJustify
      Caption = 'Куст :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 103
      Top = 66
      Width = 35
      Height = 16
      Alignment = taRightJustify
      Caption = 'Цех :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 10
      Top = 30
      Width = 128
      Height = 16
      Alignment = taRightJustify
      Caption = 'Месторождение :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 424
      Height = 21
      Align = alTop
      Caption = 'Атрибуты куста скважин'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
    object ed_kns: TDBLookupComboBox
      Left = 150
      Top = 101
      Width = 258
      Height = 21
      DataField = 'kns_id'
      DataSource = ds_kust
      KeyField = 'id'
      ListField = 'name'
      ListSource = ds_kns
      TabOrder = 2
    end
    object ed_nomer: TRxDBCalcEdit
      Left = 148
      Top = 138
      Width = 86
      Height = 21
      DataField = 'nomer'
      DataSource = ds_kust
      Alignment = taLeftJustify
      NumGlyphs = 2
      TabOrder = 3
    end
    object ed_prefix: TDBEdit
      Left = 246
      Top = 139
      Width = 75
      Height = 21
      DataField = 'lastname'
      DataSource = ds_kust
      TabOrder = 4
    end
    object ed_shop: TDBLookupComboBox
      Left = 148
      Top = 65
      Width = 258
      Height = 21
      DataField = 'shop_id'
      DataSource = ds_kust
      KeyField = 'id'
      ListField = 'name'
      ListSource = ds_shop
      TabOrder = 1
    end
    object ed_deposit: TDBLookupComboBox
      Left = 148
      Top = 28
      Width = 258
      Height = 21
      DataField = 'deposit_id'
      DataSource = ds_kust
      KeyField = 'id'
      ListField = 'name'
      ListSource = ds_deposit
      TabOrder = 0
    end
  end
  object bt_ok: TBitBtn
    Left = 6
    Top = 180
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
    Left = 345
    Top = 180
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
  object cds_kns: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 304
    Top = 104
  end
  object ds_kns: TDataSource
    DataSet = cds_kns
    Left = 272
    Top = 104
  end
  object cds_kust: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 396
    Top = 142
  end
  object ds_kust: TDataSource
    DataSet = cds_kust
    Left = 368
    Top = 142
  end
  object cds_shop: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 306
    Top = 64
  end
  object cds_deposit: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 306
    Top = 26
  end
  object ds_shop: TDataSource
    DataSet = cds_shop
    Left = 274
    Top = 64
  end
  object ds_deposit: TDataSource
    DataSet = cds_deposit
    Left = 274
    Top = 26
  end
end
