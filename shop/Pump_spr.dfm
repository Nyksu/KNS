object fr_pump_edit: Tfr_pump_edit
  Left = 444
  Top = 266
  BorderStyle = bsSingle
  Caption = 'Насосный агрегат'
  ClientHeight = 354
  ClientWidth = 404
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
    Width = 404
    Height = 323
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object Label3: TLabel
      Left = 84
      Top = 33
      Width = 38
      Height = 16
      Alignment = taRightJustify
      Caption = 'Имя :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 15
      Top = 244
      Width = 245
      Height = 16
      Alignment = taRightJustify
      Caption = 'Снижение производительности :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 85
      Top = 65
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
    object Label5: TLabel
      Left = 19
      Top = 92
      Width = 101
      Height = 16
      Alignment = taRightJustify
      Caption = 'Число колес :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RxLabel1: TRxLabel
      Left = 354
      Top = 244
      Width = 14
      Height = 16
      Caption = '%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object RxLabel2: TRxLabel
      Left = 354
      Top = 272
      Width = 40
      Height = 13
      Caption = 'куб.м/ч'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 18
      Top = 270
      Width = 242
      Height = 16
      Alignment = taRightJustify
      Caption = 'Заданная производительность :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 35
      Top = 296
      Width = 225
      Height = 16
      Alignment = taRightJustify
      Caption = 'Заданное рабочее давление :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RxLabel3: TRxLabel
      Left = 354
      Top = 296
      Width = 26
      Height = 16
      Caption = 'атм'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object pn_shapka: TPanel
      Left = 1
      Top = 1
      Width = 402
      Height = 21
      Align = alTop
      Caption = 'Атрибуты насосного агрегата'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
    end
    object ed_wheel: TRxDBCalcEdit
      Left = 135
      Top = 91
      Width = 86
      Height = 21
      DataField = 'WHEEL_COUNT'
      DataSource = ds_pump
      Alignment = taLeftJustify
      MaxValue = 100
      NumGlyphs = 2
      TabOrder = 2
    end
    object ed_name: TDBEdit
      Left = 134
      Top = 31
      Width = 209
      Height = 21
      DataField = 'name'
      DataSource = ds_pump
      Enabled = False
      TabOrder = 0
    end
    object rg_state: TRadioGroup
      Left = 16
      Top = 124
      Width = 357
      Height = 33
      Caption = 'Состояние агрегата :'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'В работе'
        'В резерве'
        'В ремонте')
      TabOrder = 3
      TabStop = True
      OnClick = rg_stateClick
    end
    object rg_regim: TRadioGroup
      Left = 18
      Top = 166
      Width = 203
      Height = 67
      Caption = 'Режим работы :'
      ItemIndex = 0
      Items.Strings = (
        'На задвижку'
        'Заданное давление'
        'Заданная производительность')
      TabOrder = 4
      TabStop = True
      OnClick = rg_regimClick
    end
    object ed_flow: TRxDBCalcEdit
      Left = 266
      Top = 242
      Width = 85
      Height = 21
      DataField = 'flow'
      DataSource = ds_pump
      NumGlyphs = 2
      TabOrder = 5
    end
    object ed_workflow: TRxDBCalcEdit
      Left = 266
      Top = 268
      Width = 85
      Height = 21
      DataField = 'workflow'
      DataSource = ds_pump
      NumGlyphs = 2
      TabOrder = 6
    end
    object ed_pressure: TRxDBCalcEdit
      Left = 266
      Top = 294
      Width = 85
      Height = 21
      DataField = 'pressure'
      DataSource = ds_pump
      NumGlyphs = 2
      TabOrder = 7
    end
    object bt_getspr: TButton
      Left = 226
      Top = 92
      Width = 147
      Height = 19
      Caption = 'Взять из справочника'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      TabStop = False
      OnClick = bt_getsprClick
    end
    object ed_type: TRxDBLookupCombo
      Left = 134
      Top = 62
      Width = 209
      Height = 21
      DropDownCount = 8
      DataField = 'pump_type_id'
      DataSource = ds_pump
      LookupField = 'id'
      LookupDisplay = 'name'
      LookupSource = ds_type
      TabOrder = 1
      OnChange = bt_getsprClick
    end
  end
  object bt_ok: TBitBtn
    Left = 4
    Top = 328
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
    Left = 325
    Top = 328
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
  object cds_pump: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 370
    Top = 32
  end
  object ds_pump: TDataSource
    DataSet = cds_pump
    Left = 346
    Top = 30
  end
  object cds_type: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 374
    Top = 60
  end
  object ds_type: TDataSource
    DataSet = cds_type
    Left = 342
    Top = 56
  end
end
