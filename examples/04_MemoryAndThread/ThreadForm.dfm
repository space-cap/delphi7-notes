object FormThread: TFormThread
  Left = 320
  Top = 220
  Width = 480
  Height = 360
  Caption = 'FormThread'
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
  object LabelStatus: TLabel
    Left = 24
    Top = 20
    Width = 72
    Height = 12
    Caption = '진행률: 0%'
  end
  object ProgressBar1: TProgressBar
    Left = 24
    Top = 45
    Width = 410
    Height = 20
    TabOrder = 0
  end
  object BtnStartThread: TButton
    Left = 24
    Top = 80
    Width = 160
    Height = 30
    Caption = '스레드 다운로드 시작'
    TabOrder = 1
    OnClick = BtnStartThreadClick
  end
  object MemoLog: TMemo
    Left = 24
    Top = 125
    Width = 410
    Height = 170
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
