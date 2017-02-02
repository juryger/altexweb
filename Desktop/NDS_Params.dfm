object NdsParamsForm: TNdsParamsForm
  Left = 358
  Top = 335
  BorderStyle = bsToolWindow
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
  ClientHeight = 235
  ClientWidth = 243
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
    Caption = #1042#1080#1076' '#1085#1072#1082#1083#1072#1076#1085#1086#1081
    TabOrder = 0
    object simpleViewRadioButton: TRadioButton
      Left = 16
      Top = 24
      Width = 201
      Height = 17
      Caption = #1054#1073#1097#1080#1081' '#1074#1080#1076' ('#1091#1087#1088#1086#1097#1077#1085#1085#1099#1081' '#1074#1072#1088#1080#1072#1085#1090')'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = simpleViewRadioButtonClick
    end
    object ndsViewRadioButton: TRadioButton
      Left = 16
      Top = 72
      Width = 113
      Height = 17
      Caption = #1057' % '#1089#1090#1072#1074#1082#1086#1081
      TabOrder = 2
      OnClick = ndsViewRadioButtonClick
    end
    object GroupBox2: TGroupBox
      Left = 16
      Top = 88
      Width = 193
      Height = 57
      Caption = #1053#1044#1057
      TabOrder = 3
      object Label1: TLabel
        Left = 125
        Top = 27
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Edit1: TEdit
        Left = 8
        Top = 24
        Width = 113
        Height = 21
        Color = clBtnFace
        TabOrder = 0
        Text = '18'
      end
    end
    object noNdsViewRadioButton: TRadioButton
      Left = 16
      Top = 48
      Width = 113
      Height = 17
      Caption = #1041#1077#1079' % '#1089#1090#1072#1074#1082#1080
      TabOrder = 1
      OnClick = noNdsViewRadioButtonClick
    end
    object TicketCheckBox: TCheckBox
      Left = 16
      Top = 165
      Width = 185
      Height = 17
      Caption = #1056#1072#1089#1087#1077#1095#1072#1090#1100' '#1050#1072#1089#1086#1074#1099#1081' '#1086#1088#1076#1077#1088
      Enabled = False
      TabOrder = 4
    end
    object InvoiceCheckBox: TCheckBox
      Left = 16
      Top = 148
      Width = 185
      Height = 17
      Caption = #1056#1072#1089#1087#1077#1095#1072#1090#1100' '#1057#1095#1077#1090'-'#1092#1072#1082#1090#1091#1088#1091
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
