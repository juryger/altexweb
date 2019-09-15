object StoreViewForm: TStoreViewForm
  Left = 751
  Top = 347
  BorderStyle = bsDialog
  Caption = '?????: ??????/????????'
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
    Caption = '???????:'
  end
  object Label2: TLabel
    Left = 16
    Top = 50
    Width = 39
    Height = 13
    Caption = '??????:'
  end
  object Label3: TLabel
    Left = 176
    Top = 50
    Width = 51
    Height = 13
    Caption = '????????:'
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
