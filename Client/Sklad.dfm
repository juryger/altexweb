object SkladForm: TSkladForm
  Left = 430
  Top = 308
  Width = 1028
  Height = 629
  Caption = '??????'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 166
    Top = 0
    Height = 590
  end
  object Panel1: TPanel
    Left = 169
    Top = 0
    Width = 843
    Height = 590
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Panel3: TPanel
      Left = 2
      Top = 563
      Width = 839
      Height = 25
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object SpeedButton2: TSpeedButton
        Left = 136
        Top = 2
        Width = 134
        Height = 21
        Caption = '??????? ???????'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
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
        OnClick = SpeedButton2Click
      end
      object Label1: TLabel
        Left = 619
        Top = 5
        Width = 93
        Height = 13
        Caption = '< ????? ??????'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SpeedButton3: TSpeedButton
        Left = 2
        Top = 2
        Width = 134
        Height = 21
        Caption = '??????????? ???'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clPurple
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
          00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
          8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
          8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
          8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
          03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
          03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
          33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
          33333337FFFF7733333333300000033333333337777773333333}
        NumGlyphs = 2
        ParentFont = False
        OnClick = SpeedButton3Click
      end
      object DBEditEh1: TDBEditEh
        Left = 271
        Top = 3
        Width = 347
        Height = 19
        AlwaysShowBorder = True
        EditButtons = <>
        Flat = True
        TabOrder = 0
        Visible = True
        OnChange = DBEditEh1Change
        OnClick = DBEditEh1Click
      end
    end
    object Panel5: TPanel
      Left = 2
      Top = 2
      Width = 839
      Height = 22
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 12615680
      TabOrder = 1
      object Label3: TLabel
        Left = 2
        Top = 2
        Width = 149
        Height = 18
        Align = alLeft
        Alignment = taCenter
        Caption = ' ?????? ???????????:'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object DBComboBoxEh1: TDBComboBoxEh
        Left = 168
        Top = 1
        Width = 129
        Height = 19
        Color = 12615680
        EditButtons = <>
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        Flat = True
        Items.Strings = (
          '??? ??????')
        ParentFont = False
        TabOrder = 0
        Visible = True
        OnChange = DBComboBoxEh1Change
      end
      object Panel7: TPanel
        Left = 813
        Top = 2
        Width = 24
        Height = 18
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object SpeedButton4: TSpeedButton
          Left = 1
          Top = 0
          Width = 23
          Height = 18
          Hint = '???????? ??? ???????'
          Flat = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333333333FF3333333333333C0C333333333333F777F3333333333CC0F0C3
            333333333777377F33333333C30F0F0C333333337F737377F333333C00FFF0F0
            C33333F7773337377F333CC0FFFFFF0F0C3337773F33337377F3C30F0FFFFFF0
            F0C37F7373F33337377F00FFF0FFFFFF0F0C7733373F333373770FFFFF0FFFFF
            F0F073F33373F333373730FFFFF0FFFFFF03373F33373F333F73330FFFFF0FFF
            00333373F33373FF77333330FFFFF000333333373F333777333333330FFF0333
            3333333373FF7333333333333000333333333333377733333333333333333333
            3333333333333333333333333333333333333333333333333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton4Click
        end
      end
    end
    object DBGridEh2: TDBGridEh
      Left = 2
      Top = 24
      Width = 839
      Height = 539
      Align = alClient
      DataSource = DBmod.DSKD_DTL
      Flat = True
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDragDrop = DBGridEh2DragDrop
      OnDragOver = DBGridEh2DragOver
      Columns = <
        item
          EditButtons = <>
          FieldName = 'GDS_DESCR'
          Footers = <>
          Title.Caption = '????????????'
          Width = 406
        end
        item
          EditButtons = <>
          FieldName = 'NUMBER'
          Footers = <>
          Title.Caption = '??????????'
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 166
    Height = 590
    Align = alLeft
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Panel4: TPanel
      Left = 2
      Top = 563
      Width = 162
      Height = 25
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object SpeedButton1: TSpeedButton
        Left = 2
        Top = 2
        Width = 159
        Height = 21
        Caption = '??????? ?????'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
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
        OnClick = SpeedButton1Click
      end
    end
    object DBGridEh1: TDBGridEh
      Left = 2
      Top = 24
      Width = 162
      Height = 539
      Align = alClient
      DataSource = DBmod.DSKD_GRP
      Flat = True
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = DBGridEh1CellClick
      OnDragDrop = DBGridEh1DragDrop
      OnDragOver = DBGridEh1DragOver
      OnKeyUp = DBGridEh1KeyUp
      OnMouseUp = DBGridEh1MouseUp
      OnTitleClick = DBGridEh1TitleClick
      Columns = <
        item
          EditButtons = <>
          FieldName = 'DESCRIPRION'
          Footers = <>
          Title.Caption = '?????'
          Width = 134
        end>
    end
    object Panel6: TPanel
      Left = 2
      Top = 2
      Width = 162
      Height = 22
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 12615680
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object Label4: TLabel
        Left = 619
        Top = 5
        Width = 93
        Height = 13
        Caption = '< ????? ??????'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 2
        Top = 2
        Width = 158
        Height = 16
        Hint = '????????? ??????????'
        Align = alTop
        Alignment = taCenter
        Caption = '???? ???????????'
        Color = 8454016
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Transparent = True
      end
    end
  end
end
