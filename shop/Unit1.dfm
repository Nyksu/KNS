object PrintPreviewform: TPrintPreviewform
  Left = 240
  Top = 134
  Width = 638
  Height = 345
  Cursor = crHelp
  Caption = 'Предпросмотр'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 448
    Top = 48
    Width = 46
    Height = 13
    Caption = 'Масштаб'
  end
  object PrintPreview1: TPrintPreview
    Left = 0
    Top = 0
    Width = 441
    Height = 281
    DiagramBox = fr_main.FieldMain
    Pen.Width = 2
  end
  object Button1: TButton
    Left = 440
    Top = 288
    Width = 91
    Height = 25
    Caption = 'Печать'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 536
    Top = 288
    Width = 91
    Height = 25
    Caption = 'Отмена'
    TabOrder = 2
    OnClick = Button2Click
  end
  object RxSpinEdit1: TRxSpinEdit
    Left = 448
    Top = 64
    Width = 113
    Height = 21
    MaxValue = 5000
    MinValue = 1
    TabOrder = 3
    OnChange = RxSpinEdit1Change
  end
  object Button3: TButton
    Left = 0
    Top = 288
    Width = 105
    Height = 25
    Caption = 'По ширине листа'
    TabOrder = 4
  end
  object Button4: TButton
    Left = 448
    Top = 8
    Width = 177
    Height = 25
    Caption = 'выбор принтера'
    TabOrder = 5
    OnClick = Button4Click
  end
  object GroupBox1: TGroupBox
    Left = 448
    Top = 96
    Width = 169
    Height = 185
    Caption = 'Макет страницы'
    TabOrder = 6
    object RadioButton1: TRadioButton
      Left = 8
      Top = 16
      Width = 113
      Height = 17
      Caption = 'Книжная'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 8
      Top = 32
      Width = 113
      Height = 17
      Caption = 'Альбомная'
      TabOrder = 1
      OnClick = RadioButton1Click
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 48
      Width = 153
      Height = 129
      Caption = 'Отступы (мм)'
      TabOrder = 2
      object Label4: TLabel
        Left = 13
        Top = 52
        Width = 30
        Height = 13
        Caption = 'Снизу'
      end
      object Label3: TLabel
        Left = 13
        Top = 76
        Width = 37
        Height = 13
        Caption = 'Справа'
      end
      object Label2: TLabel
        Left = 13
        Top = 20
        Width = 35
        Height = 13
        Caption = 'Сверху'
      end
      object Label1: TLabel
        Left = 13
        Top = 104
        Width = 31
        Height = 13
        Caption = 'Слева'
      end
      object SpinEdit1: TSpinEdit
        Left = 64
        Top = 48
        Width = 73
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
        OnChange = SpinEdit1Change
      end
      object SpinEdit2: TSpinEdit
        Left = 64
        Top = 99
        Width = 73
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 0
        OnChange = SpinEdit2Change
      end
      object SpinEdit3: TSpinEdit
        Left = 64
        Top = 75
        Width = 73
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 2
        Value = 0
        OnChange = SpinEdit3Change
      end
      object SpinEdit4: TSpinEdit
        Left = 64
        Top = 19
        Width = 73
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 3
        Value = 0
        OnChange = SpinEdit4Change
      end
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 592
    Top = 40
  end
  object PrintDialog1: TPrintDialog
    Left = 560
    Top = 40
  end
end
