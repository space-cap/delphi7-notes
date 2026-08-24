object frmMain: TfrmMain
  Left = 667
  Top = 278
  Width = 920
  Height = 600
  Caption = 'DevExpress TcxGrid '#49892#49845' '#45936#47784' (QuantumGrid 6)'
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
      Width = 370
      Height = 16
      Caption = 'DevExpress TcxGrid (QuantumGrid) '#49892#49845' '#45936#47784
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
      Caption = #45936#51060#53552' '#51116#47196#46300
      TabOrder = 0
      OnClick = btnInitDataClick
    end
    object btnGroupDept: TButton
      Left = 132
      Top = 35
      Width = 110
      Height = 25
      Caption = #48512#49436#48324' '#44536#47353#54609
      TabOrder = 1
      OnClick = btnGroupDeptClick
    end
    object btnClearGroup: TButton
      Left = 248
      Top = 35
      Width = 110
      Height = 25
      Caption = #44536#47353#54609' '#54644#51228
      TabOrder = 2
      OnClick = btnClearGroupClick
    end
    object btnToggleFilterRow: TButton
      Left = 364
      Top = 35
      Width = 120
      Height = 25
      Caption = #54596#53552#54665' '#53664#44544
      TabOrder = 3
      OnClick = btnToggleFilterRowClick
    end
    object btnDynamicColumn: TButton
      Left = 490
      Top = 35
      Width = 130
      Height = 25
      Caption = #46041#51201' '#52972#47100' '#52628#44032
      TabOrder = 4
      OnClick = btnDynamicColumnClick
    end
    object btnExportExcel: TButton
      Left = 626
      Top = 35
      Width = 120
      Height = 25
      Caption = #50641#49472' '#45236#48372#45236#44592
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
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GroupFooters = gfAlwaysVisible
      object tvEmpEmpID: TcxGridDBColumn
        Caption = #49324#48264
        DataBinding.FieldName = 'EmpID'
        HeaderAlignmentHorz = taCenter
        Width = 70
      end
      object tvEmpEmpName: TcxGridDBColumn
        Caption = #49457#47749
        DataBinding.FieldName = 'EmpName'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object tvEmpDeptName: TcxGridDBColumn
        Caption = #48512#49436#47749
        DataBinding.FieldName = 'DeptName'
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object tvEmpPosition: TcxGridDBColumn
        Caption = #51649#44553
        DataBinding.FieldName = 'Position'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object tvEmpSalary: TcxGridDBColumn
        Caption = #50672#48393'/'#44553#50668
        DataBinding.FieldName = 'Salary'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 120
      end
      object tvEmpHireDate: TcxGridDBColumn
        Caption = #51077#49324#51068#51088
        DataBinding.FieldName = 'HireDate'
        PropertiesClassName = 'TcxDateEditProperties'
        HeaderAlignmentHorz = taCenter
        Width = 110
      end
      object tvEmpIsActive: TcxGridDBColumn
        Caption = #51116#51649' '#50668#48512
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
