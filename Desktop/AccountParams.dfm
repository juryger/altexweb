object frmAccountParams: TfrmAccountParams
  Left = 501
  Top = 315
  Width = 370
  Height = 246
  Caption = 'Parametri nakladnoy'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 152
    Top = 16
    Width = 58
    Height = 13
    Caption = 'Data scheta'
  end
  object Label4: TLabel
    Left = 16
    Top = 16
    Width = 66
    Height = 13
    Caption = 'Nomer scheta'
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 64
    Width = 321
    Height = 89
    Caption = 'NDS'
    TabOrder = 4
    object Label2: TLabel
      Left = 136
      Top = 56
      Width = 8
      Height = 13
      Caption = '%'
    end
    object RadioButton1: TRadioButton
      Left = 16
      Top = 24
      Width = 113
      Height = 17
      Caption = 'Bez NDS'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 16
      Top = 56
      Width = 113
      Height = 17
      Caption = 'NDS'
      TabOrder = 1
      OnClick = RadioButton2Click
    end
    object tbPercentageValue: TEdit
      Left = 67
      Top = 53
      Width = 67
      Height = 21
      Enabled = False
      TabOrder = 2
      Text = '20'
      OnKeyPress = tbAccNoKeyPress
    end
  end
  object dtpAccountDate: TDateTimePicker
    Left = 152
    Top = 32
    Width = 186
    Height = 21
    Date = 42806.481059699070000000
    Time = 42806.481059699070000000
    TabOrder = 1
  end
  object tbAccNo: TEdit
    Left = 16
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
    OnKeyPress = tbAccNoKeyPress
  end
  object btCancel: TBitBtn
    Left = 192
    Top = 166
    Width = 97
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
  object btOkay: TBitBtn
    Left = 64
    Top = 167
    Width = 97
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
end
