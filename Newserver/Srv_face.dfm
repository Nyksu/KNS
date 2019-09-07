object fr_face: Tfr_face
  Left = 521
  Top = 111
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Сервер ППД'
  ClientHeight = 355
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 14
    Top = 6
    Width = 117
    Height = 32
    Alignment = taCenter
    Caption = 'Подключенные '#13#10'пользователи :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 144
    Top = 22
    Width = 301
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Текущие операции :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ls_users: TListBox
    Left = 8
    Top = 42
    Width = 127
    Height = 151
    ItemHeight = 13
    TabOrder = 0
  end
  object ls_operations: TListBox
    Left = 142
    Top = 42
    Width = 301
    Height = 151
    ItemHeight = 13
    TabOrder = 1
  end
  object ed_last_sql: TMemo
    Left = 10
    Top = 202
    Width = 433
    Height = 129
    TabOrder = 2
  end
  object st_bar: TStatusBar
    Left = 0
    Top = 336
    Width = 449
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 100
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object MainMenu1: TMainMenu
    object N1: TMenuItem
      Caption = 'Система'
      object n_hide: TMenuItem
        Caption = 'Свернуть сервер'
        OnClick = n_hideClick
      end
      object n_block: TMenuItem
        Caption = 'Заблокировать сервер'
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object n_close: TMenuItem
        Caption = 'Выключить сервер'
        OnClick = Close1Click
      end
    end
    object N6: TMenuItem
      Caption = 'Пользователи'
      object N8: TMenuItem
        Caption = 'Отключить пользователя'
      end
      object N9: TMenuItem
        Caption = 'Заблокировать пользователя'
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object N11: TMenuItem
        Caption = 'Послать сообщение пользователю'
      end
    end
    object N7: TMenuItem
      Caption = 'Операции'
      object N12: TMenuItem
        Caption = 'Очистить монитор операций'
        OnClick = N12Click
      end
    end
    object N2: TMenuItem
      Caption = '?'
      object n_about: TMenuItem
        Caption = 'О программе'
        OnClick = n_aboutClick
      end
    end
  end
  object RxTrayIcon1: TRxTrayIcon
    Icon.Data = {
      0000010002002020100000000000E80200002600000010101000000000002801
      00000E0300002800000020000000400000000100040000000000800200000000
      0000000000000000000000000000000000000000800000800000008080008000
      0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
      0000FF00FF00FFFF0000FFFFFF000000000000000000000000000000000007F7
      F7F7F7F700000007F7F7F7F7F7000000000000000000000000000000000000FF
      FFFFFFF0CCC0CCC0FFFFFFFFF000000000000000000C00000000000000000000
      FFFFF000000C000000FFFFF000000000F000F000000C000000F000F000000000
      F000F000000C000000F000F000000000FFFFF000000C000000FFFFF000000000
      00000000000C0000000000000000000000000000000C00000000000000000000
      00000000000C000000000000000007F7F7F7F7F7000C0007F7F7F7F7F7000000
      00000000000C000000000000000000FFFFFFFFF0CCCCCCC0FFFFFFFFF0000000
      00000000000C00000000000000000000FFFFF000000C000000FFFFF000000000
      F000F000000C000000F000F000000000F000F000000C000000F000F000000000
      FFFFF000000C000000FFFFF00000000000000000000C00000000000000000000
      00000000000C0000000000000000000000000000000000000000000000000000
      0000007F7F7F7F7F700000000000000000000000000000000000000000000000
      0000000FFFFFFFFF000000000000000000000000000000000000000000000000
      000000000FFFFF000000000000000000000000000F000F000000000000000000
      000000000F000F000000000000000000000000000FFFFF000000000000000000
      00000000000000000000000000000007C0010007C001800FE00380010003800E
      E003E03EF80FE03EF80FE03EF80FE03EF80FF07EFC1FFFFEFFFF0006C0010006
      C001800EE00380000003800EE003E03EF80FE03EF80FE03EF80FE03EF80FF07E
      FC1FFFFEFFFFFF8003FFFF8003FFFFC007FFFFC007FFFFC007FFFFF01FFFFFF0
      1FFFFFF01FFFFFF01FFFFFF83FFF280000001000000020000000010004000000
      0000C00000000000000000000000000000000000000000000000000080000080
      00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
      000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000000008F7
      F0CCC08F7F000000000C00000000008F000C0008F0000000000C000000000000
      000C0000000008F7F0CCC08F7F000000000C00000000008F000C0008F0000000
      000C000000000000000C0000000000000000000000000000008F7F0000000000
      00000000000000000008F0000000000000000000000003810000000100000281
      000086C3000086C3000002810000000100000281000086C3000086C30000FEFF
      0000F81F0000F81F0000F81F0000FC3F0000FC3F0000}
    PopupMenu = RxPopupMenu1
    Left = 136
    Top = 2
  end
  object RxPopupMenu1: TRxPopupMenu
    MenuAnimation = [maBottomToTop]
    Left = 178
    Top = 2
    object Show1: TMenuItem
      Caption = 'Show'
      OnClick = Show1Click
    end
    object Close1: TMenuItem
      Caption = 'Close'
      OnClick = Close1Click
    end
  end
end
