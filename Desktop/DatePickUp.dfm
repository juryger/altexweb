object DPickUpForm: TDPickUpForm
  Left = 319
  Top = 158
  BorderStyle = bsDialog
  Caption = #194#251#225#238#240' '#228#224#242#251
  ClientHeight = 283
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 135
    Height = 13
    Caption = #194#251#225#229#240#232#242#229' '#228#224#242#243' '#231#224#234#224#231#224
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object MonthCalendar1: TMonthCalendar
    Left = 16
    Top = 24
    Width = 225
    Height = 177
    Date = 38286.558412905090000000
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 50
    Top = 245
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 146
    Top = 245
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
  object UseStoreCheckBox: TCheckBox
    Left = 32
    Top = 216
    Width = 209
    Height = 17
    Caption = #207#240#238#226#229#240#234#224'?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
end
