object fr_pipe_edit: Tfr_pipe_edit
  Left = 393
  Top = 219
  BorderStyle = bsSingle
  Caption = 'Водовод'
  ClientHeight = 487
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
    Height = 447
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object Label2: TLabel
      Left = 78
      Top = 156
      Width = 70
      Height = 16
      Alignment = taRightJustify
      Caption = 'Участок :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 93
      Top = 186
      Width = 55
      Height = 16
      Alignment = taRightJustify
      Caption = 'Труба :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 93
      Top = 217
      Width = 55
      Height = 16
      Alignment = taRightJustify
      Caption = 'Длина :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 75
      Top = 125
      Width = 73
      Height = 16
      Alignment = taRightJustify
      Caption = 'Водовод :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 87
      Top = 278
      Width = 61
      Height = 16
      Alignment = taRightJustify
      Caption = 'К сопр. :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 250
      Top = 186
      Width = 10
      Height = 16
      Alignment = taRightJustify
      Caption = 'Х'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 111
      Top = 95
      Width = 37
      Height = 16
      Alignment = taRightJustify
      Caption = 'Тип :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 57
      Top = 309
      Width = 91
      Height = 16
      Alignment = taRightJustify
      Caption = 'Год стр-ва  :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RxLabel2: TRxLabel
      Left = 252
      Top = 218
      Width = 11
      Height = 16
      Caption = 'м'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lb_place: TLabel
      Left = 109
      Top = 64
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
    object Label5: TLabel
      Left = 20
      Top = 369
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
    object Label10: TLabel
      Left = 113
      Top = 400
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
    object Label11: TLabel
      Left = 23
      Top = 246
      Width = 123
      Height = 16
      Alignment = taRightJustify
      Caption = 'Шероховатость :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 252
      Top = 250
      Width = 88
      Height = 16
      Alignment = taRightJustify
      Caption = 'Расчетная :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lb_shoroh: TRxLabel
      Left = 356
      Top = 252
      Width = 31
      Height = 16
      Alignment = taRightJustify
      Caption = '0.06'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RxLabel1: TRxLabel
      Left = 388
      Top = 254
      Width = 18
      Height = 13
      Caption = 'мм'
    end
    object Label13: TLabel
      Left = 33
      Top = 340
      Width = 115
      Height = 16
      Alignment = taRightJustify
      Caption = 'Гидр. диаметр :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label14: TLabel
      Left = 246
      Top = 340
      Width = 90
      Height = 16
      Alignment = taRightJustify
      Caption = 'Расчетный :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lb_gidrad: TRxLabel
      Left = 342
      Top = 340
      Width = 55
      Height = 16
      Alignment = taRightJustify
      Caption = '1000.06'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RxLabel4: TRxLabel
      Left = 400
      Top = 340
      Width = 18
      Height = 13
      Caption = 'мм'
    end
    object pn_shapka: TPanel
      Left = 1
      Top = 1
      Width = 509
      Height = 21
      Align = alTop
      Caption = 'Атрибуты водовода'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 14
    end
    object ed_name: TDBEdit
      Left = 158
      Top = 153
      Width = 282
      Height = 21
      DataField = 'name'
      DataSource = ds_pipe
      TabOrder = 4
    end
    object ed_len: TRxDBCalcEdit
      Left = 158
      Top = 215
      Width = 86
      Height = 21
      DataField = 'len'
      DataSource = ds_pipe
      Alignment = taLeftJustify
      NumGlyphs = 2
      TabOrder = 7
    end
    object ed_thick: TRxDBCalcEdit
      Left = 266
      Top = 185
      Width = 83
      Height = 21
      DataField = 'thick'
      DataSource = ds_pipe
      NumGlyphs = 2
      TabOrder = 6
    end
    object ed_cof: TRxDBCalcEdit
      Left = 158
      Top = 276
      Width = 83
      Height = 21
      DataField = 'k_lock_res'
      DataSource = ds_pipe
      NumGlyphs = 2
      TabOrder = 11
    end
    object ed_tip: TDBLookupComboBox
      Left = 158
      Top = 91
      Width = 282
      Height = 21
      DataField = 'pipe_type_id'
      DataSource = ds_pipe
      Enabled = False
      KeyField = 'id'
      ListField = 'name'
      ListSource = ds_tip
      TabOrder = 2
    end
    object ed_year: TRxDBCalcEdit
      Left = 158
      Top = 307
      Width = 83
      Height = 21
      DataField = 'build_year'
      DataSource = ds_pipe
      MaxValue = 1960
      MinValue = 2005
      NumGlyphs = 2
      TabOrder = 8
    end
    object ed_d: TDBLookupComboBox
      Left = 158
      Top = 184
      Width = 85
      Height = 21
      DataField = 'pipe_d_id'
      DataSource = ds_pipe
      KeyField = 'id'
      ListField = 'diametr'
      ListSource = ds_diametr
      TabOrder = 5
    end
    object rg_tp_catch: TRadioGroup
      Left = 1
      Top = 22
      Width = 509
      Height = 35
      Align = alTop
      Caption = 'Привязка водовода :'
      Columns = 3
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemIndex = 0
      Items.Strings = (
        'КНС'
        'НС'
        'КУСТ')
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = rg_tp_catchClick
    end
    object gr_obj: TDBGrid
      Left = 158
      Top = 60
      Width = 279
      Height = 25
      DataSource = ds_obj
      Enabled = False
      Options = [dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
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
          Width = 255
          Visible = True
        end>
    end
    object ed_dir: TDBEdit
      Left = 158
      Top = 122
      Width = 273
      Height = 21
      DataField = 'directname'
      DataSource = ds_pipe
      TabOrder = 3
    end
    object ed_deposit: TDBLookupComboBox
      Left = 158
      Top = 368
      Width = 258
      Height = 21
      DataField = 'deposit_id'
      DataSource = ds_pipe
      KeyField = 'id'
      ListField = 'name'
      ListSource = ds_deposit
      TabOrder = 9
    end
    object ed_shop: TDBLookupComboBox
      Left = 158
      Top = 399
      Width = 258
      Height = 21
      DataField = 'shop_id'
      DataSource = ds_pipe
      KeyField = 'id'
      ListField = 'name'
      ListSource = ds_shop
      TabOrder = 10
    end
    object ed_shoroh: TRxDBCalcEdit
      Left = 158
      Top = 246
      Width = 85
      Height = 21
      DataField = 'shoroh'
      DataSource = ds_pipe
      NumGlyphs = 2
      TabOrder = 12
    end
    object ed_gidrod: TRxDBComboEdit
      Left = 158
      Top = 338
      Width = 83
      Height = 21
      DataField = 'gidrod'
      DataSource = ds_pipe
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337000000000
        73333337777777773F333308888888880333337F3F3F3FFF7F33330808089998
        0333337F737377737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3FFFFFFF7F33330800000008
        0333337F7777777F7F333308000E0E080333337F7FFFFF7F7F33330800000008
        0333337F777777737F333308888888880333337F333333337F33330888888888
        03333373FFFFFFFF733333700000000073333337777777773333}
      NumGlyphs = 2
      TabOrder = 13
      OnButtonClick = ed_gidrodButtonClick
    end
  end
  object bt_ok: TBitBtn
    Left = 6
    Top = 456
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
    Top = 456
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
  object cds_pipe: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = cds_pipeAfterOpen
    BeforeClose = cds_pipeBeforeClose
    Left = 312
    Top = 294
  end
  object ds_pipe: TDataSource
    DataSet = cds_pipe
    OnDataChange = ds_pipeDataChange
    Left = 278
    Top = 292
  end
  object cds_tip: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 96
  end
  object ds_tip: TDataSource
    DataSet = cds_tip
    Left = 438
    Top = 92
  end
  object ds_diametr: TDataSource
    DataSet = cds_diametr
    Left = 184
    Top = 180
  end
  object cds_diametr: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 198
    Top = 182
  end
  object cds_obj: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 468
    Top = 56
  end
  object ds_obj: TDataSource
    DataSet = cds_obj
    Left = 430
    Top = 58
  end
  object cds_deposit: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 364
    Top = 366
  end
  object cds_shop: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 366
    Top = 398
  end
  object ds_deposit: TDataSource
    DataSet = cds_deposit
    Left = 336
    Top = 364
  end
  object ds_shop: TDataSource
    DataSet = cds_shop
    Left = 338
    Top = 400
  end
end
