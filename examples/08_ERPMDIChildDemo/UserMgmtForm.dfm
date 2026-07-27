object FormUserMgmt: TFormUserMgmt
  Left = 220
  Top = 180
  Width = 480
  Height = 340
  Caption = '사용자 관리 화면 [MDI Child]'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '굴림'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object LabelTitle: TLabel
    Left = 20
    Top = 20
    Width = 160
    Height = 15
    Caption = '[ERP 사용자 권한 관리]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = '굴림'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 20
    Top = 55
    Width = 40
    Height = 12
    Caption = '아이디:'
  end
  object Label2: TLabel
    Left = 200
    Top = 55
    Width = 28
    Height = 12
    Caption = '이름:'
  end
  object EditID: TEdit
    Left = 70
    Top = 50
    Width = 110
    Height = 20
    TabOrder = 0
    Text = 'admin'
  end
  object EditName: TEdit
    Left = 235
    Top = 50
    Width = 110
    Height = 20
    TabOrder = 1
    Text = '홍길동'
  end
  object BtnSave: TButton
    Left = 360
    Top = 48
    Width = 80
    Height = 25
    Caption = '저장'
    TabOrder = 2
    OnClick = BtnSaveClick
  end
  object MemoLog: TMemo
    Left = 20
    Top = 90
    Width = 420
    Height = 190
    ScrollBars = ssVertical
    TabOrder = 3
  end
end
