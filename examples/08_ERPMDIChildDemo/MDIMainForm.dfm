object FormMDIMain: TFormMDIMain
  Left = 682
  Top = 160
  Width = 692
  Height = 600
  Caption = #51652#51676' ERP '#49884#49828#53596' MDI '#47700#51064' '#54868#47732
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 521
    Width = 676
    Height = 20
    Panels = <
      item
        Text = 'ERP MDI '#49884#49828#53596' '#51089#46041' '#51473
        Width = 250
      end
      item
        Text = #50676#47536' '#51088#49885' '#52285': 0'#44060
        Width = 200
      end>
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 40
    object MenuSystem: TMenuItem
      Caption = #49884#49828#53596' '#44288#47532'(&S)'
      object MenuUserMgmt: TMenuItem
        Caption = #49324#50857#51088' '#44288#47532' '#52285' '#50676#44592'(&U)'
        OnClick = MenuUserMgmtClick
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
      object MenuOrderReg: TMenuItem
        Caption = #51452#47928' '#46321#47197' '#52285' '#50676#44592'(&O)'
        OnClick = MenuOrderRegClick
      end
    end
    object MenuWindow: TMenuItem
      Caption = #52285' '#44288#47532'(&W)'
      object MenuCascade: TMenuItem
        Caption = #44228#45800#49885' '#51221#47148'(&C)'
        OnClick = MenuCascadeClick
      end
      object MenuTile: TMenuItem
        Caption = #48148#46161#54032' '#51221#47148'(&T)'
        OnClick = MenuTileClick
      end
      object MenuCloseAll: TMenuItem
        Caption = #50676#47536' '#52285' '#47784#46160' '#45803#44592'(&A)'
        OnClick = MenuCloseAllClick
      end
    end
  end
end
