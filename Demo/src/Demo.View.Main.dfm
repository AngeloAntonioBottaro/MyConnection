object DemoViewMain: TDemoViewMain
  Left = 0
  Top = 0
  Caption = 'MyConnection Demo'
  ClientHeight = 423
  ClientWidth = 789
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 387
    Width = 783
    Height = 33
    Align = alBottom
    Padding.Left = 2
    Padding.Top = 1
    Padding.Right = 1
    Padding.Bottom = 2
    TabOrder = 0
    ExplicitTop = 263
    ExplicitWidth = 629
    object Button1: TButton
      Left = 581
      Top = 2
      Width = 100
      Height = 28
      Align = alRight
      Caption = 'Configuration'
      TabOrder = 0
      OnClick = Button1Click
      ExplicitLeft = 327
    end
    object Button2: TButton
      Left = 3
      Top = 2
      Width = 100
      Height = 28
      Align = alLeft
      Caption = 'Segundo Form'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button4: TButton
      Left = 681
      Top = 2
      Width = 100
      Height = 28
      Align = alRight
      Caption = 'Query'
      TabOrder = 2
      OnClick = Button4Click
      ExplicitLeft = 427
    end
  end
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 783
    Height = 378
    Align = alClient
    DataSource = DS
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DS: TDataSource
    Left = 280
    Top = 112
  end
end
