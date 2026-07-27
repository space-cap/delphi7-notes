object FormERPMenu: TFormERPMenu
  Left = 250
  Top = 150
  Width = 720
  Height = 520
  Caption = 'ERP 시스템 메인 메뉴 구성 실습'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '굴림'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter1: TSplitter
    Left = 200
    Top = 0
    Width = 5
    Height = 441
  end
  object PanelLeft: TPanel
    Left = 0
    Top = 0
    Width = 200
    Height = 441
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object LabelTreeTitle: TLabel
      Left = 10
      Top = 10
      Width = 98
      Height = 12
      Caption = '[ERP 전체 메뉴]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = '굴림'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object TreeViewMenu: TTreeView
      Left = 0
      Top = 30
      Width = 200
      Height = 411
      Align = alBottom
      Indent = 19
      ReadOnly = True
      TabOrder = 0
      OnDblClick = TreeViewMenuDblClick
    end
  end
  object PanelMain: TPanel
    Left = 205
    Top = 0
    Width = 499
    Height = 441
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object LabelStatus: TLabel
      Left = 16
      Top = 12
      Width = 210
      Height = 12
      Caption = '메뉴를 선택하면 여기에 표시됩니다.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = '굴림'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object MemoLog: TMemo
      Left = 16
      Top = 36
      Width = 465
      Height = 390
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 441
    Width = 704
    Height = 20
    Panels = <
      item
        Text = '준비 완료'
        Width = 200
      end
      item
        Text = '접속자: 관리자(admin)'
        Width = 200
      end>
    SimplePanel = False
  end
  object MainMenu1: TMainMenu
    Left = 240
    Top = 60
    object MenuSystem: TMenuItem
      Caption = '시스템 관리(&S)'
      object MenuUserMgmt: TMenuItem
        Caption = '사용자 관리(&U)'
        OnClick = MenuUserMgmtClick
      end
      object MenuAuthMgmt: TMenuItem
        Caption = '권한 설정(&A)'
        OnClick = MenuAuthMgmtClick
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
      object MenuOrderReg: TMenuItem
        Caption = '주문 등록(&O)'
        OnClick = MenuOrderRegClick
      end
      object MenuSalesStatus: TMenuItem
        Caption = '매출 현황(&R)'
        OnClick = MenuSalesStatusClick
      end
    end
    object MenuStock: TMenuItem
      Caption = '재고 관리(&I)'
      object MenuInbound: TMenuItem
        Caption = '입고 관리(&I)'
        OnClick = MenuInboundClick
      end
      object MenuStockStatus: TMenuItem
        Caption = '재고 현황(&S)'
        OnClick = MenuStockStatusClick
      end
    end
    object MenuHelp: TMenuItem
      Caption = '도움말(&H)'
      object MenuAbout: TMenuItem
        Caption = '프로그램 정보(&A)'
        OnClick = MenuAboutClick
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 280
    Top = 60
    object PopupRefresh: TMenuItem
      Caption = '새로고침(&R)'
      OnClick = PopupRefreshClick
    end
    object PopupClearLog: TMenuItem
      Caption = '로그 창 비우기(&C)'
      OnClick = PopupClearLogClick
    end
  end
end
