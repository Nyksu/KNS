object fr_pipe_d: Tfr_pipe_d
  Left = 434
  Top = 443
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Справочник диаметров водоводов'
  ClientHeight = 246
  ClientWidth = 338
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
    Width = 82
    Height = 246
    Align = alLeft
    BevelOuter = bvLowered
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 80
      Height = 21
      Align = alTop
      Caption = 'Цвет :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object pn_color: TPanel
      Left = 20
      Top = 40
      Width = 43
      Height = 151
      TabOrder = 1
    end
    object bt_ed_color: TButton
      Left = 10
      Top = 210
      Width = 63
      Height = 25
      Caption = 'Изменить'
      TabOrder = 2
      OnClick = bt_ed_colorClick
    end
  end
  object Panel3: TPanel
    Left = 82
    Top = 0
    Width = 135
    Height = 246
    Align = alLeft
    BevelOuter = bvLowered
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 133
      Height = 180
      Align = alTop
      DataSource = ds_pipe_d
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
          FieldName = 'DIAMETR'
          Title.Alignment = taCenter
          Title.Caption = 'Диаметр (мм) '
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 90
          Visible = True
        end>
    end
    object bt_ed_d: TBitBtn
      Left = 28
      Top = 186
      Width = 75
      Height = 25
      Caption = 'Изменить'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = bt_ed_dClick
    end
    object bt_add: TBitBtn
      Left = 28
      Top = 216
      Width = 75
      Height = 25
      Caption = 'Добавить'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = bt_addClick
    end
  end
  object bt_close: TBitBtn
    Left = 228
    Top = 214
    Width = 99
    Height = 25
    Caption = 'ВЫХОД'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = bt_closeClick
  end
  object cds_pipe_d: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 124
    Top = 58
  end
  object ds_pipe_d: TDataSource
    DataSet = cds_pipe_d
    OnDataChange = ds_pipe_dDataChange
    Left = 126
    Top = 88
  end
end
