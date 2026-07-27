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
  Font.Name = '굴림'
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
    Caption = '이름 입력:'
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
    Caption = '인사하기'
    TabOrder = 1
    OnClick = BtnGreetClick
  end
  object BtnClear: TButton
    Left = 340
    Top = 18
    Width = 65
    Height = 25
    Caption = '초기화'
    TabOrder = 3
    OnClick = BtnClearClick
  end
  object MemoLog: TMemo
    Left = 24
    Top = 60
    Width = 380
    Height = 200
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
