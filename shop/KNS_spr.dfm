object fr_kns_edit: Tfr_kns_edit
  Left = 438
  Top = 225
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'КНС (сток)'
  ClientHeight = 382
  ClientWidth = 502
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
  object RxLabel4: TRxLabel
    Left = 280
    Top = 164
    Width = 21
    Height = 13
    Caption = 'атм'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 502
    Height = 343
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 116
      Top = 71
      Width = 35
      Height = 16
      Caption = 'Цех :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 68
      Top = 105
      Width = 83
      Height = 16
      Caption = 'Название :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 47
      Top = 172
      Width = 104
      Height = 16
      Caption = 'Закачка сут. :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RxLabel1: TRxLabel
      Left = 290
      Top = 173
      Width = 63
      Height = 13
      Caption = 'куб. м / сут.'
    end
    object Label4: TLabel
      Left = 45
      Top = 240
      Width = 106
      Height = 13
      Caption = 'Давление стока :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RxLabel2: TRxLabel
      Left = 290
      Top = 273
      Width = 123
      Height = 13
      Caption = '% от величины на 1МПа'
    end
    object Label5: TLabel
      Left = 37
      Top = 273
      Width = 114
      Height = 13
      Caption = 'Изменение стока :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 39
      Top = 307
      Width = 112
      Height = 13
      Caption = 'Потери давления :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RxLabel5: TRxLabel
      Left = 290
      Top = 239
      Width = 25
      Height = 13
      Caption = 'МПа'
    end
    object RxLabel6: TRxLabel
      Left = 290
      Top = 307
      Width = 25
      Height = 13
      Caption = 'МПа'
    end
    object Label7: TLabel
      Left = 23
      Top = 138
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
    object DBText1: TDBText
      Left = 166
      Top = 206
      Width = 115
      Height = 17
      Alignment = taRightJustify
      DataField = 'SUM_ACCEPT_FOUND'
      DataSource = ds_kns
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RxLabel3: TRxLabel
      Left = 292
      Top = 207
      Width = 63
      Height = 13
      Caption = 'куб. м / сут.'
    end
    object Label8: TLabel
      Left = 21
      Top = 206
      Width = 130
      Height = 16
      Caption = 'S пр. фонда скв. :'
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
      Width = 500
      Height = 21
      Align = alTop
      Caption = 'Атрибуты КНС (Стока)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
    end
    object rg_kns_stok: TRadioGroup
      Left = 1
      Top = 22
      Width = 500
      Height = 37
      Align = alTop
      Columns = 2
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'КНС'
        'Сток')
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = rg_kns_stokClick
    end
    object ed_shop: TDBLookupComboBox
      Left = 160
      Top = 69
      Width = 329
      Height = 21
      DataField = 'shop_id'
      DataSource = ds_kns
      KeyField = 'id'
      ListField = 'name'
      ListSource = ds_shop
      TabOrder = 1
    end
    object ed_name: TDBEdit
      Left = 160
      Top = 102
      Width = 327
      Height = 21
      DataField = 'name'
      DataSource = ds_kns
      Enabled = False
      TabOrder = 2
    end
    object ed_day_debet: TRxDBCalcEdit
      Left = 160
      Top = 169
      Width = 121
      Height = 21
      DataField = 'days_debet'
      DataSource = ds_kns
      Alignment = taLeftJustify
      NumGlyphs = 2
      TabOrder = 4
    end
    object ed_stok_pres: TRxDBCalcEdit
      Left = 160
      Top = 236
      Width = 121
      Height = 21
      DataField = 'stok_pressure'
      DataSource = ds_kns
      Alignment = taLeftJustify
      Enabled = False
      NumGlyphs = 2
      TabOrder = 5
    end
    object ed_d_stok: TRxDBCalcEdit
      Left = 160
      Top = 270
      Width = 121
      Height = 21
      DataField = 'd_stok'
      DataSource = ds_kns
      Alignment = taLeftJustify
      Enabled = False
      NumGlyphs = 2
      TabOrder = 6
    end
    object ed_loss_pres: TRxDBCalcEdit
      Left = 160
      Top = 303
      Width = 121
      Height = 21
      DataField = 'loss_pressure'
      DataSource = ds_kns
      Alignment = taLeftJustify
      NumGlyphs = 2
      TabOrder = 7
    end
    object ed_deposit: TDBLookupComboBox
      Left = 160
      Top = 136
      Width = 258
      Height = 21
      DataField = 'deposit_id'
      DataSource = ds_kns
      KeyField = 'id'
      ListField = 'name'
      ListSource = ds_deposit
      TabOrder = 3
    end
  end
  object bt_ok: TBitBtn
    Left = 4
    Top = 350
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
    Left = 422
    Top = 350
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
    Left = 414
    Top = 6
  end
  object cds_kns: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 412
    Top = 38
  end
  object ds_shop: TDataSource
    DataSet = cds_shop
    Left = 382
    Top = 6
  end
  object ds_kns: TDataSource
    DataSet = cds_kns
    Left = 382
    Top = 36
  end
  object cds_deposit: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 388
    Top = 132
  end
  object ds_deposit: TDataSource
    DataSet = cds_deposit
    Left = 356
    Top = 132
  end
end
