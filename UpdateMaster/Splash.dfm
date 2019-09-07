object fr_splash: Tfr_splash
  Left = 215
  Top = 376
  Cursor = crHourGlass
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Splash'
  ClientHeight = 331
  ClientWidth = 332
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
  object lName: TRxLabel
    Left = 4
    Top = 288
    Width = 77
    Height = 16
    Caption = 'Название'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lVer: TRxLabel
    Left = 236
    Top = 292
    Width = 42
    Height = 13
    Caption = 'Версия '
  end
  object Panel1: TPanel
    Left = 0
    Top = 311
    Width = 332
    Height = 20
    Align = alBottom
    BevelOuter = bvLowered
    Caption = 'Подождите.. Идет загрузка программы...'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
end
