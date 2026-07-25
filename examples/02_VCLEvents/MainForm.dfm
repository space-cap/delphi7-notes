object FormMain: TFormMain
  Left = 350
  Top = 200
  Width = 450
  Height = 350
  Caption = 'FormMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #44404#47548
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object LabelName: TLabel
    Left = 24
    Top = 24
    Width = 56
    Height = 12
    Caption = #51060#47492' '#51077#47141':'
  end
  object EditName: TEdit
    Left = 88
    Top = 20
    Width = 150
    Height = 20
    TabOrder = 0
  end
  object BtnGreet: TButton
    Left = 250
    Top = 18
    Width = 85
    Height = 25
    Caption = #51064#49324#54616#44592
    TabOrder = 1
    OnClick = BtnGreetClick
  end
  object MemoLog: TMemo
    Left = 24
    Top = 60
    Width = 380
    Height = 200
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object BtnClear: TButton
    Left = 319
    Top = 270
    Width = 85
    Height = 25
    Caption = #47196#44536' '#51648#50864#44592
    TabOrder = 3
    OnClick = BtnClearClick
  end
end
