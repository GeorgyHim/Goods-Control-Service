object FormGoodsAdd: TFormGoodsAdd
  Left = 0
  Top = 0
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1090#1086#1074#1072#1088#1077
  ClientHeight = 435
  ClientWidth = 398
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object eName: TLabeledEdit
    Left = 24
    Top = 32
    Width = 347
    Height = 21
    EditLabel.Width = 73
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
    MaxLength = 50
    TabOrder = 0
    OnChange = eNameChange
  end
  object eMeasure: TLabeledEdit
    Left = 24
    Top = 112
    Width = 347
    Height = 21
    EditLabel.Width = 101
    EditLabel.Height = 13
    EditLabel.Caption = #1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
    MaxLength = 10
    TabOrder = 1
    OnChange = eNameChange
  end
  object eVAT: TLabeledEdit
    Left = 24
    Top = 192
    Width = 347
    Height = 21
    EditLabel.Width = 22
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1044#1057
    TabOrder = 2
    OnChange = eNameChange
  end
  object BitBtn1: TBitBtn
    Left = 40
    Top = 360
    Width = 75
    Height = 25
    Enabled = False
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 3
  end
  object BitBtn2: TBitBtn
    Left = 280
    Top = 360
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
  end
  object eQNT: TLabeledEdit
    Left = 24
    Top = 272
    Width = 347
    Height = 21
    EditLabel.Width = 43
    EditLabel.Height = 13
    EditLabel.Caption = #1054#1089#1090#1072#1090#1082#1080
    TabOrder = 5
    Text = '0'
    OnChange = eNameChange
  end
end
