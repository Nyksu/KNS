object fr_plast_edit: Tfr_plast_edit
  Left = 325
  Top = 263
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Скважина'
  ClientHeight = 213
  ClientWidth = 386
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
    Width = 386
    Height = 179
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object Label3: TLabel
      Left = 72
      Top = 33
      Width = 54
      Height = 16
      Alignment = taRightJustify
      Caption = 'Пласт :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 95
      Top = 105
      Width = 77
      Height = 16
      Alignment = taRightJustify
      Caption = 'При Руст :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 132
      Top = 140
      Width = 40
      Height = 16
      Alignment = taRightJustify
      Caption = 'К пр :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 57
      Top = 69
      Width = 115
      Height = 16
      Alignment = taRightJustify
      Caption = 'Приемистость :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RxLabel1: TRxLabel
      Left = 286
      Top = 70
      Width = 54
      Height = 13
      Caption = 'куб.м/сут.'
    end
    object RxLabel2: TRxLabel
      Left = 286
      Top = 107
      Width = 25
      Height = 13
      Caption = 'МПа'
    end
    object RxLabel3: TRxLabel
      Left = 286
      Top = 144
      Width = 82
      Height = 13
      Caption = 'куб.м/сут./МПа'
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 384
      Height = 21
      Align = alTop
      Caption = 'Параметры индикаторной диаграммы'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object ed_plast: TDBLookupComboBox
      Left = 140
      Top = 30
      Width = 145
      Height = 21
      DataField = 'plast_id'
      DataSource = ds_well_par
      KeyField = 'id'
      ListField = 'name'
      ListSource = ds_plast
      TabOrder = 0
    end
    object ed_pressure: TRxDBCalcEdit
      Left = 192
      Top = 102
      Width = 83
      Height = 21
      DataField = 'pressure'
      DataSource = ds_well_par
      NumGlyphs = 2
      TabOrder = 2
    end
    object ed_kaccept: TRxDBCalcEdit
      Left = 192
      Top = 137
      Width = 83
      Height = 21
      DataField = 'k_accept'
      DataSource = ds_well_par
      NumGlyphs = 2
      TabOrder = 3
    end
    object ed_accept: TRxDBCalcEdit
      Left = 192
      Top = 66
      Width = 83
      Height = 21
      DataField = 'accept'
      DataSource = ds_well_par
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object bt_ok: TBitBtn
    Left = 6
    Top = 186
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
    Left = 305
    Top = 186
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
  object cds_plast: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 298
    Top = 32
  end
  object cds_well_par: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 316
    Top = 100
  end
  object ds_plast: TDataSource
    DataSet = cds_plast
    Left = 328
    Top = 36
  end
  object ds_well_par: TDataSource
    DataSet = cds_well_par
    Left = 296
    Top = 108
  end
end
