object fr_users: Tfr_users
  Left = 278
  Top = 205
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Пользователи системы'
  ClientHeight = 478
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 206
    Width = 110
    Height = 13
    Caption = 'Статус в системе:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBText1: TDBText
    Left = 128
    Top = 206
    Width = 50
    Height = 13
    AutoSize = True
    DataField = 'COMENT'
    DataSource = ds_users
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 60
    Top = 230
    Width = 59
    Height = 13
    Caption = 'Аккаутнт:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lb_account: TLabel
    Left = 128
    Top = 230
    Width = 78
    Height = 13
    Caption = 'Активирован'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 47
    Top = 254
    Width = 72
    Height = 13
    Alignment = taRightJustify
    Caption = 'Должность:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 21
    Top = 278
    Width = 98
    Height = 13
    Alignment = taRightJustify
    Caption = 'Подразделение:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBText2: TDBText
    Left = 128
    Top = 254
    Width = 50
    Height = 13
    AutoSize = True
    DataField = 'posit'
    DataSource = ds_users
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBText3: TDBText
    Left = 128
    Top = 278
    Width = 50
    Height = 13
    AutoSize = True
    DataField = 'divname'
    DataSource = ds_users
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 386
    Height = 195
    Align = alTop
    DataSource = ds_users
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NAME'
        Title.Alignment = taCenter
        Title.Caption = 'ФИО'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOGIN_NAME'
        Title.Alignment = taCenter
        Title.Caption = 'Псевдоним'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 90
        Visible = True
      end>
  end
  object bt_exit: TBitBtn
    Left = 304
    Top = 448
    Width = 75
    Height = 25
    Caption = 'ВЫХОД'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = bt_exitClick
  end
  object bt_account: TButton
    Left = 12
    Top = 348
    Width = 213
    Height = 19
    Caption = 'Активировать / деактивировать'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = bt_accountClick
  end
  object bt_add: TBitBtn
    Left = 12
    Top = 316
    Width = 97
    Height = 25
    Caption = 'Добавить'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = bt_addClick
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
    Margin = 6
    NumGlyphs = 2
    Spacing = -1
  end
  object bt_del: TBitBtn
    Left = 128
    Top = 316
    Width = 97
    Height = 25
    Caption = 'Удалить'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = bt_delClick
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
  object bt_roles: TButton
    Left = 12
    Top = 374
    Width = 213
    Height = 19
    Caption = 'Изменить статус в системе'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = bt_rolesClick
  end
  object bt_names: TButton
    Left = 12
    Top = 400
    Width = 213
    Height = 19
    Caption = 'Изменить ФИО пользователя'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = bt_namesClick
  end
  object bt_ps: TButton
    Left = 12
    Top = 426
    Width = 213
    Height = 19
    Caption = 'Изменить пароль пользователя'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = bt_psClick
  end
  object ch_show_del: TCheckBox
    Left = 238
    Top = 320
    Width = 137
    Height = 17
    Caption = 'Показать удаленных'
    TabOrder = 8
    OnClick = ch_show_delClick
  end
  object bt_divname: TButton
    Left = 12
    Top = 452
    Width = 213
    Height = 19
    Caption = 'Изменить должность'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = bt_divnameClick
  end
  object cds_users: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 316
    Top = 88
  end
  object ds_users: TDataSource
    DataSet = cds_users
    OnDataChange = ds_usersDataChange
    Left = 276
    Top = 86
  end
end
