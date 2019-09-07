object fr_spd_pipe_color: Tfr_spd_pipe_color
  Left = 430
  Top = 119
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Установка цветов скорости течения жидкости в водоводах'
  ClientHeight = 349
  ClientWidth = 567
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 567
    Height = 303
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object lb1: TRxLabel
      Left = 132
      Top = 26
      Width = 30
      Height = 13
      Caption = '0 м/с'
    end
    object lb2: TRxLabel
      Left = 424
      Top = 81
      Width = 30
      Height = 13
      Caption = '0 м/с'
    end
    object lb3: TRxLabel
      Left = 424
      Top = 137
      Width = 30
      Height = 13
      Caption = '0 м/с'
    end
    object lb4: TRxLabel
      Left = 424
      Top = 192
      Width = 30
      Height = 13
      Caption = '0 м/с'
    end
    object Panel2: TPanel
      Left = 16
      Top = 14
      Width = 95
      Height = 41
      BevelInner = bvLowered
      Color = clBlack
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 16
      Top = 69
      Width = 95
      Height = 41
      BevelInner = bvLowered
      Color = clNavy
      TabOrder = 1
      OnDblClick = Panel3DblClick
    end
    object Panel4: TPanel
      Left = 16
      Top = 123
      Width = 95
      Height = 41
      BevelInner = bvLowered
      Color = clFuchsia
      TabOrder = 2
      OnDblClick = Panel4DblClick
    end
    object Panel5: TPanel
      Left = 16
      Top = 178
      Width = 95
      Height = 41
      BevelInner = bvLowered
      Color = clRed
      TabOrder = 3
    end
    object tb2: TTrackBar
      Left = 124
      Top = 79
      Width = 295
      Height = 29
      Max = 100
      Orientation = trHorizontal
      Frequency = 1
      Position = 25
      SelEnd = 0
      SelStart = 0
      TabOrder = 4
      ThumbLength = 15
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = tb2Change
    end
    object tb3: TTrackBar
      Left = 124
      Top = 135
      Width = 295
      Height = 29
      Max = 100
      Orientation = trHorizontal
      Frequency = 1
      Position = 75
      SelEnd = 0
      SelStart = 0
      TabOrder = 5
      ThumbLength = 15
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = tb3Change
    end
    object tb4: TTrackBar
      Left = 124
      Top = 190
      Width = 295
      Height = 29
      Max = 100
      Orientation = trHorizontal
      Frequency = 1
      Position = 100
      SelEnd = 0
      SelStart = 0
      TabOrder = 6
      ThumbLength = 15
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = tb4Change
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 232
      Width = 141
      Height = 61
      Caption = 'Экстремум :'
      TabOrder = 7
      object lb_max: TLabel
        Left = 24
        Top = 30
        Width = 78
        Height = 13
        Alignment = taRightJustify
        Caption = 'MAX =  100 м/с'
      end
    end
    object ed2: TRxSpinEdit
      Left = 480
      Top = 78
      Width = 61
      Height = 21
      Increment = 0.1
      ValueType = vtFloat
      TabOrder = 8
      OnChange = ed2Change
    end
    object ed3: TRxSpinEdit
      Left = 480
      Top = 134
      Width = 61
      Height = 21
      Increment = 0.1
      ValueType = vtFloat
      TabOrder = 9
      OnChange = ed3Change
    end
    object ed4: TRxSpinEdit
      Left = 480
      Top = 188
      Width = 61
      Height = 21
      Increment = 0.1
      ValueType = vtFloat
      TabOrder = 10
      OnChange = ed4Change
    end
  end
  object bt_next: TBitBtn
    Left = 10
    Top = 316
    Width = 109
    Height = 25
    Caption = 'ПРОДОЛЖИТЬ'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = bt_nextClick
  end
end
