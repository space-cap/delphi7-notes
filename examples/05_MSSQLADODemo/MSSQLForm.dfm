object FormMSSQL: TFormMSSQL
  Left = 280
  Top = 160
  Width = 620
  Height = 480
  Caption = 'Delphi 7 MS-SQL ADO DB 접속 실습'
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
    Left = 20
    Top = 20
    Width = 56
    Height = 12
    Caption = '서버(Host):'
  end
  object LabelDB: TLabel
    Left = 200
    Top = 20
    Width = 44
    Height = 12
    Caption = 'DB이름:'
  end
  object LabelUser: TLabel
    Left = 350
    Top = 20
    Width = 28
    Height = 12
    Caption = '계정:'
  end
  object EditServer: TEdit
    Left = 82
    Top = 16
    Width = 100
    Height = 20
    TabOrder = 0
    Text = '127.0.0.1'
  end
  object EditDB: TEdit
    Left = 250
    Top = 16
    Width = 85
    Height = 20
    TabOrder = 1
    Text = 'TestDB'
  end
  object EditUser: TEdit
    Left = 385
    Top = 16
    Width = 70
    Height = 20
    TabOrder = 2
    Text = 'sa'
  end
  object BtnConnect: TButton
    Left = 470
    Top = 14
    Width = 110
    Height = 25
    Caption = 'DB 연결 & 조회'
    TabOrder = 3
    OnClick = BtnConnectClick
  end
  object DBGrid1: TDBGrid
    Left = 20
    Top = 50
    Width = 560
    Height = 240
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = '굴림'
    TitleFont.Style = []
  end
  object MemoLog: TMemo
    Left = 20
    Top = 300
    Width = 560
    Height = 120
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Left = 40
    Top = 80
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 80
    Top = 80
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 120
    Top = 80
  end
end
