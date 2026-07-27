object FormOrderReg: TFormOrderReg
  Left = 260
  Top = 210
  Width = 480
  Height = 340
  Caption = '주문 등록 화면 [MDI Child]'
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
    Width = 148
    Height = 15
    Caption = '[영업 주문 등록 화면]'
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
    Width = 52
    Height = 12
    Caption = '주문 상품:'
  end
  object Label2: TLabel
    Left = 200
    Top = 55
    Width = 28
    Height = 12
    Caption = '수량:'
  end
  object EditProduct: TEdit
    Left = 80
    Top = 50
    Width = 100
    Height = 20
    TabOrder = 0
    Text = '노트북'
  end
  object EditQty: TEdit
    Left = 235
    Top = 50
    Width = 100
    Height = 20
    TabOrder = 1
    Text = '5'
  end
  object BtnOrder: TButton
    Left = 350
    Top = 48
    Width = 90
    Height = 25
    Caption = '주문 전송'
    TabOrder = 2
    OnClick = BtnOrderClick
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
