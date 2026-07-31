object frmMain: TfrmMain
  Left = 180
  Top = 90
  Width = 1060
  Height = 720
  Caption = 'DevExpress TcxGrid 상하 분할 (Split-Panel) 마스터-디테일 실습 데모'
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
    Width = 1044
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Color = 15790320
    TabOrder = 0
    object lblTitle: TLabel
      Left = 16
      Top = 10
      Width = 430
      Height = 19
      Caption = 'DevExpress Split-Panel Master-Detail Realtime Sync'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Gulim'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDate: TLabel
      Left = 16
      Top = 39
      Width = 52
      Height = 12
      Caption = '조회기간:'
    end
    object dtpStart: TDateTimePicker
      Left = 72
      Top = 35
      Width = 105
      Height = 21
      Date = 46234.000000000000000000
      Time = 46234.000000000000000000
      TabOrder = 0
    end
    object lblWave: TLabel
      Left = 182
      Top = 39
      Width = 10
      Height = 12
      Caption = '~'
    end
    object dtpEnd: TDateTimePicker
      Left = 197
      Top = 35
      Width = 105
      Height = 21
      Date = 46234.000000000000000000
      Time = 46234.000000000000000000
      TabOrder = 1
    end
    object lblClient: TLabel
      Left = 315
      Top = 39
      Width = 40
      Height = 12
      Caption = '거래처:'
    end
    object edtClient: TEdit
      Left = 360
      Top = 35
      Width = 130
      Height = 21
      TabOrder = 2
      OnKeyDown = edtClientKeyDown
    end
    object lblStatus: TLabel
      Left = 505
      Top = 39
      Width = 52
      Height = 12
      Caption = '결제상태:'
    end
    object cbStatus: TComboBox
      Left = 562
      Top = 35
      Width = 90
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 3
      Items.Strings = (
        '전체'
        '완납'
        '미수'
        '부분입금')
    end
    object btnSearch: TButton
      Left = 665
      Top = 33
      Width = 80
      Height = 25
      Caption = '조회'
      Default = True
      TabOrder = 4
      OnClick = btnSearchClick
    end
    object btnExportExcel: TButton
      Left = 755
      Top = 33
      Width = 95
      Height = 25
      Caption = '엑셀 저장'
      TabOrder = 5
      OnClick = btnExportExcelClick
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 636
    Width = 1044
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    Color = 15790320
    TabOrder = 1
    object lblInfo: TLabel
      Left = 16
      Top = 16
      Width = 350
      Height = 14
      Caption = '상단 전표 행을 이동하면 하단 디테일 품목이 자동 연동됩니다.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Gulim'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlMaster: TPanel
    Left = 0
    Top = 65
    Width = 1044
    Height = 280
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object pnlMasterHeader: TPanel
      Left = 0
      Top = 0
      Width = 1044
      Height = 25
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Color = 14211288
      TabOrder = 0
      object lblMasterTitle: TLabel
        Left = 10
        Top = 6
        Width = 220
        Height = 12
        Caption = ' [상단] 매출 전표 목록 (Master List)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Gulim'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object cxGridMaster: TcxGrid
      Left = 0
      Top = 25
      Width = 1044
      Height = 255
      Align = alClient
      TabOrder = 1
      object tvSalesMaster: TcxGridDBTableView
        OnCustomDrawCell = tvSalesMasterCustomDrawCell
        DataController.DataSource = dsMaster
        DataController.KeyFieldNames = 'SalesID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '전표 건수: #,##0건'
            Kind = skCount
            FieldName = 'SalesNo'
            Column = tvSalesMasterSalesNo
          end
          item
            Format = '\#,##0'
            Kind = skSum
            FieldName = 'TotalPrice'
            Column = tvSalesMasterTotalPrice
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.FocusCellOnTab = True
        OptionsData.Editing = False
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLines = glHorizontal
        object tvSalesMasterSalesID: TcxGridDBColumn
          Caption = 'ID'
          DataBinding.FieldName = 'SalesID'
          HeaderAlignmentHorz = taCenter
          Width = 50
        end
        object tvSalesMasterSalesNo: TcxGridDBColumn
          Caption = '전표번호'
          DataBinding.FieldName = 'SalesNo'
          HeaderAlignmentHorz = taCenter
          Width = 130
        end
        object tvSalesMasterSalesDate: TcxGridDBColumn
          Caption = '매출일자'
          DataBinding.FieldName = 'SalesDate'
          PropertiesClassName = 'TcxDateEditProperties'
          HeaderAlignmentHorz = taCenter
          Width = 100
        end
        object tvSalesMasterClientName: TcxGridDBColumn
          Caption = '거래처명'
          DataBinding.FieldName = 'ClientName'
          HeaderAlignmentHorz = taCenter
          Width = 150
        end
        object tvSalesMasterSalesRep: TcxGridDBColumn
          Caption = '영업담당'
          DataBinding.FieldName = 'SalesRep'
          HeaderAlignmentHorz = taCenter
          Width = 90
        end
        object tvSalesMasterPaymentStatus: TcxGridDBColumn
          Caption = '결제상태'
          DataBinding.FieldName = 'PaymentStatus'
          HeaderAlignmentHorz = taCenter
          Width = 80
        end
        object tvSalesMasterTotalPrice: TcxGridDBColumn
          Caption = '총 매출금액'
          DataBinding.FieldName = 'TotalPrice'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          HeaderAlignmentHorz = taCenter
          Width = 130
        end
        object tvSalesMasterRemark: TcxGridDBColumn
          Caption = '적요 / 메모'
          DataBinding.FieldName = 'Remark'
          HeaderAlignmentHorz = taCenter
          Width = 200
        end
      end
      object cxGridMasterLevel1: TcxGridLevel
        GridView = tvSalesMaster
      end
    end
  end
  object Splitter1: TSplitter
    Left = 0
    Top = 345
    Width = 1044
    Height = 6
    Cursor = crVSplit
    Align = alTop
    Color = clBtnFace
  end
  object pnlDetail: TPanel
    Left = 0
    Top = 351
    Width = 1044
    Height = 285
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object pnlDetailHeader: TPanel
      Left = 0
      Top = 0
      Width = 1044
      Height = 25
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Color = 14211288
      TabOrder = 0
      object lblDetailTitle: TLabel
        Left = 10
        Top = 6
        Width = 350
        Height = 12
        Caption = ' [하단] 상세 품목 목록 (Detail Items)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clDarkGreen
        Font.Height = -12
        Font.Name = 'Gulim'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object cxGridDetail: TcxGrid
      Left = 0
      Top = 25
      Width = 1044
      Height = 260
      Align = alClient
      TabOrder = 1
      object tvSalesDetail: TcxGridDBTableView
        DataController.DataSource = dsDetail
        DataController.KeyFieldNames = 'DetailID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '품목 합계: #,##0'
            Kind = skSum
            FieldName = 'Amount'
            Column = tvSalesDetailAmount
          end
          item
            Format = '수량: #,##0개'
            Kind = skSum
            FieldName = 'Qty'
            Column = tvSalesDetailQty
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.FocusCellOnTab = True
        OptionsData.Editing = False
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLines = glHorizontal
        object tvSalesDetailDetailID: TcxGridDBColumn
          Caption = '디테일ID'
          DataBinding.FieldName = 'DetailID'
          Visible = False
        end
        object tvSalesDetailSalesID: TcxGridDBColumn
          Caption = '매출ID'
          DataBinding.FieldName = 'SalesID'
          Visible = False
        end
        object tvSalesDetailLineNo: TcxGridDBColumn
          Caption = '순번'
          DataBinding.FieldName = 'ItemSeq'
          HeaderAlignmentHorz = taCenter
          Width = 50
        end
        object tvSalesDetailItemCode: TcxGridDBColumn
          Caption = '품목코드'
          DataBinding.FieldName = 'ItemCode'
          HeaderAlignmentHorz = taCenter
          Width = 110
        end
        object tvSalesDetailItemName: TcxGridDBColumn
          Caption = '품목명 / 서비스명'
          DataBinding.FieldName = 'ItemName'
          HeaderAlignmentHorz = taCenter
          Width = 240
        end
        object tvSalesDetailPrice: TcxGridDBColumn
          Caption = '단가'
          DataBinding.FieldName = 'Price'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          HeaderAlignmentHorz = taCenter
          Width = 110
        end
        object tvSalesDetailQty: TcxGridDBColumn
          Caption = '수량'
          DataBinding.FieldName = 'Qty'
          PropertiesClassName = 'TcxSpinEditProperties'
          HeaderAlignmentHorz = taCenter
          Width = 70
        end
        object tvSalesDetailAmount: TcxGridDBColumn
          Caption = '공급가액'
          DataBinding.FieldName = 'Amount'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          HeaderAlignmentHorz = taCenter
          Width = 140
        end
      end
      object cxGridDetailLevel1: TcxGridLevel
        GridView = tvSalesDetail
      end
    end
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Left = 40
    Top = 120
  end
  object qryMaster: TADOQuery
    Connection = ADOConnection1
    AfterScroll = qryMasterAfterScroll
    Parameters = <>
    Left = 110
    Top = 120
  end
  object dsMaster: TDataSource
    DataSet = qryMaster
    Left = 175
    Top = 120
  end
  object qryDetail: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 245
    Top = 120
  end
  object dsDetail: TDataSource
    DataSet = qryDetail
    Left = 310
    Top = 120
  end
end