object FormTest: TFormTest
  Left = 250
  Top = 180
  Width = 500
  Height = 360
  Caption = '나만의 커스텀 VCL UI Pack 버튼 테스트'
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
  object LabelTitle: TLabel
    Left = 24
    Top = 20
    Width = 280
    Height = 15
    Caption = '[이미지 속 알약 형태 보라색 커스텀 버튼 테스트]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = '굴림'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelGuide: TLabel
    Left = 24
    Top = 48
    Width = 350
    Height = 12
    Caption = '아래 보라색 커스텀 버튼에 마우스를 올리고 클릭해 보세요!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = '굴림'
    Font.Style = []
    ParentFont = False
  end
  object MemoLog: TMemo
    Left = 24
    Top = 150
    Width = 430
    Height = 150
    ScrollBars = ssVertical
    TabOrder = 0
  end
end
