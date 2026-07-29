object FormUserList: TFormUserList
  Left = 280
  Top = 180
  Width = 620
  Height = 420
  Caption = '사용자 목록 관리 (DB 커넥션 재활용 조회 화면)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '굴림'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 604
    Height = 55
    Align = alTop
    TabOrder = 0
    object LabelSearch: TLabel
      Left = 16
      Top = 20
      Width = 85
      Height = 12
      Caption = '검색어(ID/이름):'
    end
    object EditSearch: TEdit
      Left = 105
      Top = 16
      Width = 165
      Height = 21
      TabOrder = 0
    end
    object BtnSearch: TButton
      Left = 280
      Top = 14
      Width = 75
      Height = 25
      Caption = '검 색(&S)'
      TabOrder = 1
      OnClick = BtnSearchClick
    end
    object BtnRefresh: TButton
      Left = 362
      Top = 14
      Width = 75
      Height = 25
      Caption = '전체보기(&R)'
      TabOrder = 2
      OnClick = BtnRefreshClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 55
    Width = 604
    Height = 285
    Align = alClient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = '굴림'
    TitleFont.Style = []
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 340
    Width = 604
    Height = 41
    Align = alBottom
    TabOrder = 2
    object LabelCount: TLabel
      Left = 16
      Top = 14
      Width = 200
      Height = 12
      Caption = '조회 결과 대기 중...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = '굴림'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BtnClose: TButton
      Left = 512
      Top = 8
      Width = 80
      Height = 26
      Caption = '닫 기(&X)'
      TabOrder = 0
      OnClick = BtnCloseClick
    end
  end
  object DataSource1: TDataSource
    Left = 40
    Top = 80
  end
  object ADOQueryUserList: TADOQuery
    Parameters = <>
    Left = 88
    Top = 80
  end
end
