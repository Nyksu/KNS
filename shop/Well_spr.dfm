object fr_well_edit: Tfr_well_edit
  Left = 295
  Top = 291
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Скважина'
  ClientHeight = 412
  ClientWidth = 509
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 509
    Height = 379
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object Bevel1: TBevel
      Left = 14
      Top = 172
      Width = 483
      Height = 195
    end
    object Label3: TLabel
      Left = 116
      Top = 33
      Width = 114
      Height = 16
      Alignment = taRightJustify
      Caption = 'Имя скважины :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 82
      Top = 70
      Width = 148
      Height = 16
      Alignment = taRightJustify
      Caption = 'Суточное задание :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 90
      Top = 106
      Width = 140
      Height = 16
      Alignment = taRightJustify
      Caption = 'Диаметр штуцера :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 68
      Top = 143
      Width = 162
      Height = 16
      Alignment = taRightJustify
      Caption = 'Состояние по фонду :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 44
      Top = 181
      Width = 418
      Height = 16
      Alignment = taRightJustify
      Caption = 'ПАРАМЕТРЫ ИНДИКАТОРНОЙ ДИАГРАММЫ СКВАЖИНЫ'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RxLabel2: TRxLabel
      Left = 376
      Top = 70
      Width = 54
      Height = 13
      Caption = 'куб.м/сут.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object RxLabel1: TRxLabel
      Left = 376
      Top = 108
      Width = 18
      Height = 13
      Caption = 'мм'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 507
      Height = 21
      Align = alTop
      Caption = 'Параметры скважины'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
    end
    object ed_name: TDBEdit
      Left = 246
      Top = 30
      Width = 139
      Height = 21
      DataField = 'nomer'
      DataSource = dc_well
      Enabled = False
      TabOrder = 0
    end
    object gr_plast_par: TDBGrid
      Left = 26
      Top = 200
      Width = 459
      Height = 127
      DataSource = ds_plast_par
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 4
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
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'Пласт'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clNavy
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'pressure'
          Title.Alignment = taCenter
          Title.Caption = 'Давление'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'k_accept'
          Title.Alignment = taCenter
          Title.Caption = 'К приемистости'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 103
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'accept'
          Title.Alignment = taCenter
          Title.Caption = 'Приемистость'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 93
          Visible = True
        end>
    end
    object bt_add_plast: TBitBtn
      Left = 30
      Top = 332
      Width = 141
      Height = 25
      Caption = 'Добавить пласт'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = bt_add_plastClick
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
      NumGlyphs = 2
    end
    object bt_del_plast: TBitBtn
      Left = 178
      Top = 332
      Width = 125
      Height = 25
      Caption = 'Удалить пласт'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = bt_del_plastClick
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
      NumGlyphs = 2
    end
    object bt_edit_plast: TBitBtn
      Left = 394
      Top = 332
      Width = 89
      Height = 25
      Caption = 'Изменить'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = bt_edit_plastClick
    end
    object ed_d_pump: TRxDBCalcEdit
      Left = 246
      Top = 67
      Width = 121
      Height = 21
      DataField = 'day_pump'
      DataSource = dc_well
      NumGlyphs = 2
      TabOrder = 1
    end
    object ed_diametr: TRxDBCalcEdit
      Left = 246
      Top = 103
      Width = 121
      Height = 21
      DataField = 'd_shtucer'
      DataSource = dc_well
      NumGlyphs = 2
      TabOrder = 2
    end
    object ed_state: TDBLookupComboBox
      Left = 246
      Top = 140
      Width = 145
      Height = 21
      DataField = 'found_state_id'
      DataSource = dc_well
      KeyField = 'id'
      ListField = 'name'
      ListSource = ds_state
      TabOrder = 3
    end
  end
  object bt_ok: TBitBtn
    Left = 6
    Top = 384
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
    Left = 429
    Top = 384
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
  object cds_plast_par: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 322
    Top = 260
  end
  object cds_well: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 426
    Top = 30
  end
  object cds_state: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 366
    Top = 136
  end
  object dc_well: TDataSource
    DataSet = cds_well
    Left = 394
    Top = 30
  end
  object ds_state: TDataSource
    DataSet = cds_state
    Left = 330
    Top = 142
  end
  object ds_plast_par: TDataSource
    DataSet = cds_plast_par
    Left = 290
    Top = 256
  end
end
