object fr_catch_edit: Tfr_catch_edit
  Left = 438
  Top = 352
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Задвижка'
  ClientHeight = 351
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
    Height = 309
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object lb_place: TLabel
      Left = 99
      Top = 82
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
    object Label2: TLabel
      Left = 55
      Top = 115
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
      Left = 65
      Top = 147
      Width = 73
      Height = 16
      Alignment = taRightJustify
      Caption = 'Диаметр :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 43
      Top = 180
      Width = 95
      Height = 16
      Alignment = taRightJustify
      Caption = '% открытия :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 37
      Top = 213
      Width = 101
      Height = 16
      Alignment = taRightJustify
      Caption = 'Назначение :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 10
      Top = 245
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
    object Label6: TLabel
      Left = 103
      Top = 278
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
    object pn_shapka: TPanel
      Left = 1
      Top = 1
      Width = 509
      Height = 21
      Align = alTop
      Caption = 'Атрибуты задвижки'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
    end
    object ed_name: TDBEdit
      Left = 152
      Top = 113
      Width = 282
      Height = 21
      DataField = 'name'
      DataSource = ds_catch
      TabOrder = 2
    end
    object ed_d: TRxDBCalcEdit
      Left = 152
      Top = 146
      Width = 86
      Height = 21
      DataField = 'diametr'
      DataSource = ds_catch
      Alignment = taLeftJustify
      NumGlyphs = 2
      TabOrder = 3
    end
    object ed_open: TRxDBCalcEdit
      Left = 152
      Top = 179
      Width = 86
      Height = 21
      DataField = 'bolt_open'
      DataSource = ds_catch
      Alignment = taLeftJustify
      MaxValue = 100
      NumGlyphs = 2
      TabOrder = 4
      OnExit = ed_openExit
    end
    object ed_setting: TDBEdit
      Left = 152
      Top = 211
      Width = 282
      Height = 21
      DataField = 'setting'
      DataSource = ds_catch
      TabOrder = 7
    end
    object ch_open: TCheckBox
      Left = 252
      Top = 178
      Width = 63
      Height = 17
      Caption = 'Открыт'
      TabOrder = 5
      OnClick = ch_openClick
    end
    object ch_close: TCheckBox
      Left = 332
      Top = 178
      Width = 63
      Height = 17
      Caption = 'закрыт'
      TabOrder = 6
      OnClick = ch_closeClick
    end
    object rg_tp_catch: TRadioGroup
      Left = 1
      Top = 22
      Width = 509
      Height = 35
      Align = alTop
      Caption = 'Привязка задвижки :'
      Columns = 3
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
      Left = 152
      Top = 80
      Width = 283
      Height = 25
      DataSource = ds_obj
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
    object ed_deposit: TDBLookupComboBox
      Left = 152
      Top = 244
      Width = 258
      Height = 21
      DataField = 'deposit_id'
      DataSource = ds_catch
      KeyField = 'id'
      ListField = 'name'
      ListSource = ds_deposit
      TabOrder = 9
    end
    object ed_shop: TDBLookupComboBox
      Left = 152
      Top = 277
      Width = 258
      Height = 21
      DataField = 'shop_id'
      DataSource = ds_catch
      KeyField = 'id'
      ListField = 'name'
      ListSource = ds_shop
      TabOrder = 10
    end
  end
  object bt_ok: TBitBtn
    Left = 8
    Top = 324
    Width = 75
    Height = 23
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
    Top = 322
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
  object cds_obj: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 416
    Top = 22
  end
  object ds_obj: TDataSource
    DataSet = cds_obj
    Left = 388
    Top = 26
  end
  object ds_catch: TDataSource
    DataSet = cds_catch
    Left = 388
    Top = 56
  end
  object cds_catch: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 422
    Top = 56
  end
  object cds_deposit: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 348
    Top = 238
  end
  object ds_deposit: TDataSource
    DataSet = cds_deposit
    Left = 320
    Top = 238
  end
  object cds_shop: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 346
    Top = 274
  end
  object ds_shop: TDataSource
    DataSet = cds_shop
    Left = 318
    Top = 274
  end
end
