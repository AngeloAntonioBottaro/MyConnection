object DemoViewOtherForm: TDemoViewOtherForm
  Left = 0
  Top = 0
  Caption = 'DemoViewOtherForm'
  ClientHeight = 299
  ClientWidth = 635
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
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 629
    Height = 254
    Align = alClient
    DataSource = DS2
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 263
    Width = 629
    Height = 33
    Align = alBottom
    Padding.Left = 2
    Padding.Top = 1
    Padding.Right = 1
    Padding.Bottom = 2
    TabOrder = 1
    object Button4: TButton
      Left = 527
      Top = 2
      Width = 100
      Height = 28
      Align = alRight
      Caption = 'Query'
      TabOrder = 0
      OnClick = Button4Click
    end
    object Button1: TButton
      Left = 427
      Top = 2
      Width = 100
      Height = 28
      Align = alRight
      Caption = 'Query 2'
      TabOrder = 1
      OnClick = Button1Click
      ExplicitLeft = 527
    end
  end
  object DS2: TDataSource
    Left = 280
    Top = 112
  end
end
