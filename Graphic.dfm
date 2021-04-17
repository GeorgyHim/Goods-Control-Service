object FormGraphic: TFormGraphic
  Left = 0
  Top = 0
  Caption = #1043#1088#1072#1092#1080#1082' '#1087#1088#1086#1076#1072#1078' '#1080' '#1076#1086#1083#1075#1086#1074
  ClientHeight = 470
  ClientWidth = 781
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 243
    Top = 0
    Width = 538
    Height = 470
    Align = alClient
    ExplicitLeft = 249
    ExplicitTop = 8
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 243
    Height = 470
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 48
      Width = 83
      Height = 21
      Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072
    end
    object Label2: TLabel
      Left = 24
      Top = 104
      Width = 77
      Height = 13
      Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072
    end
    object DateTimePicker1: TDateTimePicker
      Left = 113
      Top = 48
      Width = 112
      Height = 21
      Date = 43988.000000000000000000
      Time = 0.085510347220406400
      TabOrder = 0
    end
    object DateTimePicker2: TDateTimePicker
      Left = 113
      Top = 104
      Width = 112
      Height = 21
      Date = 43990.000000000000000000
      Time = 0.085510347220406400
      TabOrder = 1
    end
    object Button1: TButton
      Left = 16
      Top = 408
      Width = 209
      Height = 25
      Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1075#1088#1072#1092#1080#1082
      TabOrder = 2
      OnClick = Button1Click
    end
    object CheckListBox1: TCheckListBox
      Left = 16
      Top = 160
      Width = 209
      Height = 209
      ItemHeight = 13
      TabOrder = 3
    end
  end
end
