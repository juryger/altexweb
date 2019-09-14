object ImageEditorForm: TImageEditorForm
  Left = 256
  Top = 271
  BorderStyle = bsDialog
  Caption = #208#229#228#224#234#242#238#240' '#232#231#238#225#240#224#230#229#237#232#233
  ClientHeight = 506
  ClientWidth = 833
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
    Left = 8
    Top = 8
    Width = 125
    Height = 26
    Caption = #207#240#238#241#236#238#242#240' '#232#241#245#238#228#237#238#227#238' '#232#231#238#225#240#224#230#229#237#232#255
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 424
    Top = 8
    Width = 153
    Height = 39
    Caption = #207#240#238#241#236#238#242#240' '#232#231#236#229#237#229#237#237#238#227#238' '#232#231#238#225#240#224#230#229#237#232#255
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label3: TLabel
    Left = 32
    Top = 488
    Width = 12
    Height = 14
    Caption = '30'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label4: TLabel
    Left = 104
    Top = 488
    Width = 27
    Height = 14
    Caption = '100%'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object SpeedButton1: TSpeedButton
    Left = 128
    Top = 456
    Width = 23
    Height = 22
    Enabled = False
    Flat = True
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
    Visible = False
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 0
    Top = 459
    Width = 23
    Height = 22
    Enabled = False
    Flat = True
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33033333333333333F7F3333333333333000333333333333F777333333333333
      000333333333333F777333333333333000333333333333F77733333333333300
      033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
      333333773337777333333078F8F87033333337F3333337F33333778F8F8F8773
      333337333333373F333307F8F8F8F70333337F33FFFFF37F3333078999998703
      33337F377777337F333307F8F8F8F703333373F3333333733333778F8F8F8773
      333337F3333337F333333078F8F870333333373FF333F7333333330777770333
      333333773FF77333333333370007333333333333777333333333}
    NumGlyphs = 2
    Visible = False
    OnClick = SpeedButton2Click
  end
  object panelSrc: TPanel
    Left = 8
    Top = 48
    Width = 401
    Height = 401
    TabOrder = 0
    object imageSrc: TImage
      Left = 0
      Top = 0
      Width = 400
      Height = 400
      Cursor = crCross
      Center = True
      Stretch = True
      OnMouseDown = imageSrcMouseDown
      OnMouseMove = imageSrcMouseMove
      OnMouseUp = imageSrcMouseUp
    end
  end
  object panelDst: TPanel
    Left = 421
    Top = 48
    Width = 401
    Height = 401
    TabOrder = 1
    object imageDst: TImage
      Left = 0
      Top = 0
      Width = 32
      Height = 32
      Center = True
      Stretch = True
    end
  end
  object BitBtn1: TBitBtn
    Left = 296
    Top = 465
    Width = 97
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 424
    Top = 465
    Width = 97
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
  object trackBarZoomer: TTrackBar
    Left = 24
    Top = 457
    Width = 105
    Height = 33
    Enabled = False
    Max = 100
    Min = 30
    PageSize = 10
    Frequency = 10
    Position = 100
    TabOrder = 4
    Visible = False
    OnChange = trackBarZoomerChange
  end
end
