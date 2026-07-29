object FormTabbedMDIMain: TFormTabbedMDIMain
  Left = 180
  Top = 100
  Width = 880
  Height = 620
  Caption = '모던 ERP - 웹 스타일 접이식 사이드바 + 상단 MDI 탭 시스템'
  Color = clAppWorkspace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '굴림'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object SplitterLeft: TSplitter
    Left = 210
    Top = 32
    Width = 5
    Height = 510
  end
  object PanelTopTabs: TPanel
    Left = 0
    Top = 0
    Width = 864
    Height = 32
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object TabControlForms: TTabControl
      Left = 0
      Top = 0
      Width = 864
      Height = 32
      Align = alClient
      TabOrder = 0
      OnChange = TabControlFormsChange
    end
  end
  object PanelSidebar: TPanel
    Left = 0
    Top = 32
    Width = 210
    Height = 510
    Align = alLeft
    BevelOuter = bvLowered
    Color = clWindow
    TabOrder = 1
    object PanelSidebarHeader: TPanel
      Left = 1
      Top = 1
      Width = 208
      Height = 35
      Align = alTop
      BevelOuter = bvNone
      Color = clBtnFace
      TabOrder = 0
      object LabelSidebarTitle: TLabel
        Left = 10
        Top = 11
        Width = 114
        Height = 12
        Caption = '[ERP 메뉴 네비게이터]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '굴림'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object BtnToggleSidebar: TButton
        Left = 172
        Top = 5
        Width = 30
        Height = 25
        Caption = '<'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = '굴림'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = BtnToggleSidebarClick
      end
    end
    object TreeViewSidebar: TTreeView
      Left = 1
      Top = 36
      Width = 208
      Height = 473
      Align = alClient
      Indent = 19
      ReadOnly = True
      TabOrder = 1
      OnDblClick = TreeViewSidebarDblClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 542
    Width = 864
    Height = 20
    Panels = <
      item
        Text = 'ERP 웹 스타일 접이식 사이드바 시스템 준비 완료'
        Width = 350
      end
      item
        Text = '열린 탭: 0개'
        Width = 200
      end>
    SimplePanel = False
  end
  object MainMenu1: TMainMenu
    Left = 240
    Top = 60
    object MenuSystem: TMenuItem
      Caption = '시스템 관리(&S)'
      object MenuUserList: TMenuItem
        Caption = '사용자 목록 조회(&U)'
        OnClick = MenuUserListClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object MenuExit: TMenuItem
        Caption = '종료(&X)'
        OnClick = MenuExitClick
      end
    end
    object MenuSales: TMenuItem
      Caption = '영업 관리(&M)'
      object MenuSalesOrder: TMenuItem
        Caption = '영업 주문 등록(&O)'
        OnClick = MenuSalesOrderClick
      end
    end
    object MenuStock: TMenuItem
      Caption = '재고 관리(&I)'
      object MenuStockItem: TMenuItem
        Caption = '품목 재고 현황(&I)'
        OnClick = MenuStockItemClick
      end
    end
    object MenuWindow: TMenuItem
      Caption = '창 관리(&W)'
      object MenuCloseCurrent: TMenuItem
        Caption = '현재 탭 닫기(&C)'
        OnClick = MenuCloseCurrentClick
      end
      object MenuCloseAll: TMenuItem
        Caption = '모든 탭 닫기(&A)'
        OnClick = MenuCloseAllClick
      end
    end
  end
end
