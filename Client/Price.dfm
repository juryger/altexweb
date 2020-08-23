object PriceForm: TPriceForm
  Left = 427
  Top = 185
  Width = 1024
  Height = 709
  Caption = #1055#1088#1072#1081#1089
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
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter2: TSplitter
    Left = 0
    Top = 374
    Width = 1008
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object goodsCategoriesPanel: TPanel
    Left = 0
    Top = 24
    Width = 1008
    Height = 350
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 313
      Top = 2
      Height = 346
    end
    object groupsMainPanel: TPanel
      Left = 2
      Top = 2
      Width = 311
      Height = 346
      Align = alLeft
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object gControlsPanel: TPanel
        Left = 2
        Top = 2
        Width = 307
        Height = 24
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object addGroupButton: TSpeedButton
          Left = 1
          Top = 2
          Width = 95
          Height = 21
          Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091
          Caption = #1057#1086#1079#1076#1072#1090#1100
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
          OnClick = addGroupButtonClick
        end
        object deleteGroupButton: TSpeedButton
          Left = 95
          Top = 2
          Width = 95
          Height = 21
          Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1091#1102' '#1075#1088#1091#1087#1087#1091
          Caption = #1059#1076#1072#1083#1080#1090#1100
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
          OnClick = deleteGroupButtonClick
        end
      end
      object DBGridEh2: TDBGridEh
        Left = 2
        Top = 26
        Width = 307
        Height = 318
        Align = alClient
        AllowedOperations = [alopUpdateEh]
        DataSource = DBmod.DGDS_GRP
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnCellClick = DBGridEh2CellClick
        OnKeyUp = DBGridEh2KeyUp
        Columns = <
          item
            EditButtons = <>
            FieldName = 'DESCRIPTION'
            Footers = <>
            Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1075#1088#1091#1087#1087#1099
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clBlue
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 215
          end>
      end
    end
    object subgroupsMainPanel: TPanel
      Left = 316
      Top = 2
      Width = 340
      Height = 346
      Align = alLeft
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 1
      object sgControlsPanel: TPanel
        Left = 2
        Top = 2
        Width = 336
        Height = 24
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object addSubgroupButton: TSpeedButton
          Left = 1
          Top = 2
          Width = 95
          Height = 21
          Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1087#1086#1076#1075#1088#1091#1087#1087#1091
          Caption = #1057#1086#1079#1076#1072#1090#1100
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
          OnClick = addSubgroupButtonClick
        end
        object deleteSubgroupButton: TSpeedButton
          Left = 95
          Top = 2
          Width = 95
          Height = 21
          Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1091#1102' '#1087#1086#1076#1075#1088#1091#1087#1087#1091
          Caption = #1059#1076#1072#1083#1080#1090#1100
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
          OnClick = deleteSubgroupButtonClick
        end
      end
      object DBGridEh3: TDBGridEh
        Left = 2
        Top = 26
        Width = 336
        Height = 318
        Align = alClient
        AllowedOperations = [alopUpdateEh]
        DataSource = DBmod.DGDS_SGRP
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnCellClick = DBGridEh3CellClick
        OnDragDrop = DBGridEh3DragDrop
        OnDragOver = DBGridEh3DragOver
        OnKeyUp = DBGridEh3KeyUp
        Columns = <
          item
            EditButtons = <>
            FieldName = 'DESCRIPTION'
            Footers = <>
            Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1086#1076#1075#1088#1091#1087#1087#1099
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clBlue
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 210
          end>
      end
    end
  end
  object goodsMainPanel: TPanel
    Left = 0
    Top = 377
    Width = 1008
    Height = 293
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object DBGridEh1: TDBGridEh
      Left = 2
      Top = 50
      Width = 1004
      Height = 241
      Align = alClient
      AllowedOperations = [alopUpdateEh]
      DataSource = DBmod.DGDS_DTL
      Flat = True
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      FrozenCols = 3
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking]
      SortLocal = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = DBGridEh1DrawColumnCell
      OnKeyUp = DBGridEh1KeyUp
      OnMouseDown = DBGridEh1MouseDown
      OnSortMarkingChanged = DBGridEh1SortMarkingChanged
      Columns = <
        item
          Alignment = taCenter
          ButtonStyle = cbsEllipsis
          Checkboxes = False
          EditButtons = <>
          FieldName = 'ImageType'
          Footers = <>
          ImageList = MainForm.ImageList1
          KeyList.Strings = (
            '0')
          PopupMenu = picturePopupMenu
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = ' '
          Title.Font.Charset = RUSSIAN_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Courier New'
          Title.Font.Style = [fsBold]
          Width = 20
        end
        item
          EditButtons = <>
          FieldName = 'Web'
          Footers = <>
          ImageList = MainForm.ImageList1
          KeyList.Strings = (
            '0'
            '1')
          ReadOnly = True
          Title.Caption = ' '
          Width = 20
        end
        item
          Alignment = taLeftJustify
          Color = 8454143
          EditButtons = <>
          FieldName = 'ID_GDS_DTL'
          Footers = <>
          PopupMenu = subGroupsPopupMenu
          Title.Caption = #1050#1086#1076
          Title.TitleButton = True
        end
        item
          EditButtons = <>
          FieldName = 'DESCRIPTION'
          Footers = <>
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1086#1080#1079#1094#1080#1080
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlack
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Title.TitleButton = True
          Width = 308
        end
        item
          AlwaysShowEditButton = True
          EditButtons = <>
          FieldName = 'UnitMeasuring'
          Footers = <>
          Title.Caption = #1045#1076'. '#1080#1079#1084'.'
          Width = 49
        end
        item
          EditButtons = <>
          FieldName = 'PACK_NUM'
          Footers = <>
          Title.Caption = #1059#1087#1072#1082'.'
          Width = 57
        end
        item
          EditButtons = <>
          FieldName = 'MIN_PACK'
          Footers = <>
          Title.Caption = #1052#1080#1085'. '#1091#1087#1072#1082'.'
        end
        item
          EditButtons = <>
          FieldName = 'COST_PURCH'
          Footers = <>
          Title.Caption = #1062#1077#1085#1072' '#1079#1072#1082#1091#1087#1082#1080
          Width = 87
        end
        item
          Color = 16245198
          EditButtons = <>
          FieldName = 'COST_WHS1'
          Footers = <>
          Title.Caption = #1054#1087#1090' 1'
        end
        item
          Color = 16245198
          EditButtons = <>
          FieldName = 'COST_WHS2'
          Footers = <>
          Title.Caption = #1054#1087#1090' 2'
        end
        item
          Color = 16245198
          EditButtons = <>
          FieldName = 'COST_WHS3'
          Footers = <>
          Title.Caption = #1054#1087#1090' 3'
        end
        item
          AlwaysShowEditButton = True
          Color = clMoneyGreen
          EditButtons = <>
          FieldName = 'GroupName'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1075#1088#1091#1087#1087#1099
        end
        item
          AutoDropDown = True
          Color = clMoneyGreen
          EditButtons = <>
          FieldName = 'SubgroupName'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1053#1079#1072#1074#1072#1085#1080#1077' '#1087#1086#1076#1075#1088#1091#1087#1087#1099
        end>
    end
    object goodsControlsPanel: TPanel
      Left = 2
      Top = 2
      Width = 1004
      Height = 23
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 1
      object addGoodsButton: TSpeedButton
        Left = 0
        Top = 1
        Width = 95
        Height = 21
        Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091' '#1087#1086#1079#1080#1094#1080#1102' '#1090#1086#1074#1072#1088#1072
        Caption = #1057#1086#1079#1076#1072#1090#1100
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
        OnClick = addGoodsButtonClick
      end
      object deleteGoodsButton: TSpeedButton
        Left = 94
        Top = 1
        Width = 95
        Height = 21
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1091#1102' '#1087#1086#1079#1080#1094#1080#1102
        Caption = #1059#1076#1072#1083#1080#1090#1100
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
        OnClick = deleteGoodsButtonClick
      end
      object deleteBadBlob: TSpeedButton
        Left = 282
        Top = 1
        Width = 95
        Height = 21
        Hint = 
          #1048#1089#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1086#1096#1080#1073#1082#1080' '#1089#1074#1103#1079#1072#1085#1085#1086#1081' '#1089' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1080#1077#1084' '#1075#1088#1072#1092#1080#1095#1077#1089#1082#1086#1075#1086' '#1080#1079#1086#1073#1088#1072#1078 +
          #1077#1085#1080#1103
        Caption = 'BLOB'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
          3333333777333777FF33339993707399933333773337F3777FF3399933000339
          9933377333777F3377F3399333707333993337733337333337FF993333333333
          399377F33333F333377F993333303333399377F33337FF333373993333707333
          333377F333777F333333993333101333333377F333777F3FFFFF993333000399
          999377FF33777F77777F3993330003399993373FF3777F37777F399933000333
          99933773FF777F3F777F339993707399999333773F373F77777F333999999999
          3393333777333777337333333999993333333333377777333333}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = deleteBadBlobClick
      end
      object discountsButton: TSpeedButton
        Left = 188
        Top = 1
        Width = 95
        Height = 21
        Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1072#1073#1083#1080#1094#1091' '#1089#1082#1080#1076#1086#1082
        Caption = #1057#1082#1080#1076#1082#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333333333333333333FFFFFFFFFFF33330000000000
          03333377777777777F33333003333330033333377FF333377F33333300333333
          0333333377FF33337F3333333003333303333333377FF3337333333333003333
          333333333377FF3333333333333003333333333333377FF33333333333330033
          3333333333337733333333333330033333333333333773333333333333003333
          33333333337733333F3333333003333303333333377333337F33333300333333
          03333333773333337F33333003333330033333377FFFFFF77F33330000000000
          0333337777777777733333333333333333333333333333333333}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = discountsButtonClick
      end
    end
    object searchPanel: TPanel
      Left = 2
      Top = 25
      Width = 1004
      Height = 25
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 2
      object Label2: TLabel
        Left = 90
        Top = 6
        Width = 27
        Height = 13
        Caption = #1050#1086#1076':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Label3: TLabel
        Left = 232
        Top = 6
        Width = 63
        Height = 13
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Label1: TLabel
        Left = 5
        Top = 6
        Width = 56
        Height = 13
        Caption = #1055#1086#1080#1089#1082' >>'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object resetSearchButton: TSpeedButton
        Left = 501
        Top = 2
        Width = 21
        Height = 21
        Hint = #1057#1073#1088#1086#1089#1080#1090#1100' '#1087#1086#1080#1089#1082
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
          555557777F777555F55500000000555055557777777755F75555005500055055
          555577F5777F57555555005550055555555577FF577F5FF55555500550050055
          5555577FF77577FF555555005050110555555577F757777FF555555505099910
          555555FF75777777FF555005550999910555577F5F77777775F5500505509990
          3055577F75F77777575F55005055090B030555775755777575755555555550B0
          B03055555F555757575755550555550B0B335555755555757555555555555550
          BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
          50BB555555555555575F555555555555550B5555555555555575}
        NumGlyphs = 2
        OnClick = resetSearchButtonClick
      end
      object DBEditEh1: TDBEditEh
        Left = 298
        Top = 2
        Width = 201
        Height = 19
        Alignment = taLeftJustify
        AlwaysShowBorder = True
        EditButtons = <>
        Flat = True
        TabOrder = 1
        Visible = True
        OnChange = DBEditEh1Change
        OnClick = DBEditEh1Click
        OnKeyPress = DBEditEh1KeyPress
      end
      object DBEditEh2: TDBEditEh
        Left = 118
        Top = 2
        Width = 99
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
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1008
    Height = 24
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object uploadWebButton: TSpeedButton
      Left = 0
      Top = 2
      Width = 95
      Height = 21
      Hint = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1089' '#1074#1077#1073'-'#1089#1072#1081#1090#1086#1084' altexweb.ru'
      Caption = #1042#1077#1073'-'#1089#1072#1081#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555FFFFF555555555544C4C5555555555F777775FF5555554C444C444
        5555555775FF55775F55554C4334444445555575577F55557FF554C4C334C4C4
        335557F5577FF55577F554CCC3334444335557555777F555775FCCCCC333CCC4
        C4457F55F777F555557F4CC33333CCC444C57F577777F5F5557FC4333333C3C4
        CCC57F777777F7FF557F4CC33333333C4C457F577777777F557FCCC33CC4333C
        C4C575F7755F777FF5755CCCCC3333334C5557F5FF777777F7F554C333333333
        CC55575777777777F755553333CC3C33C555557777557577755555533CC4C4CC
        5555555775FFFF77555555555C4CCC5555555555577777555555}
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = uploadWebButtonClick
    end
    object printButton: TSpeedButton
      Left = 94
      Top = 2
      Width = 95
      Height = 21
      Hint = #1055#1077#1095#1072#1090#1100' '#1087#1088#1072#1081#1089'-'#1083#1080#1089#1090#1072
      Caption = #1055#1077#1095#1072#1090#1100
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
      ParentShowHint = False
      ShowHint = True
      OnClick = printButtonClick
    end
    object previewButton: TSpeedButton
      Left = 188
      Top = 2
      Width = 95
      Height = 21
      Hint = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1087#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1072#1081#1089'-'#1083#1080#1089#1090#1072
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
        3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
        33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
        333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = previewButtonClick
    end
    object exportButton: TSpeedButton
      Left = 282
      Top = 2
      Width = 95
      Height = 21
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1087#1088#1072#1081#1089'-'#1083#1080#1089#1090#1072' '#1074' '#1092#1086#1088#1084#1072#1090#1077' Excel'
      Caption = 'Excel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
        333333333333337FF3333333333333903333333333333377FF33333333333399
        03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
        99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
        99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
        03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
        33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
        33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
        3333777777333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = exportButtonClick
    end
  end
  object picturePopupMenu: TPopupMenu
    OnPopup = picturePopupMenuPopup
    Left = 257
    Top = 96
    object popupItemViewPicture: TMenuItem
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103' (F3)'
      OnClick = popupItemViewPictureClick
    end
    object popupItemSetPicture: TMenuItem
      Caption = #1047#1072#1076#1072#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' (F3)'
      OnClick = popupItemSetPictureClick
    end
    object popupItemClearPicture: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' (F8)'
      OnClick = popupItemClearPictureClick
    end
    object N1: TMenuItem
      Caption = '-'
      GroupIndex = 1
    end
    object popupItemStore: TMenuItem
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1089#1082#1083#1072#1076' (F10)'
      GroupIndex = 1
      OnClick = popupItemStoreClick
    end
  end
  object openGoodPictureDialog: TOpenPictureDialog
    Options = [ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Left = 289
    Top = 96
  end
  object subGroupsPopupMenu: TPopupMenu
    Left = 257
    Top = 132
  end
end
