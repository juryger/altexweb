object StoreViewForm: TStoreViewForm
  Left = 751
  Top = 347
  BorderStyle = bsDialog
  Caption = #1053#1072#1083#1080#1095#1080#1077' '#1090#1086#1074#1072#1088#1072' '#1085#1072' '#1089#1082#1083#1072#1076#1077
  ClientHeight = 149
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 23
    Width = 78
    Height = 13
    Caption = #1058#1077#1082'. '#1089#1086#1089#1090#1086#1103#1085#1080#1077
  end
  object Label2: TLabel
    Left = 16
    Top = 50
    Width = 52
    Height = 13
    Caption = #1055#1086#1089#1090#1072#1074#1082#1072':'
  end
  object Label3: TLabel
    Left = 192
    Top = 50
    Width = 50
    Height = 13
    Caption = #1054#1090#1075#1088#1091#1079#1082#1072':'
  end
  object BalanceBox: TEdit
    Left = 104
    Top = 16
    Width = 209
    Height = 21
    Color = cl3DLight
    ReadOnly = True
    TabOrder = 4
    Text = '0'
  end
  object IncomeBox: TEdit
    Left = 104
    Top = 44
    Width = 57
    Height = 21
    TabOrder = 0
    Text = '0'
    OnExit = IncomeBoxExit
    OnKeyUp = IncomeBoxKeyUp
  end
  object OutcomeBox: TEdit
    Left = 256
    Top = 44
    Width = 57
    Height = 21
    TabOrder = 1
    Text = '0'
    OnExit = OutcomeBoxExit
    OnKeyUp = OutcomeBoxKeyUp
  end
  object BitBtn1: TBitBtn
    Left = 88
    Top = 104
    Width = 75
    Height = 25
    Caption = #1054#1050
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 184
    Top = 104
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    Kind = bkCancel
  end
end
