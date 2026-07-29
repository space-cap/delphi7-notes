object FormUserList: TFormUserList
  Left = 240
  Top = 180
  Width = 540
  Height = 380
  Caption = '사용자 목록 조회'
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
    Caption = '[시스템 사용자 목록]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = '굴림'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StringGridUsers: TStringGrid
    Left = 16
    Top = 45
    Width = 490
    Height = 270
    ColCount = 4
    RowCount = 5
    TabOrder = 0
  end
end
