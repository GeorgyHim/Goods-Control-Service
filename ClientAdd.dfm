object FormClientAdd: TFormClientAdd
  Left = 0
  Top = 0
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1082#1083#1080#1077#1085#1090#1077
  ClientHeight = 312
  ClientWidth = 400
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
    Left = 18
    Top = 24
    Width = 359
    Height = 21
    EditLabel.Width = 77
    EditLabel.Height = 13
    EditLabel.Caption = #1048#1084#1103' / '#1053#1072#1079#1074#1072#1085#1080#1077
    MaxLength = 50
    TabOrder = 0
    OnChange = eNameChange
  end
  object eAddress: TLabeledEdit
    Left = 18
    Top = 96
    Width = 359
    Height = 21
    EditLabel.Width = 31
    EditLabel.Height = 13
    EditLabel.Caption = #1040#1076#1088#1077#1089
    MaxLength = 100
    TabOrder = 1
    OnChange = eNameChange
  end
  object eINN: TLabeledEdit
    Left = 18
    Top = 168
    Width = 359
    Height = 21
    EditLabel.Width = 21
    EditLabel.Height = 13
    EditLabel.Caption = #1048#1053#1053
    MaxLength = 12
    TabOrder = 2
    OnChange = eNameChange
  end
  object BitBtn1: TBitBtn
    Left = 42
    Top = 256
    Width = 75
    Height = 25
    Enabled = False
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 3
  end
  object BitBtn2: TBitBtn
    Left = 278
    Top = 256
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 4
  end
end
