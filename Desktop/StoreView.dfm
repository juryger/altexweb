object StoreViewForm: TStoreViewForm
  Left = 809
  Top = 129
  BorderStyle = bsDialog
  Caption = #1057#1082#1083#1072#1076': '#1055#1088#1080#1093#1086#1076'/'#1057#1087#1080#1089#1072#1085#1080#1077
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
    Width = 45
    Height = 13
    Caption = #1054#1089#1090#1072#1090#1086#1082':'
  end
  object Label2: TLabel
    Left = 16
    Top = 50
    Width = 40
    Height = 13
    Caption = #1055#1088#1080#1093#1086#1076':'
  end
  object Label3: TLabel
    Left = 176
    Top = 50
    Width = 52
    Height = 13
    Caption = #1057#1087#1080#1089#1072#1085#1080#1077':'
  end
  object BalanceBox: TEdit
    Left = 80
    Top = 16
    Width = 233
    Height = 21
    Color = cl3DLight
    ReadOnly = True
    TabOrder = 4
    Text = '0'
  end
  object IncomeBox: TEdit
    Left = 80
    Top = 44
    Width = 73
    Height = 21
    TabOrder = 0
    Text = '0'
    OnExit = IncomeBoxExit
    OnKeyUp = IncomeBoxKeyUp
  end
  object OutcomeBox: TEdit
    Left = 240
    Top = 44
    Width = 73
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
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 184
    Top = 104
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
end
