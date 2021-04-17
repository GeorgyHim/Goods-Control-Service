object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = #1043#1083#1072#1074#1085#1086#1077' '#1086#1082#1085#1086
  ClientHeight = 467
  ClientWidth = 766
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 766
    Height = 41
    Align = alTop
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 16
      Top = 0
      Width = 23
      Height = 35
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333FFFFFFFFFFFFFFF000000000000000077777777777777770FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07FFFFFFFFFFFFFF70CCCCCCCCCCCCCC07777777777777777088CCCCCCCCC
        C8807FF7777777777FF700000000000000007777777777777777333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = miNewFuturaClick
    end
    object SpeedButton2: TSpeedButton
      Left = 56
      Top = 0
      Width = 23
      Height = 35
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333CCCCC333333333337777733333333333CCCCC03
        33333333377777F3333333333CCCCC0333333333377777F3333333333CCCCC03
        33333333377777F333333CCCCCCCCCCCCC0337777777777777F33CCCCCCCCCCC
        CC0337777777777777F33CCCCCCCCCCCCC0337777777777777F33CCCCCCCCCCC
        CC0337777777777777F33CCCCCCCCCCCCC0337777777777777F333000CCCCC00
        000333FFF77777FFFFF333333CCCCC0333333333377777F3333333333CCCCC03
        33333333377777F3333333333CCCCC0333333333377777F33333333333000003
        3333333333FFFFF3333333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = miAddGoodClick
    end
  end
  object TabControl1: TTabControl
    Left = 0
    Top = 41
    Width = 766
    Height = 426
    Align = alClient
    TabOrder = 1
    Tabs.Strings = (
      #1047#1072#1082#1072#1079#1099
      #1044#1086#1089#1090#1072#1074#1082#1080
      #1055#1088#1080#1093#1086#1076#1099)
    TabIndex = 0
    OnChange = TabControl1Change
    object DBGrid1: TDBGrid
      Left = 4
      Top = 24
      Width = 758
      Height = 145
      Align = alTop
      DataSource = dsFutura
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object DBGrid2: TDBGrid
      Left = 4
      Top = 169
      Width = 758
      Height = 253
      Align = alClient
      DataSource = dsInfo
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object MainMenu1: TMainMenu
    Left = 256
    Top = 96
    object N1: TMenuItem
      Caption = #1044#1072#1085#1085#1099#1077
      object N2: TMenuItem
        Caption = #1050#1083#1080#1077#1085#1090#1099
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = #1058#1086#1074#1072#1088#1099
        OnClick = N3Click
      end
    end
    object N5: TMenuItem
      Caption = #1047#1072#1082#1072#1079
      object miNewFutura: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        OnClick = miNewFuturaClick
      end
      object miDelFutura: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        OnClick = miDelFuturaClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object miAddGood: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        OnClick = miAddGoodClick
      end
      object miDelGood: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        OnClick = miDelGoodClick
      end
    end
    object N7: TMenuItem
      Caption = #1055#1088#1080#1093#1086#1076
      object AddComing: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        OnClick = AddComingClick
      end
    end
    object N8: TMenuItem
      Caption = #1054#1090#1095#1077#1090#1099
      object available: TMenuItem
        Caption = #1044#1086#1083#1075#1080
        OnClick = availableClick
      end
      object Graphic: TMenuItem
        Caption = #1043#1088#1072#1092#1080#1082' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1079#1072#1082#1072#1079#1086#1074
        OnClick = GraphicClick
      end
    end
    object N4: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = N4Click
    end
  end
  object dsFutura: TDataSource
    OnDataChange = dsFuturaDataChange
    Left = 424
    Top = 113
  end
  object dsInfo: TDataSource
    Left = 424
    Top = 321
  end
end
