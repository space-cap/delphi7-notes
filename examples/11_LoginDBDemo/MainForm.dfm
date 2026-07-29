object FormMain: TFormMain
  Left = 260
  Top = 150
  Width = 550
  Height = 400
  Caption = '메인 시스템 화면'
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
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 534
    Height = 70
    Align = alTop
    Color = clTeal
    TabOrder = 0
    object LabelWelcome: TLabel
      Left = 20
      Top = 16
      Width = 250
      Height = 18
      Caption = '사용자님 환영합니다!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = '굴림'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelInfo: TLabel
      Left = 20
      Top = 42
      Width = 200
      Height = 12
      Caption = '접속 권한 및 접속 시간'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -12
      Font.Name = '굴림'
      Font.Style = []
      ParentFont = False
    end
    object BtnLogout: TButton
      Left = 430
      Top = 20
      Width = 85
      Height = 32
      Caption = '로그아웃'
      TabOrder = 0
      OnClick = BtnLogoutClick
    end
  end
  object MemoMain: TMemo
    Left = 20
    Top = 90
    Width = 495
    Height = 250
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
