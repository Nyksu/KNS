object fr_print_dlg: Tfr_print_dlg
  Left = 209
  Top = 104
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Печать схемы'
  ClientHeight = 362
  ClientWidth = 638
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 453
    Top = 0
    Width = 185
    Height = 362
    Align = alRight
    BevelOuter = bvLowered
    TabOrder = 0
    object bt_prn_setup: TBitBtn
      Left = 16
      Top = 260
      Width = 157
      Height = 25
      Caption = 'Установки принтера'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = bt_prn_setupClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555550FF0559
        1950555FF75F7557F7F757000FF055591903557775F75557F77570FFFF055559
        1933575FF57F5557F7FF0F00FF05555919337F775F7F5557F7F700550F055559
        193577557F7F55F7577F07550F0555999995755575755F7FFF7F5570F0755011
        11155557F755F777777555000755033305555577755F75F77F55555555503335
        0555555FF5F75F757F5555005503335505555577FF75F7557F55505050333555
        05555757F75F75557F5505000333555505557F777FF755557F55000000355557
        07557777777F55557F5555000005555707555577777FF5557F55553000075557
        0755557F7777FFF5755555335000005555555577577777555555}
      NumGlyphs = 2
    end
    object bt_print: TBitBtn
      Left = 16
      Top = 295
      Width = 157
      Height = 25
      Caption = 'Печать'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = bt_printClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      Margin = 6
      NumGlyphs = 2
      Spacing = -1
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 183
      Height = 192
      Align = alTop
      Caption = 'Параметры страницы :'
      TabOrder = 2
      object rb_portrait: TRadioButton
        Left = 8
        Top = 24
        Width = 69
        Height = 17
        Caption = 'Книжная'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rb_portraitClick
      end
      object rb_landscape: TRadioButton
        Left = 94
        Top = 24
        Width = 83
        Height = 17
        Caption = 'Альбомная'
        TabOrder = 1
        OnClick = rb_portraitClick
      end
      object GroupBox2: TGroupBox
        Left = 16
        Top = 50
        Width = 153
        Height = 129
        Caption = 'Поля (мм)'
        TabOrder = 2
        object Label4: TLabel
          Left = 18
          Top = 55
          Width = 30
          Height = 13
          Caption = 'Снизу'
        end
        object Label3: TLabel
          Left = 11
          Top = 80
          Width = 37
          Height = 13
          Caption = 'Справа'
        end
        object Label2: TLabel
          Left = 13
          Top = 31
          Width = 35
          Height = 13
          Caption = 'Сверху'
        end
        object Label5: TLabel
          Left = 17
          Top = 104
          Width = 31
          Height = 13
          Caption = 'Слева'
        end
        object ed_d_bottom: TSpinEdit
          Left = 64
          Top = 49
          Width = 73
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = ed_d_bottomChange
        end
        object ed_d_left: TSpinEdit
          Left = 64
          Top = 98
          Width = 73
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = ed_d_leftChange
        end
        object ed_d_right: TSpinEdit
          Left = 64
          Top = 74
          Width = 73
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnChange = ed_d_rightChange
        end
        object ed_d_top: TSpinEdit
          Left = 64
          Top = 25
          Width = 73
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnChange = ed_d_topChange
        end
      end
    end
    object bt_exit: TBitBtn
      Left = 16
      Top = 330
      Width = 157
      Height = 25
      Caption = 'Выход'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = bt_exitClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
        0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
        0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
        0333337F777FFFFF7F3333000000000003333377777777777333}
      Margin = 6
      NumGlyphs = 2
      Spacing = -1
    end
    object Button3: TButton
      Left = 14
      Top = 202
      Width = 157
      Height = 19
      Caption = 'Уменьшить схему'
      TabOrder = 4
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 423
    Height = 362
    Align = alLeft
    BevelOuter = bvLowered
    TabOrder = 1
    object Panel3: TPanel
      Left = 1
      Top = 326
      Width = 421
      Height = 35
      Align = alBottom
      TabOrder = 0
      object Label1: TLabel
        Left = 6
        Top = 12
        Width = 62
        Height = 13
        Caption = 'Масштаб :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ed_mastab: TRxSpinEdit
        Left = 72
        Top = 8
        Width = 75
        Height = 21
        MaxValue = 5000
        MinValue = 1
        Value = 1
        TabOrder = 0
        OnChange = ed_mastabChange
      end
      object bt_set_mas_to_page: TButton
        Left = 170
        Top = 6
        Width = 79
        Height = 25
        Caption = 'Вся схема'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        Visible = False
        OnClick = bt_set_mas_to_pageClick
      end
      object Button2: TButton
        Left = 262
        Top = 6
        Width = 149
        Height = 25
        Caption = 'Начальное стостояние'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = Button2Click
      end
    end
    object PrintPreview1: TPrintPreview
      Left = 2
      Top = 2
      Width = 417
      Height = 321
      DiagramBox = fr_main.FieldMain
      Pen.Width = 2
    end
  end
  object PrintDialog1: TPrintDialog
    Left = 424
    Top = 4
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 424
    Top = 36
  end
end
