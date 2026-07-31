object frmMain: TfrmMain
  Left = 200
  Top = 120
  Width = 980
  Height = 640
  Caption = 'DevExpress TcxGrid 게시판 (BBS) CRUD & 페이징 실습 데모'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Gulim'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 964
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Color = 15790320
    TabOrder = 0
    object lblTitle: TLabel
      Left = 16
      Top = 10
      Width = 350
      Height = 19
      Caption = 'DevExpress TcxGrid 게시판 (BBS) CRUD 데모'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Gulim'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSearch: TLabel
      Left = 16
      Top = 39
      Width = 52
      Height = 12
      Caption = '검색어:'
    end
    object edtSearchText: TEdit
      Left = 72
      Top = 35
      Width = 160
      Height = 21
      TabOrder = 0
    end
    object btnSearch: TButton
      Left = 240
      Top = 33
      Width = 75
      Height = 25
      Caption = '조회'
      TabOrder = 1
      OnClick = btnSearchClick
    end
    object btnAdd: TButton
      Left = 330
      Top = 33
      Width = 85
      Height = 25
      Caption = '글쓰기'
      TabOrder = 2
      OnClick = btnAddClick
    end
    object btnEdit: TButton
      Left = 422
      Top = 33
      Width = 85
      Height = 25
      Caption = '수정'
      TabOrder = 3
      OnClick = btnEditClick
    end
    object btnViewDetail: TButton
      Left = 514
      Top = 33
      Width = 85
      Height = 25
      Caption = '상세보기'
      TabOrder = 4
      OnClick = btnViewDetailClick
    end
    object btnDelete: TButton
      Left = 606
      Top = 33
      Width = 85
      Height = 25
      Caption = '삭제'
      TabOrder = 5
      OnClick = btnDeleteClick
    end
  end
  object pnlPaging: TPanel
    Left = 0
    Top = 556
    Width = 964
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    Color = 15790320
    TabOrder = 1
    object lblPageInfo: TLabel
      Left = 180
      Top = 16
      Width = 150
      Height = 14
      Caption = '1 / 1 페이지 (총 0건)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Gulim'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPageSize: TLabel
      Left = 700
      Top = 16
      Width = 70
      Height = 12
      Caption = '페이지 크기:'
    end
    object btnPrevPage: TButton
      Left = 16
      Top = 10
      Width = 70
      Height = 25
      Caption = '◀ 이전'
      TabOrder = 0
      OnClick = btnPrevPageClick
    end
    object btnNextPage: TButton
      Left = 92
      Top = 10
      Width = 70
      Height = 25
      Caption = '다음 ▶'
      TabOrder = 1
      OnClick = btnNextPageClick
    end
    object cbPageSize: TComboBox
      Left = 776
      Top = 12
      Width = 100
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 2
      OnChange = cbPageSizeChange
      Items.Strings = (
        '10개씩 보기'
        '20개씩 보기'
        '50개씩 보기')
    end
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 65
    Width = 964
    Height = 491
    Align = alClient
    TabOrder = 2
    object tvBoard: TcxGridDBTableView
      OnDblClick = tvBoardDblClick
      OnCustomDrawCell = tvBoardCustomDrawCell
      DataController.DataSource = dsBoard
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsData.Editing = False
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glHorizontal
      object tvBoardBoardID: TcxGridDBColumn
        Caption = '글번호'
        DataBinding.FieldName = 'BoardID'
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object tvBoardIsNotice: TcxGridDBColumn
        Caption = '공지'
        DataBinding.FieldName = 'IsNotice'
        PropertiesClassName = 'TcxCheckBoxProperties'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object tvBoardTitle: TcxGridDBColumn
        Caption = '제목'
        DataBinding.FieldName = 'Title'
        HeaderAlignmentHorz = taCenter
        Width = 350
      end
      object tvBoardWriterName: TcxGridDBColumn
        Caption = '작성자'
        DataBinding.FieldName = 'WriterName'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object tvBoardViewCount: TcxGridDBColumn
        Caption = '조회수'
        DataBinding.FieldName = 'ViewCount'
        HeaderAlignmentHorz = taCenter
        Width = 70
      end
      object tvBoardRegDate: TcxGridDBColumn
        Caption = '등록일시'
        DataBinding.FieldName = 'RegDate'
        PropertiesClassName = 'TcxDateEditProperties'
        HeaderAlignmentHorz = taCenter
        Width = 140
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = tvBoard
    end
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Left = 40
    Top = 120
  end
  object qryBoard: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 110
    Top = 120
  end
  object dsBoard: TDataSource
    DataSet = qryBoard
    Left = 175
    Top = 120
  end
end