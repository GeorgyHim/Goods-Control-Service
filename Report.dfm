object FormReport: TFormReport
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1077#1090' '#1085#1072' '#1076#1072#1090#1091
  ClientHeight = 373
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 249
    Height = 373
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 36
      Width = 26
      Height = 13
      Caption = #1044#1072#1090#1072
    end
    object DateTimePicker1: TDateTimePicker
      Left = 96
      Top = 36
      Width = 113
      Height = 21
      Date = 43987.000000000000000000
      Time = 0.354519733795314100
      TabOrder = 0
    end
    object Button1: TButton
      Left = 32
      Top = 321
      Width = 177
      Height = 25
      Caption = #1054#1090#1095#1077#1090
      TabOrder = 1
      OnClick = Button1Click
    end
    object CheckListBox1: TCheckListBox
      Left = 32
      Top = 88
      Width = 177
      Height = 185
      ItemHeight = 13
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 249
    Top = 0
    Width = 535
    Height = 373
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 533
      Height = 371
      Align = alClient
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object DataSource1: TDataSource
    Left = 448
    Top = 240
  end
end
