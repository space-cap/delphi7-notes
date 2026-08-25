object frmUserListCode: TfrmUserListCode
  Left = 443
  Top = 125
  Width = 1740
  Height = 900
  Caption = #54924
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 1724
    Height = 55
    Align = alTop
    TabOrder = 0
    object lblSearch: TLabel
      Left = 32
      Top = 24
      Width = 50
      Height = 13
      Caption = #51060#47492' '#44160#49353':'
    end
    object edtSearchName: TEdit
      Left = 152
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object btnSearch: TButton
      Left = 328
      Top = 24
      Width = 75
      Height = 25
      Caption = #49324#50857#51088' '#51312
      TabOrder = 1
      OnClick = btnSearchClick
    end
    object btnClear: TButton
      Left = 432
      Top = 16
      Width = 75
      Height = 25
      Caption = #52488#44592#54868
      TabOrder = 2
    end
    object btnExportExcel: TButton
      Left = 576
      Top = 24
      Width = 75
      Height = 25
      Caption = #50641#49472' '#51200#51109
      TabOrder = 3
    end
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 55
    Width = 1724
    Height = 787
    Align = alClient
    TabOrder = 1
    object tvUsers: TcxGridDBTableView
      NavigatorButtons.ConfirmDelete = False
      DataController.DataSource = dsUsers
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = tvUsers
    end
  end
  object statBar: TStatusBar
    Left = 0
    Top = 842
    Width = 1724
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Left = 88
    Top = 712
  end
  object qryUsers: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 264
    Top = 744
  end
  object dsUsers: TDataSource
    DataSet = qryUsers
    Left = 360
    Top = 752
  end
end
