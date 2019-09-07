object fr_main: Tfr_main
  Left = 303
  Top = 226
  Width = 696
  Height = 480
  Caption = 'ППД draw studio. Центр. '
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
    end
    object N6: TMenuItem
      Caption = 'Справочники'
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
end
