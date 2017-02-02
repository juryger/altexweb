object BeforPricePrintForm: TBeforPricePrintForm
  Left = 366
  Top = 468
  BorderStyle = bsDialog
  Caption = 'ѕечать прайса'
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
    Width = 244
    Height = 28
    Caption = '”кажите документы, которые необходимо вывести на печать:'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object PriceCheckBox: TCheckBox
    Left = 64
    Top = 48
    Width = 145
    Height = 17
    Caption = 'ќбычный прайс-лист'
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
    Left = 64
    Top = 72
    Width = 137
    Height = 17
    Caption = '÷ветной каталог'
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
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 136
    Top = 104
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
end
