object NaklForm: TNaklForm
  Left = 272
  Top = 206
  Width = 1024
  Height = 540
  Caption = #1053#1072#1082#1083#1072#1076#1085#1099#1077
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
    Left = 0
    Top = 209
    Width = 1008
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1008
    Height = 209
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 22
      Width = 1008
      Height = 164
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object DBGridEh1: TDBGridEh
        Left = 2
        Top = 2
        Width = 1004
        Height = 160
        Align = alClient
        AllowedOperations = [alopInsertEh, alopUpdateEh, alopAppendEh]
        DataSource = DBmod.DCST
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        FrozenCols = 1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnCellClick = DBGridEh1CellClick
        OnKeyUp = DBGridEh1KeyUp
        OnMouseUp = DBGridEh1MouseUp
        Columns = <
          item
            EditButtons = <>
            FieldName = 'Company'
            Footers = <>
            Title.Caption = #1050#1083#1080#1077#1085#1090
            Width = 164
          end
          item
            EditButtons = <>
            FieldName = 'ProfitPercentage'
            Footers = <>
            Title.Caption = #1053#1072#1082#1088#1091#1090#1082#1072' (%)'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clGreen
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = [fsBold]
            Width = 81
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'Address'
            Footers = <>
            Title.Caption = #1040#1076#1088#1077#1089
            Width = 203
          end
          item
            EditButtons = <>
            FieldName = 'INN'
            Footers = <>
            Title.Caption = #1048#1053#1053
            Width = 109
          end
          item
            EditButtons = <>
            FieldName = 'Phone'
            Footers = <>
            Title.Caption = #1058#1077#1083#1077#1092#1086#1085
            Width = 250
          end
          item
            EditButtons = <>
            FieldName = 'Email'
            Footers = <>
            Width = 135
          end
          item
            EditButtons = <>
            FieldName = 'ContactName'
            Footers = <>
            Title.Caption = #1050#1086#1085#1090#1072#1082#1090#1085#1086#1077' '#1083#1080#1094#1086
            Width = 145
          end>
      end
    end
    object clientsManagementPanel: TPanel
      Left = 0
      Top = 0
      Width = 1008
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object applyCustomerChangesButton: TSpeedButton
        Left = 96
        Top = 1
        Width = 95
        Height = 21
        Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1087#1088#1072#1074#1082#1080
        Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
        Enabled = False
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
          3333333333FFFFF3333333333000003333333333F777773FF333333008877700
          33333337733FFF773F33330887000777033333733F777FFF73F330880FAFAF07
          703337F37733377FF7F33080F00000F07033373733777337F73F087F00A2200F
          77037F3737333737FF7F080A0A2A220A07037F737F3333737F7F0F0F0AAAA20F
          07037F737F3333737F7F0F0A0FAA2A0A08037F737FF33373737F0F7F00FFA00F
          780373F737FFF737F3733080F00000F0803337F73377733737F330F80FAFAF08
          8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
          3333333773FFFF77333333333000003333333333377777333333}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = applyCustomerChangesButtonClick
      end
      object deleteCustomerButton: TSpeedButton
        Left = 191
        Top = 1
        Width = 95
        Height = 21
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1082#1083#1080#1077#1085#1090#1072
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
        OnClick = deleteCustomerButtonClick
      end
      object importWebOrderButton: TSpeedButton
        Left = 287
        Top = 1
        Width = 160
        Height = 21
        Caption = #1048#1084#1087#1086#1088#1090' '#1074#1077#1073'-'#1079#1072#1082#1072#1079#1086#1074
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
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
        OnClick = importWebOrderButtonClick
      end
      object addCustomerButton: TSpeedButton
        Left = 1
        Top = 1
        Width = 95
        Height = 21
        Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1086#1075#1086' '#1082#1083#1080#1077#1085#1090#1072
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
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
        OnClick = addCustomerButtonClick
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 186
      Width = 1008
      Height = 23
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 2
      object Label7: TLabel
        Left = 66
        Top = 6
        Width = 71
        Height = 13
        Caption = #1087#1086' '#1050#1083#1080#1077#1085#1090#1091':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Label4: TLabel
        Left = 3
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
      object Label8: TLabel
        Left = 313
        Top = 6
        Width = 194
        Height = 13
        Caption = '('#1087#1086' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1102' '#1074#1074#1086#1076#1072' '#1085#1072#1078#1084#1080#1090#1077' Enter)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object DBEditEh1: TDBEditEh
        Left = 142
        Top = 2
        Width = 163
        Height = 19
        Alignment = taLeftJustify
        AlwaysShowBorder = True
        EditButtons = <>
        Flat = True
        TabOrder = 0
        Visible = True
        OnChange = DBEditEh1Change
        OnClick = DBEditEh1Click
        OnKeyPress = DBEditEh1KeyPress
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 476
    Width = 1008
    Height = 25
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label1: TLabel
      Left = 3
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
    object Label5: TLabel
      Left = 63
      Top = 6
      Width = 51
      Height = 13
      Caption = #1087#1086' '#1050#1086#1076#1091':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object DBEditEh2: TDBEditEh
      Left = 115
      Top = 2
      Width = 89
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
  object Panel5: TPanel
    Left = 0
    Top = 212
    Width = 1008
    Height = 264
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object DBGridEh3: TDBGridEh
      Left = 2
      Top = 52
      Width = 1004
      Height = 210
      Align = alClient
      AllowedOperations = [alopUpdateEh]
      DataSource = DBmod.DSLS_DTL
      Flat = True
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      FrozenCols = 1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDragDrop = DBGridEh3DragDrop
      OnDragOver = DBGridEh3DragOver
      Columns = <
        item
          Color = 8454143
          EditButtons = <>
          FieldName = 'ID_GDS_DTL'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1050#1086#1076
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clPurple
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
        end
        item
          Color = 16245198
          EditButtons = <>
          FieldName = 'Title'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clPurple
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 308
        end
        item
          EditButtons = <>
          FieldName = 'GDS_COST_NDS'
          Footers = <>
          Title.Caption = #1062#1077#1085#1072' '#1089' '#1053#1044#1057
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clPurple
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 77
        end
        item
          EditButtons = <>
          FieldName = 'GDS_NUMB'
          Footers = <>
          Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clPurple
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 75
        end
        item
          Color = 16245198
          EditButtons = <>
          FieldName = 'Comment'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1081' '#1082' '#1079#1072#1082#1072#1079#1091
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clPurple
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 405
        end
        item
          Color = 16245198
          EditButtons = <>
          FieldName = 'GDS_COST_CLR'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1062#1077#1085#1072' '#1073#1077#1079' '#1053#1044#1057
          Title.Font.Charset = RUSSIAN_CHARSET
          Title.Font.Color = clGray
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 84
        end>
    end
    object Panel6: TPanel
      Left = 2
      Top = 27
      Width = 1004
      Height = 25
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 1
      object exportExcelButton: TSpeedButton
        Left = 287
        Top = 2
        Width = 95
        Height = 21
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
        OnClick = exportExcelButtonClick
      end
      object previewButton: TSpeedButton
        Left = 191
        Top = 2
        Width = 95
        Height = 21
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
        OnClick = previewButtonClick
      end
      object printButton: TSpeedButton
        Left = 96
        Top = 2
        Width = 95
        Height = 21
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
        OnClick = printButtonClick
      end
      object deleteGoodsItemButton: TSpeedButton
        Left = 1
        Top = 2
        Width = 95
        Height = 21
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1090#1086#1074#1072#1088' '#1080#1079' '#1079#1072#1082#1072#1079#1072
        Caption = #1059#1076#1072#1083#1080#1090#1100
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
          333333333333333333FF33333333333330003333333333333777333333333333
          300033FFFFFF3333377739999993333333333777777F3333333F399999933333
          3300377777733333337733333333333333003333333333333377333333333333
          3333333333333333333F333333333333330033333F33333333773333C3333333
          330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
          333333377F33333333FF3333C333333330003333733333333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = deleteGoodsItemButtonClick
      end
    end
    object invoiceManagementPanel: TPanel
      Left = 2
      Top = 2
      Width = 1004
      Height = 25
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 2
      object newOrderButton: TSpeedButton
        Left = 152
        Top = 2
        Width = 20
        Height = 21
        Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1099#1081' '#1079#1072#1082#1072#1079
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clGreen
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
          333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
          0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
          0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
          33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
          B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
          3BB33773333773333773B333333B3333333B7333333733333337}
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = newOrderButtonClick
      end
      object deleteOrderButton: TSpeedButton
        Left = 173
        Top = 2
        Width = 20
        Height = 21
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1099#1081' '#1079#1072#1082#1072#1079
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
        ParentShowHint = False
        ShowHint = True
        OnClick = deleteOrderButtonClick
      end
      object Label3: TLabel
        Left = 3
        Top = 5
        Width = 59
        Height = 13
        Caption = #8470' '#1079#1072#1082#1072#1079#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 204
        Top = 5
        Width = 26
        Height = 13
        Caption = '/ '#1054#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 370
        Top = 5
        Width = 76
        Height = 13
        Caption = '/ Web-'#1079#1072#1082#1072#1079
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object orderNoComboBox: TDBLookupComboboxEh
        Left = 69
        Top = 2
        Width = 81
        Height = 21
        EditButtons = <>
        KeyField = 'ID_SAL_GRP'
        ListField = 'OrderNo'
        ListSource = DBmod.DSLS_GRP
        TabOrder = 0
        Visible = True
        OnKeyValueChanged = orderNoComboBoxKeyValueChanged
      end
      object saleDateTextBox: TEdit
        Left = 238
        Top = 1
        Width = 121
        Height = 21
        Color = 16245198
        ReadOnly = True
        TabOrder = 1
      end
      object webOrderNoTextBox: TEdit
        Left = 451
        Top = 1
        Width = 121
        Height = 21
        Color = 16245198
        ReadOnly = True
        TabOrder = 2
      end
    end
  end
  object importOrdersDialog: TOpenDialog
    DefaultExt = 'xml'
    Filter = 'Xml Files|*.xml'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 696
    Top = 46
  end
end
