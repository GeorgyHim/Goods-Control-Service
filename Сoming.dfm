object FormComing: TFormComing
  Left = 0
  Top = 0
  Caption = #1055#1088#1080#1093#1086#1076
  ClientHeight = 265
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 23
    Width = 73
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object lRests: TLabel
    Left = 136
    Top = 56
    Width = 3
    Height = 13
  end
  object Label3: TLabel
    Left = 24
    Top = 78
    Width = 60
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
  end
  object Label2: TLabel
    Left = 53
    Top = 136
    Width = 26
    Height = 13
    Caption = #1044#1072#1090#1072
  end
  object eName: TEdit
    Left = 136
    Top = 20
    Width = 259
    Height = 21
    ReadOnly = True
    TabOrder = 0
    OnChange = eNameChange
  end
  object Button1: TButton
    Left = 371
    Top = 19
    Width = 24
    Height = 23
    Caption = '...'
    TabOrder = 1
    OnClick = Button1Click
  end
  object eQuantity: TEdit
    Tag = 5
    Left = 136
    Top = 75
    Width = 233
    Height = 21
    TabOrder = 2
    OnChange = eNameChange
  end
  object BtnOK: TBitBtn
    Left = 39
    Top = 192
    Width = 75
    Height = 25
    Enabled = False
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 3
    OnClick = BtnOKClick
  end
  object BtnCancel: TBitBtn
    Left = 294
    Top = 192
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
  end
  object DateTimePicker1: TDateTimePicker
    Left = 136
    Top = 136
    Width = 97
    Height = 21
    Date = 43987.000000000000000000
    Time = 0.606814155093161400
    TabOrder = 5
  end
end
