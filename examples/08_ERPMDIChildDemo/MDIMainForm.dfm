object FormMDIMain: TFormMDIMain
  Left = 200
  Top = 120
  Width = 800
  Height = 600
  Caption = '진짜 ERP 시스템 MDI 메인 화면'
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 521
    Width = 784
    Height = 20
    Panels = <
      item
        Text = 'ERP MDI 시스템 작동 중'
        Width = 250
      end
      item
        Text = '열린 자식 창: 0개'
        Width = 200
      end>
    SimplePanel = False
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 40
    object MenuSystem: TMenuItem
      Caption = '시스템 관리(&S)'
      object MenuUserMgmt: TMenuItem
        Caption = '사용자 관리 창 열기(&U)'
        OnClick = MenuUserMgmtClick
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
        Caption = '주문 등록 창 열기(&O)'
        OnClick = MenuOrderRegClick
      end
    end
    object MenuWindow: TMenuItem
      Caption = '창 관리(&W)'
      object MenuCascade: TMenuItem
        Caption = '계단식 정렬(&C)'
        OnClick = MenuCascadeClick
      end
      object MenuTile: TMenuItem
        Caption = '바둑판 정렬(&T)'
        OnClick = MenuTileClick
      end
      object MenuCloseAll: TMenuItem
        Caption = '열린 창 모두 닫기(&A)'
        OnClick = MenuCloseAllClick
      end
    end
  end
end
