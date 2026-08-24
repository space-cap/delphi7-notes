object frmUserList: TfrmUserList
  Left = 904
  Top = 318
  Width = 960
  Height = 640
  Caption = 'QuantumGrid(TcxGrid) MS SQL DB '#50672#46041' '#49892#49845
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 944
    Height = 55
    Align = alTop
    TabOrder = 0
    object lblSearch: TLabel
      Left = 16
      Top = 18
      Width = 50
      Height = 13
      Caption = #51060#47492' '#44160#49353':'
    end
    object edtSearchName: TEdit
      Left = 80
      Top = 14
      Width = 120
      Height = 21
      TabOrder = 0
    end
    object btnSearch: TButton
      Left = 210
      Top = 12
      Width = 75
      Height = 30
      Caption = #49324#50857#51088' '#51312#54924
      TabOrder = 1
      OnClick = btnSearchClick
    end
    object btnClear: TButton
      Left = 320
      Top = 12
      Width = 75
      Height = 30
      Caption = #52488#44592#54868
      TabOrder = 2
    end
    object btnExportExcel: TButton
      Left = 400
      Top = 12
      Width = 75
      Height = 30
      Caption = #50641#49472' '#51200#51109
      TabOrder = 3
    end
  end
  object statBar: TStatusBar
    Left = 0
    Top = 582
    Width = 944
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 55
    Width = 944
    Height = 527
    Align = alClient
    TabOrder = 2
    object tvUsers: TcxGridDBTableView
      NavigatorButtons.ConfirmDelete = False
      DataController.DataSource = dsUsers
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = #52509' '#49324#50857#51088': 0'#47749
          Kind = skCount
          Column = tvUsersuser_name
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsView.Footer = True
      object tvUsersuser_id: TcxGridDBColumn
        Caption = #50500#51060#46356
        DataBinding.FieldName = 'user_id'
        Width = 90
      end
      object tvUsersuser_name: TcxGridDBColumn
        Caption = #51060#47492
        DataBinding.FieldName = 'user_name'
        Width = 90
      end
      object tvUsersdepartment: TcxGridDBColumn
        Caption = #48512#49436#47749
        DataBinding.FieldName = 'department'
        Width = 110
      end
      object tvUsersposition: TcxGridDBColumn
        Caption = #51649#44553
        DataBinding.FieldName = 'position'
        Width = 80
      end
      object tvUsersemail: TcxGridDBColumn
        Caption = #51060#47700#51068
        DataBinding.FieldName = 'email'
        Width = 160
      end
      object tvUsersphone: TcxGridDBColumn
        Caption = #50672#46973#52376
        DataBinding.FieldName = 'phone'
      end
      object tvUsersis_active: TcxGridDBColumn
        Caption = #54876#49457#50668#48512
        DataBinding.FieldName = 'is_active'
        HeaderAlignmentHorz = taCenter
        Width = 70
      end
      object tvUserscreated_at: TcxGridDBColumn
        Caption = #46321#47197#51068#49884
        DataBinding.FieldName = 'created_at'
        Width = 140
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = tvUsers
    end
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Data Source=localhost\SQLEXPRESS;Initial Cat' +
      'alog=DELPHI7_DB;User ID=sa;Password=doolman;Persist Security Inf' +
      'o=True'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 48
    Top = 552
  end
  object qryUsers: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM users')
    Left = 112
    Top = 544
  end
  object dsUsers: TDataSource
    DataSet = qryUsers
    Left = 176
    Top = 544
  end
end
