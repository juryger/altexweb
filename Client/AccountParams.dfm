object frmAccountParams: TfrmAccountParams
  Left = 501
  Top = 315
  Width = 370
  Height = 246
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1085#1072#1082#1083#1072#1076#1085#1086#1081
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
    Width = 57
    Height = 13
    Caption = #1044#1072#1090#1072' '#1089#1095#1105#1090#1072
  end
  object Label4: TLabel
    Left = 16
    Top = 16
    Width = 65
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1089#1095#1105#1090#1072
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 64
    Width = 321
    Height = 89
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1053#1044#1057
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
      Caption = #1041#1077#1079' '#1053#1044#1057
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
      Caption = #1053#1044#1057
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
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    Kind = bkCancel
  end
  object btOkay: TBitBtn
    Left = 64
    Top = 167
    Width = 97
    Height = 25
    Caption = #1054#1050
    TabOrder = 2
    Kind = bkOK
  end
end
