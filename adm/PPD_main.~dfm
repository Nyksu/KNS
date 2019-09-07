object fr_main: Tfr_main
  Left = 192
  Top = 249
  Width = 696
  Height = 480
  Caption = 'ППД  ADM. '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 415
    Width = 688
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 100
      end>
    SimplePanel = False
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 688
    Height = 75
    Bands = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 75
    Width = 688
    Height = 340
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 2
  end
  object MainMenu1: TMainMenu
    Left = 580
    Top = 8
    object N1: TMenuItem
      Caption = 'Система'
      object n_open: TMenuItem
        Caption = 'Открыть карту'
        OnClick = n_openClick
      end
      object n_reconnect: TMenuItem
        Caption = 'Войдти под другим именем'
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object n_exit: TMenuItem
        Caption = 'Выход'
        OnClick = n_exitClick
      end
    end
    object N2: TMenuItem
      Caption = 'Карта'
      object N4: TMenuItem
        Caption = 'Обновить'
      end
      object N5: TMenuItem
        Caption = 'Сохранить'
      end
      object N10: TMenuItem
        Caption = 'Импорт элементов схемы'
        object n_ns_import: TMenuItem
          Caption = 'Импорт НС'
          OnClick = n_ns_importClick
        end
        object n_kns_import: TMenuItem
          Caption = 'Импорт КНС'
          OnClick = n_kns_importClick
        end
        object n_kust_import: TMenuItem
          Caption = 'Импорт Кустов и скважин'
          OnClick = n_kust_importClick
        end
      end
    end
    object N9: TMenuItem
      Caption = 'Связи'
      object n_shop_dep: TMenuItem
        Caption = 'Цех - Месторождение'
        OnClick = n_shop_depClick
      end
      object n_dep_ns: TMenuItem
        Caption = 'НС - Месторождение'
      end
    end
    object N6: TMenuItem
      Caption = 'Справочники'
      object n_shop: TMenuItem
        Caption = 'Цеха'
        OnClick = n_shopClick
      end
      object n_deposit: TMenuItem
        Caption = 'Месторожденя'
        OnClick = n_depositClick
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object n_pump_type: TMenuItem
        Caption = 'Типы насосных агрегатов'
        OnClick = n_pump_typeClick
      end
      object n_pipe_type: TMenuItem
        Caption = 'Тип водовода'
      end
      object n_direction: TMenuItem
        Caption = 'Направления водоводов'
      end
      object n_found_state: TMenuItem
        Caption = 'Состояния по фонду'
      end
    end
    object N7: TMenuItem
      Caption = 'Расчеты'
    end
    object N8: TMenuItem
      Caption = 'Настройка'
    end
  end
  object Img_lst_tools: TImageList
    Left = 622
    Top = 14
  end
  object act_tools: TActionList
    Images = Img_lst_tools
    Left = 656
    Top = 14
  end
  object ofd_import_elements: TOpenDialog
    DefaultExt = '*.xls'
    Filter = 'Описание элементов схемы в EXCEL (*.xls)|*.xls'
    Title = 'Открытие файла реестра элементов схемы'
    Left = 506
    Top = 16
  end
end
