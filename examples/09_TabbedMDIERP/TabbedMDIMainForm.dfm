object FormTabbedMDIMain: TFormTabbedMDIMain
  Left = 531
  Top = 136
  Width = 950
  Height = 546
  Caption = #47784#45912' ERP - '#50937' '#49828#53440#51068' '#51217#51060#49885' '#49324#51060#46300#48148' + '#49345#45800' MDI '#53485' '#49884#49828#53596
  Color = clAppWorkSpace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #44404#47548
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
    Height = 435
  end
  object PanelTopTabs: TPanel
    Left = 0
    Top = 0
    Width = 934
    Height = 32
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object TabControlForms: TTabControl
      Left = 0
      Top = 0
      Width = 934
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
    Height = 435
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
      TabOrder = 0
      object LabelSidebarTitle: TLabel
        Left = 10
        Top = 11
        Width = 142
        Height = 12
        Caption = '[ERP '#47700#45684' '#45348#48708#44172#51060#53552']'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #44404#47548
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
        Font.Name = #44404#47548
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
      Height = 398
      Align = alClient
      Indent = 19
      ReadOnly = True
      TabOrder = 1
      OnDblClick = TreeViewSidebarDblClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 467
    Width = 934
    Height = 20
    Panels = <
      item
        Text = 'ERP '#50937' '#49828#53440#51068' '#51217#51060#49885' '#49324#51060#46300#48148' '#49884#49828#53596' '#51456#48708' '#50756#47308
        Width = 350
      end
      item
        Text = #50676#47536' '#53485': 0'#44060
        Width = 200
      end>
  end
  object MainMenu1: TMainMenu
    Left = 240
    Top = 60
    object MenuSystem: TMenuItem
      Caption = #49884#49828#53596' '#44288#47532'(&S)'
      object MenuUserList: TMenuItem
        Caption = #49324#50857#51088' '#47785#47197' '#51312#54924'(&U)'
        OnClick = MenuUserListClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object MenuExit: TMenuItem
        Caption = #51333#47308'(&X)'
        OnClick = MenuExitClick
      end
    end
    object MenuSales: TMenuItem
      Caption = #50689#50629' '#44288#47532'(&M)'
      object MenuSalesOrder: TMenuItem
        Caption = #50689#50629' '#51452#47928' '#46321#47197'(&O)'
        OnClick = MenuSalesOrderClick
      end
    end
    object MenuStock: TMenuItem
      Caption = #51116#44256' '#44288#47532'(&I)'
      object MenuStockItem: TMenuItem
        Caption = #54408#47785' '#51116#44256' '#54788#54889'(&I)'
        OnClick = MenuStockItemClick
      end
    end
    object MenuWindow: TMenuItem
      Caption = #52285' '#44288#47532'(&W)'
      object MenuCloseCurrent: TMenuItem
        Caption = #54788#51116' '#53485' '#45803#44592'(&C)'
        OnClick = MenuCloseCurrentClick
      end
      object MenuCloseAll: TMenuItem
        Caption = #47784#46304' '#53485' '#45803#44592'(&A)'
        OnClick = MenuCloseAllClick
      end
    end
  end
end
