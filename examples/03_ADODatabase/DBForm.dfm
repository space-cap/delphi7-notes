object FormDB: TFormDB
  Left = 300
  Top = 180
  Width = 520
  Height = 400
  Caption = 'FormDB'
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
  object LabelName: TLabel
    Left = 24
    Top = 20
    Width = 28
    Height = 12
    Caption = '이름:'
  end
  object LabelAge: TLabel
    Left = 174
    Top = 20
    Width = 28
    Height = 12
    Caption = '나이:'
  end
  object EditName: TEdit
    Left = 56
    Top = 16
    Width = 100
    Height = 20
    TabOrder = 0
  end
  object EditAge: TEdit
    Left = 206
    Top = 16
    Width = 60
    Height = 20
    TabOrder = 1
    Text = '20'
  end
  object BtnAdd: TButton
    Left = 280
    Top = 14
    Width = 75
    Height = 25
    Caption = '추가하기'
    TabOrder = 2
    OnClick = BtnAddClick
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 50
    Width = 450
    Height = 250
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = '굴림'
    TitleFont.Style = []
  end
  object BtnFirst: TButton
    Left = 24
    Top = 315
    Width = 90
    Height = 25
    Caption = '맨 처음 (First)'
    TabOrder = 4
    OnClick = BtnFirstClick
  end
  object BtnNext: TButton
    Left = 124
    Top = 315
    Width = 90
    Height = 25
    Caption = '다음 (Next)'
    TabOrder = 5
    OnClick = BtnNextClick
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 380
    Top = 12
  end
  object DataSource1: TDataSource
    Left = 420
    Top = 12
  end
end
