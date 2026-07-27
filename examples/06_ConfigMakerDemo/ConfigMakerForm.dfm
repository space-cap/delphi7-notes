object FormConfigMaker: TFormConfigMaker
  Left = 320
  Top = 200
  Width = 520
  Height = 440
  Caption = 'DB config.dat 암호화 설정 파일 생성기'
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
  object LabelServer: TLabel
    Left = 24
    Top = 24
    Width = 56
    Height = 12
    Caption = '서버(Host):'
  end
  object LabelDB: TLabel
    Left = 24
    Top = 54
    Width = 44
    Height = 12
    Caption = 'DB이름:'
  end
  object LabelUser: TLabel
    Left = 24
    Top = 84
    Width = 40
    Height = 12
    Caption = 'DB 계정:'
  end
  object LabelPass: TLabel
    Left = 24
    Top = 114
    Width = 52
    Height = 12
    Caption = '비밀번호:'
  end
  object EditServer: TEdit
    Left = 90
    Top = 20
    Width = 200
    Height = 20
    TabOrder = 0
    Text = '127.0.0.1'
  end
  object EditDB: TEdit
    Left = 90
    Top = 50
    Width = 200
    Height = 20
    TabOrder = 1
    Text = 'TestDB'
  end
  object EditUser: TEdit
    Left = 90
    Top = 80
    Width = 200
    Height = 20
    TabOrder = 2
    Text = 'sa'
  end
  object EditPass: TEdit
    Left = 90
    Top = 110
    Width = 200
    Height = 20
    PasswordChar = '*'
    TabOrder = 3
    Text = 'pms'
  end
  object BtnSaveConfig: TButton
    Left = 310
    Top = 20
    Width = 170
    Height = 50
    Caption = 'config.dat 암호화 저장'
    TabOrder = 4
    OnClick = BtnSaveConfigClick
  end
  object BtnTestRead: TButton
    Left = 310
    Top = 80
    Width = 170
    Height = 50
    Caption = 'config.dat 복호화 검증'
    TabOrder = 5
    OnClick = BtnTestReadClick
  end
  object MemoLog: TMemo
    Left = 24
    Top = 150
    Width = 456
    Height = 230
    ScrollBars = ssVertical
    TabOrder = 6
  end
end
