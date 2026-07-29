object FormLogin: TFormLogin
  Left = 300
  Top = 200
  Width = 380
  Height = 310
  Caption = '시스템 로그인 (DataModule 커넥션 공유)'
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
  object LabelUserID: TLabel
    Left = 32
    Top = 88
    Width = 52
    Height = 12
    Caption = '아 이 디 :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = '굴림'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelUserPW: TLabel
    Left = 32
    Top = 124
    Width = 52
    Height = 12
    Caption = '비밀번호 :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = '굴림'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelStatus: TLabel
    Left = 32
    Top = 160
    Width = 300
    Height = 12
    Caption = '상태 메시지'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = '굴림'
    Font.Style = []
    ParentFont = False
  end
  object PanelHeader: TPanel
    Left = 0
    Top = 0
    Width = 364
    Height = 65
    Align = alTop
    Color = clNavy
    TabOrder = 0
    object LabelTitle: TLabel
      Left = 24
      Top = 14
      Width = 190
      Height = 18
      Caption = 'ERP 로그인 (DataModule 공유)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = '굴림'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelSubtitle: TLabel
      Left = 24
      Top = 38
      Width = 237
      Height = 12
      Caption = '등록된 사용자 아이디와 비밀번호를 입력하세요'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -11
      Font.Name = '굴림'
      Font.Style = []
      ParentFont = False
    end
  end
  object EditUserID: TEdit
    Left = 100
    Top = 84
    Width = 225
    Height = 21
    TabOrder = 1
  end
  object EditUserPW: TEdit
    Left = 100
    Top = 120
    Width = 225
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    OnKeyPress = EditUserPWKeyPress
  end
  object BtnLogin: TButton
    Left = 32
    Top = 192
    Width = 90
    Height = 32
    Caption = '로그인(&L)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = '굴림'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BtnLoginClick
  end
  object BtnCancel: TButton
    Left = 132
    Top = 192
    Width = 90
    Height = 32
    Caption = '취 소(&C)'
    TabOrder = 4
    OnClick = BtnCancelClick
  end
  object BtnDBConfig: TButton
    Left = 232
    Top = 192
    Width = 95
    Height = 32
    Caption = 'DB 설정(&S)'
    TabOrder = 5
    OnClick = BtnDBConfigClick
  end
  object ADOQueryLogin: TADOQuery
    Parameters = <>
    Left = 320
    Top = 8
  end
end
