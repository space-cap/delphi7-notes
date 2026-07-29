object FormStockItem: TFormStockItem
  Left = 280
  Top = 220
  Width = 540
  Height = 380
  Caption = '품목 재고 현황'
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
    Caption = '[창고별 품목 재고]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = '굴림'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StringGridStock: TStringGrid
    Left = 16
    Top = 45
    Width = 490
    Height = 270
    ColCount = 4
    RowCount = 5
    TabOrder = 0
  end
end
