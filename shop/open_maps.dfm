object fr_open_maps: Tfr_open_maps
  Left = 310
  Top = 143
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Открытие схемы'
  ClientHeight = 424
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 410
    Height = 385
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 344
      Width = 89
      Height = 16
      Caption = 'Создатель :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lb_creator: TRxLabel
      Left = 16
      Top = 362
      Width = 119
      Height = 16
      Caption = 'ЗАО "РУСИНТЕЛ"'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 408
      Height = 21
      Align = alTop
      Caption = 'Доступные схемы:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object DBGrid1: TDBGrid
      Left = 14
      Top = 32
      Width = 383
      Height = 151
      DataSource = ds_maps
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = ppm_ed_shem
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
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Title.Alignment = taCenter
          Title.Caption = 'Наименование схемы'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 340
          Visible = True
        end>
    end
    object DBMemo1: TDBMemo
      Left = 16
      Top = 194
      Width = 383
      Height = 141
      DataField = 'coment'
      DataSource = ds_maps
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 2
    end
  end
  object bt_open: TBitBtn
    Left = 8
    Top = 394
    Width = 103
    Height = 25
    Caption = 'Открыть'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = bt_openClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      555555FFFFFFFFFF55555000000000055555577777777775FFFF00B8B8B8B8B0
      0000775F5555555777770B0B8B8B8B8B0FF07F75F555555575F70FB0B8B8B8B8
      B0F07F575FFFFFFFF7F70BFB0000000000F07F557777777777570FBFBF0FFFFF
      FFF07F55557F5FFFFFF70BFBFB0F000000F07F55557F777777570FBFBF0FFFFF
      FFF075F5557F5FFFFFF750FBFB0F000000F0575FFF7F777777575700000FFFFF
      FFF05577777F5FF55FF75555550F00FF00005555557F775577775555550FFFFF
      0F055555557F55557F755555550FFFFF00555555557FFFFF7755555555000000
      0555555555777777755555555555555555555555555555555555}
    Margin = 6
    NumGlyphs = 2
    Spacing = -1
  end
  object bt_close: TBitBtn
    Left = 302
    Top = 394
    Width = 101
    Height = 25
    Caption = 'ЗАКРЫТЬ'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    Kind = bkClose
    Margin = 6
    Spacing = -1
  end
  object cds_maps: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 74
    Top = 112
  end
  object ds_maps: TDataSource
    DataSet = cds_maps
    OnDataChange = ds_mapsDataChange
    Left = 110
    Top = 116
  end
  object ppm_ed_shem: TPopupMenu
    Left = 330
    Top = 84
    object n_del_shem: TMenuItem
      Caption = 'Удалить схему'
    end
    object n_rename_shem: TMenuItem
      Caption = 'Переименовать схему'
    end
  end
end
