object NdsParamsForm: TNdsParamsForm
  Left = 355
  Top = 335
  BorderStyle = bsToolWindow
  Caption = #207#224#240#224#236#229#242#240#251' '#205#196#209
  ClientHeight = 235
  ClientWidth = 246
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
    Caption = #194#232#228' '#237#224#234#235#224#228#237#238#233
    TabOrder = 0
    object simpleViewRadioButton: TRadioButton
      Left = 16
      Top = 24
      Width = 201
      Height = 17
      Caption = #206#225#249#232#233' '#226#232#228' ('#243#239#240#238#249#229#237#237#224#255')'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = simpleViewRadioButtonClick
    end
    object ndsViewRadioButton: TRadioButton
      Left = 16
      Top = 72
      Width = 201
      Height = 17
      Caption = #209' '#243#247#229#242#238#236' '#239#240#238#246#229#237#242#237#238#233' '#241#242#224#226#234#232
      TabOrder = 2
      OnClick = ndsViewRadioButtonClick
    end
    object GroupBox2: TGroupBox
      Left = 16
      Top = 96
      Width = 193
      Height = 49
      Caption = #205#196#209
      TabOrder = 3
      object Label1: TLabel
        Left = 125
        Top = 23
        Width = 8
        Height = 13
        Caption = '%'
      end
      object Edit1: TEdit
        Left = 8
        Top = 20
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
      Width = 201
      Height = 17
      Caption = #193#229#231' '#239#240#238#246#229#237#242#237#238#233' '#241#242#224#226#234#232
      TabOrder = 1
      OnClick = noNdsViewRadioButtonClick
    end
    object TicketCheckBox: TCheckBox
      Left = 16
      Top = 165
      Width = 201
      Height = 17
      Caption = #194#234#235#254#247#232#242#252' '#234#224#241#241#238#226#251#233' '#238#240#228#229#240
      Enabled = False
      TabOrder = 4
    end
    object InvoiceCheckBox: TCheckBox
      Left = 16
      Top = 148
      Width = 201
      Height = 17
      Caption = #194#234#235#254#247#232#242#252' '#241#247#229#242'-'#244#224#234#242#243#240#243
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
