object fr_legend: Tfr_legend
  Left = 616
  Top = 245
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Легенда'
  ClientHeight = 447
  ClientWidth = 247
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 376
    Width = 247
    Height = 71
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 0
    object bt_hide: TButton
      Left = 90
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Скрыть'
      TabOrder = 0
      OnClick = bt_hideClick
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 245
      Height = 32
      Align = alTop
      TabOrder = 1
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 243
        Height = 30
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Легенда текущих '#13#10'цветов водоводов схемы.'
      end
    end
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 0
    Width = 247
    Height = 376
    Align = alClient
    Images = ImageList1
    Indent = 35
    TabOrder = 1
  end
  object ImageList1: TImageList
    Height = 21
    Width = 32
    Left = 44
    Top = 42
  end
end
