object frmAccountParams: TfrmAccountParams
  Left = 501
  Top = 315
  Width = 370
  Height = 205
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1095#1077#1090#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 152
    Top = 16
    Width = 57
    Height = 13
    Caption = #1044#1072#1090#1072' '#1089#1095#1105#1090#1072
  end
  object Label2: TLabel
    Left = 133
    Top = 83
    Width = 8
    Height = 13
    Caption = '%'
  end
  object Label3: TLabel
    Left = 16
    Top = 64
    Width = 99
    Height = 13
    Caption = #1055#1088#1086#1094#1077#1085#1090#1085#1072#1103' '#1089#1090#1072#1074#1082#1072
  end
  object Label4: TLabel
    Left = 16
    Top = 16
    Width = 65
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1089#1095#1105#1090#1072
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
  object tbPercentageValue: TEdit
    Left = 16
    Top = 80
    Width = 113
    Height = 21
    TabOrder = 2
    Text = '18'
    OnKeyPress = tbAccNoKeyPress
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
    Top = 125
    Width = 97
    Height = 25
    TabOrder = 4
    Kind = bkCancel
  end
  object btOkay: TBitBtn
    Left = 64
    Top = 125
    Width = 97
    Height = 25
    TabOrder = 3
    Kind = bkOK
  end
end
