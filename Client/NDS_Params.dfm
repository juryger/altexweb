object NdsParamsForm: TNdsParamsForm
  Left = 355
  Top = 335
  BorderStyle = bsToolWindow
  Caption = 'Parametri NDS'
  ClientHeight = 235
  ClientWidth = 246
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 6
    Width = 225
    Height = 187
    Caption = 'Nakldanaya'
    TabOrder = 0
    object simpleViewRadioButton: TRadioButton
      Left = 16
      Top = 24
      Width = 201
      Height = 17
      Caption = 'Obchiy vid (uprochenniy)'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = simpleViewRadioButtonClick
    end
    object ndsViewRadioButton: TRadioButton
      Left = 16
      Top = 72
      Width = 201
      Height = 17
      Caption = 'NDS'
      TabOrder = 2
      OnClick = ndsViewRadioButtonClick
    end
    object GroupBox2: TGroupBox
      Left = 16
      Top = 96
      Width = 193
      Height = 49
      Caption = 'NDS znachenie'
      TabOrder = 3
      object Label1: TLabel
        Left = 125
        Top = 23
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Edit1: TEdit
        Left = 8
        Top = 20
        Width = 113
        Height = 21
        Color = clBtnFace
        TabOrder = 0
        Text = '20'
      end
    end
    object noNdsViewRadioButton: TRadioButton
      Left = 16
      Top = 48
      Width = 201
      Height = 17
      Caption = 'Bez NDS'
      TabOrder = 1
      OnClick = noNdsViewRadioButtonClick
    end
    object TicketCheckBox: TCheckBox
      Left = 16
      Top = 165
      Width = 201
      Height = 17
      Caption = 'Dobavit'#39' kassoviy order'
      Enabled = False
      TabOrder = 4
    end
    object InvoiceCheckBox: TCheckBox
      Left = 16
      Top = 148
      Width = 201
      Height = 17
      Caption = 'Dobavit'#39' schet-factura'
      Enabled = False
      TabOrder = 5
    end
  end
  object BitBtn1: TBitBtn
    Left = 24
    Top = 201
    Width = 97
    Height = 25
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 128
    Top = 201
    Width = 97
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
end
