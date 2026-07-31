object frmMain: TfrmMain
  Left = 250
  Top = 150
  Width = 920
  Height = 600
  Caption = 'DevExpress TcxGrid 실습 데모 (QuantumGrid 6)'
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
    Width = 904
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Color = 15790320
    TabOrder = 0
    object lblTitle: TLabel
      Left = 16
      Top = 10
      Width = 330
      Height = 19
      Caption = 'DevExpress TcxGrid (QuantumGrid) 실습 데모'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Gulim'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnInitData: TButton
      Left = 16
      Top = 35
      Width = 110
      Height = 25
      Caption = '데이터 재로드'
      TabOrder = 0
      OnClick = btnInitDataClick
    end
    object btnGroupDept: TButton
      Left = 132
      Top = 35
      Width = 110
      Height = 25
      Caption = '부서별 그룹핑'
      TabOrder = 1
      OnClick = btnGroupDeptClick
    end
    object btnClearGroup: TButton
      Left = 248
      Top = 35
      Width = 110
      Height = 25
      Caption = '그룹핑 해제'
      TabOrder = 2
      OnClick = btnClearGroupClick
    end
    object btnToggleFilterRow: TButton
      Left = 364
      Top = 35
      Width = 120
      Height = 25
      Caption = '필터행 토글'
      TabOrder = 3
      OnClick = btnToggleFilterRowClick
    end
    object btnDynamicColumn: TButton
      Left = 490
      Top = 35
      Width = 130
      Height = 25
      Caption = '동적 컬럼 추가'
      TabOrder = 4
      OnClick = btnDynamicColumnClick
    end
    object btnExportExcel: TButton
      Left = 626
      Top = 35
      Width = 120
      Height = 25
      Caption = '엑셀 내보내기'
      TabOrder = 5
      OnClick = btnExportExcelClick
    end
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 65
    Width = 904
    Height = 496
    Align = alClient
    TabOrder = 1
    object tvEmp: TcxGridDBTableView
      NavigatorButtons.ConfirmDelete = False
      OnCustomDrawCell = tvEmpCustomDrawCell
      DataController.DataSource = dsEmp
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsData.Editing = True
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GroupFooters = gfAlwaysVisible
      object tvEmpEmpID: TcxGridDBColumn
        Caption = '사번'
        DataBinding.FieldName = 'EmpID'
        HeaderAlignmentHorz = taCenter
        Width = 70
      end
      object tvEmpEmpName: TcxGridDBColumn
        Caption = '성명'
        DataBinding.FieldName = 'EmpName'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object tvEmpDeptName: TcxGridDBColumn
        Caption = '부서명'
        DataBinding.FieldName = 'DeptName'
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object tvEmpPosition: TcxGridDBColumn
        Caption = '직급'
        DataBinding.FieldName = 'Position'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object tvEmpSalary: TcxGridDBColumn
        Caption = '연봉/급여'
        DataBinding.FieldName = 'Salary'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 120
      end
      object tvEmpHireDate: TcxGridDBColumn
        Caption = '입사일자'
        DataBinding.FieldName = 'HireDate'
        PropertiesClassName = 'TcxDateEditProperties'
        HeaderAlignmentHorz = taCenter
        Width = 110
      end
      object tvEmpIsActive: TcxGridDBColumn
        Caption = '재직 여부'
        DataBinding.FieldName = 'IsActive'
        PropertiesClassName = 'TcxCheckBoxProperties'
        HeaderAlignmentHorz = taCenter
        Width = 80
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = tvEmp
    end
  end
  object cdsEmp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 120
    object cdsEmpEmpID: TIntegerField
      FieldName = 'EmpID'
    end
    object cdsEmpEmpName: TStringField
      FieldName = 'EmpName'
      Size = 30
    end
    object cdsEmpDeptName: TStringField
      FieldName = 'DeptName'
      Size = 50
    end
    object cdsEmpPosition: TStringField
      FieldName = 'Position'
      Size = 30
    end
    object cdsEmpSalary: TCurrencyField
      FieldName = 'Salary'
    end
    object cdsEmpHireDate: TDateTimeField
      FieldName = 'HireDate'
    end
    object cdsEmpIsActive: TBooleanField
      FieldName = 'IsActive'
    end
  end
  object dsEmp: TDataSource
    DataSet = cdsEmp
    Left = 104
    Top = 120
  end
end