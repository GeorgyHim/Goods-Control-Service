object ProductSelect: TProductSelect
  Left = 0
  Top = 0
  Caption = #1042#1099#1087#1080#1089#1082#1072' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 297
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 23
    Width = 73
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object Label2: TLabel
    Left = 24
    Top = 86
    Width = 26
    Height = 13
    Caption = #1062#1077#1085#1072
  end
  object Label3: TLabel
    Left = 24
    Top = 134
    Width = 60
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
  end
  object Label4: TLabel
    Left = 24
    Top = 181
    Width = 31
    Height = 13
    Caption = #1057#1091#1084#1084#1072
  end
  object lRests: TLabel
    Left = 136
    Top = 56
    Width = 3
    Height = 13
  end
  object eName: TEdit
    Left = 136
    Top = 20
    Width = 259
    Height = 21
    ReadOnly = True
    TabOrder = 0
    Text = 'eName'
    OnChange = eNameChange
  end
  object ePrice: TEdit
    Tag = 2
    Left = 136
    Top = 83
    Width = 233
    Height = 21
    TabOrder = 1
    Text = 'ePrice'
    OnChange = ePriceChange
    OnKeyPress = ePriceKeyPress
  end
  object eQuantity: TEdit
    Tag = 5
    Left = 136
    Top = 131
    Width = 233
    Height = 21
    TabOrder = 2
    Text = 'eQuantity'
    OnChange = eQuantityChange
  end
  object eSum: TEdit
    Tag = 2
    Left = 136
    Top = 178
    Width = 233
    Height = 21
    TabOrder = 3
    Text = 'eSum'
    OnChange = eSumChange
  end
  object BtnOK: TBitBtn
    Left = 39
    Top = 247
    Width = 75
    Height = 25
    Enabled = False
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 4
    OnClick = BtnOKClick
  end
  object BtnCancel: TBitBtn
    Left = 294
    Top = 247
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 5
  end
  object Button1: TButton
    Left = 371
    Top = 19
    Width = 24
    Height = 23
    Caption = '...'
    TabOrder = 6
    OnClick = Button1Click
  end
end
