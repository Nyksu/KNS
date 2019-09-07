object fr_quick_result: Tfr_quick_result
  Left = 378
  Top = 167
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Быстрый просмотр результатов'
  ClientHeight = 463
  ClientWidth = 541
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 541
    Height = 353
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 109
      Top = 1
      Width = 3
      Height = 351
      Cursor = crHSplit
      Align = alRight
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 108
      Height = 351
      Align = alClient
      TabOrder = 0
      object lb_period: TListBox
        Left = 1
        Top = 22
        Width = 106
        Height = 328
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemHeight = 16
        ParentFont = False
        TabOrder = 0
        OnClick = lb_periodClick
      end
      object Panel5: TPanel
        Left = 1
        Top = 1
        Width = 106
        Height = 21
        Align = alTop
        BevelOuter = bvLowered
        Caption = 'Период'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
    end
    object gr_params: TStringGrid
      Left = 112
      Top = 1
      Width = 428
      Height = 351
      Align = alRight
      Color = clSilver
      ColCount = 3
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 30
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentFont = False
      TabOrder = 1
      ColWidths = (
        240
        75
        86)
    end
  end
  object bt_close: TButton
    Left = 462
    Top = 360
    Width = 75
    Height = 25
    Caption = 'Закрыть'
    TabOrder = 1
    OnClick = bt_closeClick
  end
  object mm_per_about: TMemo
    Left = 0
    Top = 353
    Width = 285
    Height = 110
    Align = alLeft
    ScrollBars = ssBoth
    TabOrder = 2
  end
end
