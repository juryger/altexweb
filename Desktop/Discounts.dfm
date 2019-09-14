object DiscountsForm: TDiscountsForm
  Left = 612
  Top = 319
  BorderStyle = bsDialog
  Caption = #209#232#241#242#229#236#224' '#241#234#232#228#238#234' ('#244#238#240#236#232#240#238#226#224#237#232#229' '#238#239#242#238#226#251#245' '#246#229#237')'
  ClientHeight = 281
  ClientWidth = 456
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
  object DBGridEh3: TDBGridEh
    Left = 0
    Top = 24
    Width = 456
    Height = 257
    Align = alClient
    AllowedOperations = [alopUpdateEh]
    DataSource = DBmod.DDiscounts
    Flat = True
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Color = clInactiveBorder
        EditButtons = <>
        FieldName = 'ID_COST_DCT'
        Footers = <>
        ReadOnly = True
        Title.Caption = #207#238#240#255#228#234#238#226#251#233' '#237#238#236#229#240
        Width = 105
      end
      item
        EditButtons = <>
        FieldName = 'START_SUMM'
        Footers = <>
        Title.Caption = #209#243#236#236#224' '#231#224#234#224#231#224' '#238#242' ($)'
        Width = 132
      end
      item
        EditButtons = <>
        FieldName = 'PROFIT_PERCENTAGE'
        Footers = <>
        Title.Caption = #205#224#234#240#243#242#234#224' (%)'
        Width = 158
      end>
  end
  object gControlsPanel: TPanel
    Left = 0
    Top = 0
    Width = 456
    Height = 24
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object addDiscountButton: TSpeedButton
      Left = 1
      Top = 2
      Width = 95
      Height = 21
      Hint = #196#238#225#224#226#232#242#252' '#237#238#226#243#254' '#231#224#239#232#241#252
      Caption = #196#238#225#224#226#232#242#252
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333FF33333333FF333993333333300033377F3333333777333993333333
        300033F77FFF3333377739999993333333333777777F3333333F399999933333
        33003777777333333377333993333333330033377F3333333377333993333333
        3333333773333333333F333333333333330033333333F33333773333333C3333
        330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
        333333333337733333FF3333333C333330003333333733333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = addDiscountButtonClick
    end
    object deleteDiscountButton: TSpeedButton
      Left = 95
      Top = 2
      Width = 95
      Height = 21
      Hint = #211#228#224#235#232#242#252' '#226#251#225#240#224#237#237#243#254' '#231#224#239#232#241#252
      Caption = #211#228#224#235#232#242#252
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
        3333333777777777F3333330F777777033333337F3F3F3F7F3333330F0808070
        33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
        33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
        333333F7F7F7F7F7F3F33030F080707030333737F7F7F7F7F7333300F0808070
        03333377F7F7F7F773333330F080707033333337F7F7F7F7F333333070707070
        33333337F7F7F7F7FF3333000000000003333377777777777F33330F88877777
        0333337FFFFFFFFF7F3333000000000003333377777777777333333330777033
        3333333337FFF7F3333333333000003333333333377777333333}
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = deleteDiscountButtonClick
    end
  end
end
