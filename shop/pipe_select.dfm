object fr_pipe_select: Tfr_pipe_select
  Left = 355
  Top = 110
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Выборка коллекций водоводов'
  ClientHeight = 460
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 630
    Height = 425
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 327
      Top = 1
      Width = 3
      Height = 423
      Cursor = crHSplit
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 326
      Height = 423
      Align = alLeft
      TabOrder = 0
      object Panel3: TPanel
        Left = 1
        Top = 1
        Width = 324
        Height = 21
        Align = alTop
        BevelOuter = bvLowered
        Caption = 'Параметры выборки'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object PageControl1: TPageControl
        Left = 1
        Top = 22
        Width = 324
        Height = 400
        ActivePage = TabSheet1
        Align = alClient
        TabOrder = 1
        object TabSheet1: TTabSheet
          Caption = 'Исходные данные'
          object ch_year_to: TCheckBox
            Left = 12
            Top = 286
            Width = 97
            Height = 17
            Caption = 'Год стр-ва до :'
            TabOrder = 0
          end
          object ch_year_from: TCheckBox
            Left = 12
            Top = 257
            Width = 97
            Height = 17
            Caption = 'Год стр-ва от :'
            TabOrder = 1
          end
          object ch_d_to: TCheckBox
            Left = 12
            Top = 228
            Width = 91
            Height = 17
            Caption = 'Диаметр до :'
            TabOrder = 2
          end
          object ch_d_from: TCheckBox
            Left = 12
            Top = 200
            Width = 91
            Height = 17
            Caption = 'Диаметр от :'
            TabOrder = 3
          end
          object ch_shop: TCheckBox
            Left = 12
            Top = 171
            Width = 51
            Height = 17
            Caption = 'Цех :'
            TabOrder = 4
          end
          object ch_deposit: TCheckBox
            Left = 12
            Top = 142
            Width = 111
            Height = 17
            Caption = 'Месторождение :'
            TabOrder = 5
          end
          object ed_d_from: TDBLookupComboBox
            Left = 134
            Top = 198
            Width = 103
            Height = 21
            KeyField = 'DIAMETR'
            ListField = 'DIAMETR'
            ListSource = ds_d_from
            TabOrder = 6
          end
          object ed_shop: TDBLookupComboBox
            Left = 134
            Top = 169
            Width = 171
            Height = 21
            KeyField = 'ID'
            ListField = 'NAME'
            ListSource = ds_shop
            TabOrder = 7
          end
          object ed_deposit: TDBLookupComboBox
            Left = 134
            Top = 140
            Width = 171
            Height = 21
            KeyField = 'ID'
            ListField = 'NAME'
            ListSource = ds_deposit
            TabOrder = 8
          end
          object rg_obj: TRadioGroup
            Left = 22
            Top = 10
            Width = 177
            Height = 115
            Caption = 'Принадлежность водовода : '
            ItemIndex = 0
            Items.Strings = (
              'КНС :'
              'НС :'
              'Куст :')
            TabOrder = 9
            OnClick = rg_objClick
          end
          object ed_kust: TDBLookupComboBox
            Left = 86
            Top = 92
            Width = 217
            Height = 21
            Enabled = False
            KeyField = 'ID'
            ListField = 'NAME'
            ListSource = ds_kust
            TabOrder = 10
          end
          object ed_ns: TDBLookupComboBox
            Left = 86
            Top = 61
            Width = 217
            Height = 21
            Enabled = False
            KeyField = 'ID'
            ListField = 'NAME'
            ListSource = ds_ns
            TabOrder = 11
          end
          object ed_kns: TDBLookupComboBox
            Left = 86
            Top = 30
            Width = 217
            Height = 21
            KeyField = 'ID'
            ListField = 'NAME'
            ListSource = ds_kns
            TabOrder = 12
          end
          object ed_d_to: TDBLookupComboBox
            Left = 134
            Top = 226
            Width = 103
            Height = 21
            KeyField = 'DIAMETR'
            ListField = 'DIAMETR'
            ListSource = ds_d_to
            TabOrder = 13
          end
          object ed_year_from: TRxSpinEdit
            Left = 134
            Top = 255
            Width = 105
            Height = 21
            MaxValue = 2005
            MinValue = 1978
            Value = 2000
            TabOrder = 14
          end
          object ed_year_to: TRxSpinEdit
            Left = 134
            Top = 284
            Width = 105
            Height = 21
            MaxValue = 2005
            MinValue = 1978
            Value = 2002
            TabOrder = 15
          end
        end
        object TabSheet2: TTabSheet
          Caption = 'Расчетные данные'
          ImageIndex = 1
          object Label1: TLabel
            Left = 68
            Top = 34
            Width = 44
            Height = 13
            Caption = 'Период :'
          end
          object ch_calc_select: TCheckBox
            Left = 8
            Top = 8
            Width = 263
            Height = 17
            Caption = 'Использовать в выборке расчетные данные'
            TabOrder = 0
            OnClick = ch_calc_selectClick
          end
          object ed_speed_from: TRxCalcEdit
            Left = 174
            Top = 58
            Width = 95
            Height = 21
            AutoSize = False
            NumGlyphs = 2
            TabOrder = 1
          end
          object ch_speed_from: TCheckBox
            Left = 6
            Top = 60
            Width = 161
            Height = 17
            Caption = 'Скорость течения (м/с) от :'
            TabOrder = 2
          end
          object ch_speed_to: TCheckBox
            Left = 6
            Top = 88
            Width = 161
            Height = 17
            Caption = 'Скорость течения (м/с) до :'
            TabOrder = 3
          end
          object ed_speed_to: TRxCalcEdit
            Left = 174
            Top = 86
            Width = 95
            Height = 21
            AutoSize = False
            NumGlyphs = 2
            TabOrder = 4
          end
          object ch_reg_flow: TCheckBox
            Left = 6
            Top = 118
            Width = 107
            Height = 17
            Caption = 'Режим течения :'
            TabOrder = 5
          end
          object ed_reg_flow: TRxSpinEdit
            Left = 174
            Top = 116
            Width = 95
            Height = 21
            MaxValue = 3
            MaxLength = 1
            TabOrder = 6
          end
          object ed_period: TComboBox
            Left = 124
            Top = 30
            Width = 145
            Height = 21
            ItemHeight = 13
            TabOrder = 7
          end
        end
      end
    end
    object Panel4: TPanel
      Left = 330
      Top = 1
      Width = 299
      Height = 423
      Align = alClient
      TabOrder = 1
      object Panel5: TPanel
        Left = 1
        Top = 1
        Width = 297
        Height = 21
        Align = alTop
        BevelOuter = bvLowered
        Caption = 'Результаты выборки'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object Panel6: TPanel
        Left = 1
        Top = 304
        Width = 297
        Height = 118
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 1
        object bt_del_rec: TBitBtn
          Left = 4
          Top = 6
          Width = 179
          Height = 21
          Caption = 'Удалить запись из выборки'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = bt_del_recClick
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
          Margin = 6
          NumGlyphs = 2
          Spacing = -1
        end
        object bt_select_to_excel: TBitBtn
          Left = 4
          Top = 88
          Width = 179
          Height = 25
          Caption = 'Выборку в Excel'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = bt_select_to_excelClick
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            08000000000000010000120B0000120B00000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
            A60004040400080808000C0C0C0011111100161616001C1C1C00222222002929
            2900555555004D4D4D004242420039393900807CFF005050FF009300D600FFEC
            CC00C6D6EF00D6E7E70090A9AD000000330000006600000099000000CC000033
            00000033330000336600003399000033CC000033FF0000660000006633000066
            6600006699000066CC000066FF00009900000099330000996600009999000099
            CC000099FF0000CC000000CC330000CC660000CC990000CCCC0000CCFF0000FF
            660000FF990000FFCC00330000003300330033006600330099003300CC003300
            FF00333300003333330033336600333399003333CC003333FF00336600003366
            330033666600336699003366CC003366FF003399000033993300339966003399
            99003399CC003399FF0033CC000033CC330033CC660033CC990033CCCC0033CC
            FF0033FF330033FF660033FF990033FFCC0033FFFF0066000000660033006600
            6600660099006600CC006600FF00663300006633330066336600663399006633
            CC006633FF00666600006666330066666600666699006666CC00669900006699
            330066996600669999006699CC006699FF0066CC000066CC330066CC990066CC
            CC0066CCFF0066FF000066FF330066FF990066FFCC00CC00FF00FF00CC009999
            000099339900990099009900CC009900000099333300990066009933CC009900
            FF00996600009966330099336600996699009966CC009933FF00999933009999
            6600999999009999CC009999FF0099CC000099CC330066CC660099CC990099CC
            CC0099CCFF0099FF000099FF330099CC660099FF990099FFCC0099FFFF00CC00
            000099003300CC006600CC009900CC00CC0099330000CC333300CC336600CC33
            9900CC33CC00CC33FF00CC660000CC66330099666600CC669900CC66CC009966
            FF00CC990000CC993300CC996600CC999900CC99CC00CC99FF00CCCC0000CCCC
            3300CCCC6600CCCC9900CCCCCC00CCCCFF00CCFF0000CCFF330099FF6600CCFF
            9900CCFFCC00CCFFFF00CC003300FF006600FF009900CC330000FF333300FF33
            6600FF339900FF33CC00FF33FF00FF660000FF663300CC666600FF669900FF66
            CC00CC66FF00FF990000FF993300FF996600FF999900FF99CC00FF99FF00FFCC
            0000FFCC3300FFCC6600FFCC9900FFCCCC00FFCCFF00FFFF3300CCFF6600FFFF
            9900FFFFCC006666FF0066FF660066FFFF00FF666600FF66FF00FFFF66002100
            A5005F5F5F00777777008686860096969600CBCBCB00B2B2B200D7D7D700DDDD
            DD00E3E3E300EAEAEA00F1F1F100F8F8F800F0FBFF00A4A0A000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00EEEEEEEEEEEE
            EEEEEEEEEEEEEEEEEEEEEE2727272727272727272727272727EEEE2727272727
            272727272727272727EEEE2727FFFFFFFFFFFFFFFFFFFF2727EEEE2727FFFFFF
            FFFFFF272727272727EEEE2727272727272727FF2727272727EEEE2727FF2727
            2727FF272727FF2727EEEE2727FFFF2727FF27272727FF2727EEEE2727FFFFFF
            FF272727FFFFFF2727EEEE2727FFFFFF2727272727FFFF2727EEEE2727FFFF27
            272727272727FF2727EEEE272727272727FFFF272727FF2727EEEE2727FFFFFF
            FFFFFFFFFFFFFF2727EEEE2727272727272727272727272727EEEE2727272727
            272727272727272727EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
          Margin = 6
          Spacing = -1
        end
        object bt_add_manual: TBitBtn
          Left = 4
          Top = 34
          Width = 179
          Height = 25
          Caption = 'Добавить из ручной выборки'
          Enabled = False
          TabOrder = 2
          OnClick = bt_add_manualClick
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
        object bt_del_manual_select: TButton
          Left = 192
          Top = 34
          Width = 87
          Height = 25
          Hint = 'Очистить ручную'#13#10'выборку.'
          Caption = 'Очистить Р.В.'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = bt_del_manual_selectClick
        end
      end
      object DBGrid1: TDBGrid
        Left = 1
        Top = 22
        Width = 297
        Height = 282
        Align = alClient
        DataSource = ds_select
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'name'
            Title.Alignment = taCenter
            Title.Caption = 'Участок ВВ'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'len'
            Title.Alignment = taCenter
            Title.Caption = 'Длина'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'diametr'
            Title.Alignment = taCenter
            Title.Caption = 'Диаметр'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'thick'
            Title.Alignment = taCenter
            Title.Caption = 'Толщина'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'build_year'
            Title.Alignment = taCenter
            Title.Caption = 'Год стр.'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID'
            Title.Alignment = taCenter
            Title.Caption = 'ИД'
            Visible = True
          end>
      end
    end
  end
  object Panel7: TPanel
    Left = 0
    Top = 425
    Width = 630
    Height = 35
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 1
    object bt_exit: TBitBtn
      Left = 158
      Top = 6
      Width = 75
      Height = 25
      Caption = 'ВЫХОД'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = bt_exitClick
    end
    object BitBtn1: TBitBtn
      Left = 10
      Top = 6
      Width = 141
      Height = 25
      Caption = 'Выбрать по условию'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn1Click
    end
  end
  object ds_select: TDataSource
    DataSet = cds_select
    Left = 462
    Top = 151
  end
  object cds_select: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = cds_selectAfterOpen
    AfterClose = cds_selectAfterClose
    AfterInsert = cds_selectAfterInsert
    Left = 430
    Top = 153
  end
  object cds_kns: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 287
    Top = 75
  end
  object cds_ns: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 287
    Top = 105
  end
  object cds_kust: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 288
    Top = 136
  end
  object ds_kns: TDataSource
    DataSet = cds_kns
    Left = 257
    Top = 75
  end
  object ds_ns: TDataSource
    DataSet = cds_ns
    Left = 257
    Top = 105
  end
  object ds_kust: TDataSource
    DataSet = cds_kust
    Left = 257
    Top = 137
  end
  object cds_deposit: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 302
    Top = 183
  end
  object cds_shop: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 302
    Top = 212
  end
  object cds_d_from: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 298
    Top = 243
  end
  object cds_d_to: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 298
    Top = 271
  end
  object ds_deposit: TDataSource
    DataSet = cds_deposit
    Left = 272
    Top = 185
  end
  object ds_shop: TDataSource
    DataSet = cds_shop
    Left = 272
    Top = 213
  end
  object ds_d_from: TDataSource
    DataSet = cds_d_from
    Left = 270
    Top = 241
  end
  object ds_d_to: TDataSource
    DataSet = cds_d_to
    Left = 270
    Top = 271
  end
  object cds_tmp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 443
    Top = 337
  end
end
