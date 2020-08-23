object BeforPricePrintForm: TBeforPricePrintForm
  Left = 366
  Top = 468
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1077#1095#1072#1090#1080' '#1055#1088#1072#1081#1089#1072
  ClientHeight = 139
  ClientWidth = 263
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
    Left = 12
    Top = 8
    Width = 237
    Height = 17
    Caption = #1059#1082#1072#1078#1080#1090#1077' '#1090#1080#1087' '#1087#1088#1072#1081#1089#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object PriceCheckBox: TCheckBox
    Left = 40
    Top = 48
    Width = 185
    Height = 17
    Caption = #1059#1087#1088#1086#1097#1077#1085#1085#1099#1081' '#1074#1080#1076' ('#1073#1077#1079' '#1092#1086#1090#1086')'
    Checked = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 0
  end
  object ColorCatalogCheckBox: TCheckBox
    Left = 40
    Top = 72
    Width = 193
    Height = 17
    Caption = #1055#1086#1083#1085#1099#1081' '#1074#1080#1076' '#1089' '#1092#1086#1090#1086#1075#1088#1072#1092#1080#1103#1084#1080
    Checked = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 40
    Top = 104
    Width = 75
    Height = 25
    Caption = #1054#1050
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 136
    Top = 104
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    Kind = bkCancel
  end
end
