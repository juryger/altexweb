object StoreForm: TStoreForm
  Left = 422
  Top = 236
  Width = 753
  Height = 539
  Caption = 'Skad'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 185
    Top = 0
    Height = 500
  end
  object leftPanel: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 500
    Align = alLeft
    TabOrder = 0
    object Splitter2: TSplitter
      Left = 1
      Top = 185
      Width = 183
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object subgroupGrid: TDBGridEh
      Left = 1
      Top = 188
      Width = 183
      Height = 311
      Align = alClient
      DataSource = DBmod.DGDS_SGRP
      Flat = True
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = subgroupGridCellClick
      Columns = <
        item
          EditButtons = <>
          FieldName = 'DESCRIPTION'
          Footers = <>
          Title.Caption = 'Podgruppa'
        end>
    end
    object groupGrid: TDBGridEh
      Left = 1
      Top = 1
      Width = 183
      Height = 184
      Align = alTop
      DataSource = DBmod.DGDS_GRP
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
      OnCellClick = groupGridCellClick
      Columns = <
        item
          EditButtons = <>
          FieldName = 'DESCRIPTION'
          Footers = <>
          Title.Caption = 'Gruppa'
        end>
    end
  end
  object rightPanel: TPanel
    Left = 188
    Top = 0
    Width = 549
    Height = 500
    Align = alClient
    TabOrder = 1
    object controlPanel: TPanel
      Left = 1
      Top = 475
      Width = 547
      Height = 24
      Align = alBottom
      TabOrder = 0
      object SpeedButton1: TSpeedButton
        Left = 0
        Top = 0
        Width = 137
        Height = 23
        Caption = 'Pechat'#39
        Flat = True
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
      end
      object Label2: TLabel
        Left = 206
        Top = 6
        Width = 52
        Height = 13
        Caption = 'po Kodu:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Label3: TLabel
        Left = 327
        Top = 6
        Width = 103
        Height = 13
        Caption = 'po Naimenovaniu:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Label1: TLabel
        Left = 146
        Top = 6
        Width = 50
        Height = 13
        Caption = 'Poisk >>'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object DBEditEh2: TDBEditEh
        Left = 259
        Top = 3
        Width = 50
        Height = 19
        Alignment = taLeftJustify
        AlwaysShowBorder = True
        EditButtons = <>
        Flat = True
        TabOrder = 0
        Visible = True
        OnChange = DBEditEh2Change
        OnClick = DBEditEh2Click
      end
      object DBEditEh1: TDBEditEh
        Left = 435
        Top = 3
        Width = 161
        Height = 19
        Alignment = taLeftJustify
        AlwaysShowBorder = True
        EditButtons = <>
        Flat = True
        TabOrder = 1
        Visible = True
        OnChange = DBEditEh1Change
        OnClick = DBEditEh1Click
      end
    end
    object goodsGrid: TDBGridEh
      Left = 1
      Top = 1
      Width = 547
      Height = 474
      Align = alClient
      DataSource = DBmod.DSTR
      Flat = True
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      FrozenCols = 1
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          EditButtons = <>
          FieldName = 'ID_GDS_DTL'
          Footers = <>
          Title.Caption = 'Kod'
        end
        item
          EditButtons = <>
          FieldName = 'DESCRIPTION'
          Footers = <>
          Title.Caption = 'Naimenovanie'
        end
        item
          EditButtons = <>
          FieldName = 'NUM'
          Footers = <>
          Title.Caption = 'Kol-vo'
        end>
    end
  end
end
