object frmMain: TfrmMain
  Left = 180
  Top = 100
  Width = 1040
  Height = 680
  Caption = 'DevExpress TcxGrid 수주 마스터-디테일 (Master-Detail) 실습 데모'
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
    Width = 1024
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Color = 15790320
    TabOrder = 0
    object lblTitle: TLabel
      Left = 16
      Top = 10
      Width = 420
      Height = 19
      Caption = 'DevExpress Master-Detail & Date Range Search Demo'
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
    object lblCustomer: TLabel
      Left = 315
      Top = 39
      Width = 40
      Height = 12
      Caption = '고객사:'
    end
    object edtCustomer: TEdit
      Left = 360
      Top = 35
      Width = 130
      Height = 21
      TabOrder = 2
      OnKeyDown = edtCustomerKeyDown
    end
    object lblStatus: TLabel
      Left = 505
      Top = 39
      Width = 28
      Height = 12
      Caption = '상태:'
    end
    object cbStatus: TComboBox
      Left = 540
      Top = 35
      Width = 90
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 3
      Items.Strings = (
        '전체'
        '접수'
        '진행중'
        '완료'
        '취소')
    end
    object btnSearch: TButton
      Left = 645
      Top = 33
      Width = 80
      Height = 25
      Caption = '조회'
      Default = True
      TabOrder = 4
      OnClick = btnSearchClick
    end
    object btnExportExcel: TButton
      Left = 735
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
    Top = 596
    Width = 1024
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
      Caption = '조회 버튼을 누르시면 데이터가 인출됩니다.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Gulim'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 65
    Width = 1024
    Height = 531
    Align = alClient
    TabOrder = 2
    object tvOrderMaster: TcxGridDBTableView
      OnCustomDrawCell = tvOrderMasterCustomDrawCell
      DataController.DataSource = dsMaster
      DataController.KeyFieldNames = 'OrderID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '총 주문: #,##0건'
          Kind = skCount
          FieldName = 'OrderNo'
          Column = tvOrderMasterOrderNo
        end
        item
          Format = '\#,##0'
          Kind = skSum
          FieldName = 'TotalAmount'
          Column = tvOrderMasterTotalAmount
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsData.Editing = False
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLines = glHorizontal
      object tvOrderMasterOrderID: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'OrderID'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object tvOrderMasterOrderNo: TcxGridDBColumn
        Caption = '주문번호'
        DataBinding.FieldName = 'OrderNo'
        HeaderAlignmentHorz = taCenter
        Width = 130
      end
      object tvOrderMasterOrderDate: TcxGridDBColumn
        Caption = '주문일자'
        DataBinding.FieldName = 'OrderDate'
        PropertiesClassName = 'TcxDateEditProperties'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object tvOrderMasterCustomerName: TcxGridDBColumn
        Caption = '고객사 / 거래처'
        DataBinding.FieldName = 'CustomerName'
        HeaderAlignmentHorz = taCenter
        Width = 140
      end
      object tvOrderMasterOrderStatus: TcxGridDBColumn
        Caption = '진행상태'
        DataBinding.FieldName = 'OrderStatus'
        HeaderAlignmentHorz = taCenter
        Width = 80
      end
      object tvOrderMasterTotalAmount: TcxGridDBColumn
        Caption = '총 주문금액'
        DataBinding.FieldName = 'TotalAmount'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 120
      end
      object tvOrderMasterRemark: TcxGridDBColumn
        Caption = '비고 / 메모'
        DataBinding.FieldName = 'Remark'
        HeaderAlignmentHorz = taCenter
        Width = 200
      end
    end
    object tvOrderDetail: TcxGridDBTableView
      DataController.DataSource = dsDetail
      DataController.KeyFieldNames = 'DetailID'
      DataController.MasterKeyFieldNames = 'OrderID'
      DataController.DetailKeyFieldNames = 'OrderID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '품목 합계: #,##0'
          Kind = skSum
          FieldName = 'SubTotal'
          Column = tvOrderDetailSubTotal
        end
        item
          Format = '수량: #,##0개'
          Kind = skSum
          FieldName = 'Qty'
          Column = tvOrderDetailQty
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsData.Editing = False
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLines = glHorizontal
      object tvOrderDetailDetailID: TcxGridDBColumn
        Caption = '디테일ID'
        DataBinding.FieldName = 'DetailID'
        Visible = False
      end
      object tvOrderDetailOrderID: TcxGridDBColumn
        Caption = '주문ID'
        DataBinding.FieldName = 'OrderID'
        Visible = False
      end
      object tvOrderDetailItemNo: TcxGridDBColumn
        Caption = '순번'
        DataBinding.FieldName = 'ItemNo'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object tvOrderDetailItemName: TcxGridDBColumn
        Caption = '품목명 / 상품명'
        DataBinding.FieldName = 'ItemName'
        HeaderAlignmentHorz = taCenter
        Width = 220
      end
      object tvOrderDetailUnitPrice: TcxGridDBColumn
        Caption = '단가'
        DataBinding.FieldName = 'UnitPrice'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object tvOrderDetailQty: TcxGridDBColumn
        Caption = '수량'
        DataBinding.FieldName = 'Qty'
        PropertiesClassName = 'TcxSpinEditProperties'
        HeaderAlignmentHorz = taCenter
        Width = 70
      end
      object tvOrderDetailSubTotal: TcxGridDBColumn
        Caption = '공급가액'
        DataBinding.FieldName = 'SubTotal'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = tvOrderMaster
      object cxGrid1Level2: TcxGridLevel
        GridView = tvOrderDetail
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