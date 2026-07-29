object FormSalesOrder: TFormSalesOrder
  Left = 260
  Top = 200
  Width = 540
  Height = 380
  Caption = '영업 주문 등록'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '굴림'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object LabelTitle: TLabel
    Left = 16
    Top = 16
    Width = 142
    Height = 14
    Caption = '[신규 영업 주문 작성]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = '굴림'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelCustomer: TLabel
    Left = 20
    Top = 52
    Width = 40
    Height = 12
    Caption = '고객사:'
  end
  object EditCustomer: TEdit
    Left = 72
    Top = 48
    Width = 120
    Height = 20
    TabOrder = 0
    Text = '(주)한국상사'
  end
  object BtnAddOrder: TButton
    Left = 210
    Top = 46
    Width = 90
    Height = 25
    Caption = '주문 등록'
    TabOrder = 1
    OnClick = BtnAddOrderClick
  end
  object MemoLog: TMemo
    Left = 16
    Top = 85
    Width = 490
    Height = 230
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
