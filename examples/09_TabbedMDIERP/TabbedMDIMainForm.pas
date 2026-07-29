unit TabbedMDIMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ExtCtrls, StdCtrls;

const
  WM_REFRESH_TABS = WM_USER + 101;
  FULL_SIDEBAR_WIDTH = 210;
  COLLAPSED_SIDEBAR_WIDTH = 38;

type
  TFormTabbedMDIMain = class(TForm)
    MainMenu1: TMainMenu;
    MenuSystem: TMenuItem;
    MenuUserList: TMenuItem;
    N1: TMenuItem;
    MenuExit: TMenuItem;
    MenuSales: TMenuItem;
    MenuSalesOrder: TMenuItem;
    MenuStock: TMenuItem;
    MenuStockItem: TMenuItem;
    MenuWindow: TMenuItem;
    MenuCloseCurrent: TMenuItem;
    MenuCloseAll: TMenuItem;
    PanelTopTabs: TPanel;
    TabControlForms: TTabControl;
    PanelSidebar: TPanel;
    PanelSidebarHeader: TPanel;
    LabelSidebarTitle: TLabel;
    BtnToggleSidebar: TButton;
    TreeViewSidebar: TTreeView;
    SplitterLeft: TSplitter;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure MenuUserListClick(Sender: TObject);
    procedure MenuSalesOrderClick(Sender: TObject);
    procedure MenuStockItemClick(Sender: TObject);
    procedure MenuCloseCurrentClick(Sender: TObject);
    procedure MenuCloseAllClick(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
    procedure TreeViewSidebarDblClick(Sender: TObject);
    procedure TabControlFormsChange(Sender: TObject);
    procedure BtnToggleSidebarClick(Sender: TObject);
  private
    FIsSidebarCollapsed: Boolean;
    procedure InitSidebarMenu;
    procedure OpenChildForm(FormClass: TFormClass);
    procedure WMRefreshTabs(var Msg: TMessage); message WM_REFRESH_TABS;
    procedure SetSidebarCollapsed(const Collapse: Boolean);
  public
    procedure SyncTabsWithMDIChildren;
    procedure SetActiveTabForChild(ChildForm: TForm);
    procedure ChildClosedNotification;
  end;

var
  FormTabbedMDIMain: TFormTabbedMDIMain;

implementation

uses UserListForm, SalesOrderForm, StockItemForm;

{$R *.dfm}

procedure TFormTabbedMDIMain.FormCreate(Sender: TObject);
begin
  Caption := '모던 ERP - 웹 스타일 접이식 사이드바 + 상단 MDI 탭 시스템';
  FIsSidebarCollapsed := False;
  InitSidebarMenu;
  SyncTabsWithMDIChildren;
end;

// 좌측 사이드바 접기 / 펼치기 토글 로직!
procedure TFormTabbedMDIMain.SetSidebarCollapsed(const Collapse: Boolean);
var
  TargetWidth, I: Integer;
begin
  FIsSidebarCollapsed := Collapse;

  if Collapse then
  begin
    // 사이드바 접기 (Collapse)
    LabelSidebarTitle.Visible := False;
    TreeViewSidebar.Visible := False;
    SplitterLeft.Visible := False;
    
    // 슬라이딩 애니메이션 폼 처리
    TargetWidth := COLLAPSED_SIDEBAR_WIDTH;
    PanelSidebar.Width := TargetWidth;
    BtnToggleSidebar.Left := 4;
    BtnToggleSidebar.Caption := '>';
    StatusBar1.Panels[0].Text := '사이드바 접힘 (접이식 모드)';
  end
  else
  begin
    // 사이드바 펼치기 (Expand)
    PanelSidebar.Width := FULL_SIDEBAR_WIDTH;
    BtnToggleSidebar.Left := 172;
    BtnToggleSidebar.Caption := '<';
    LabelSidebarTitle.Visible := True;
    TreeViewSidebar.Visible := True;
    SplitterLeft.Visible := True;
    StatusBar1.Panels[0].Text := '사이드바 펼침 (전체 메뉴 모드)';
  end;
end;

procedure TFormTabbedMDIMain.BtnToggleSidebarClick(Sender: TObject);
begin
  SetSidebarCollapsed(not FIsSidebarCollapsed);
end;

// 좌측 사이드바 트리 메뉴 구성
procedure TFormTabbedMDIMain.InitSidebarMenu;
var
  NodeSystem, NodeSales, NodeStock: TTreeNode;
begin
  TreeViewSidebar.Items.Clear;

  NodeSystem := TreeViewSidebar.Items.Add(nil, '1. 시스템 관리');
  TreeViewSidebar.Items.AddChild(NodeSystem, '사용자 목록 조회');

  NodeSales := TreeViewSidebar.Items.Add(nil, '2. 영업 관리');
  TreeViewSidebar.Items.AddChild(NodeSales, '영업 주문 등록');

  NodeStock := TreeViewSidebar.Items.Add(nil, '3. 재고 관리');
  TreeViewSidebar.Items.AddChild(NodeStock, '품목 재고 현황');

  TreeViewSidebar.FullExpand;
end;

// -------------------------------------------------------------------
// MDI 탭 동기화 로직
// -------------------------------------------------------------------

procedure TFormTabbedMDIMain.WMRefreshTabs(var Msg: TMessage);
begin
  SyncTabsWithMDIChildren;
end;

procedure TFormTabbedMDIMain.ChildClosedNotification;
begin
  PostMessage(Handle, WM_REFRESH_TABS, 0, 0);
end;

procedure TFormTabbedMDIMain.SyncTabsWithMDIChildren;
var
  I: Integer;
begin
  TabControlForms.Tabs.Clear;

  for I := 0 to MDIChildCount - 1 do
  begin
    TabControlForms.Tabs.AddObject(MDIChildren[I].Caption, MDIChildren[I]);
  end;

  if ActiveMDIChild <> nil then
  begin
    for I := 0 to TabControlForms.Tabs.Count - 1 do
    begin
      if TabControlForms.Tabs.Objects[I] = ActiveMDIChild then
      begin
        TabControlForms.TabIndex := I;
        Break;
      end;
    end;
  end;

  StatusBar1.Panels[1].Text := '열린 탭: ' + IntToStr(MDIChildCount) + '개';
end;

procedure TFormTabbedMDIMain.SetActiveTabForChild(ChildForm: TForm);
var
  I: Integer;
begin
  for I := 0 to TabControlForms.Tabs.Count - 1 do
  begin
    if TabControlForms.Tabs.Objects[I] = ChildForm then
    begin
      TabControlForms.TabIndex := I;
      Break;
    end;
  end;
end;

procedure TFormTabbedMDIMain.TabControlFormsChange(Sender: TObject);
var
  TargetForm: TForm;
begin
  if (TabControlForms.TabIndex >= 0) and (TabControlForms.TabIndex < TabControlForms.Tabs.Count) then
  begin
    TargetForm := TForm(TabControlForms.Tabs.Objects[TabControlForms.TabIndex]);
    if TargetForm <> nil then
      TargetForm.BringToFront;
  end;
end;

procedure TFormTabbedMDIMain.OpenChildForm(FormClass: TFormClass);
var
  I: Integer;
  NewForm: TForm;
begin
  for I := 0 to MDIChildCount - 1 do
  begin
    if MDIChildren[I] is FormClass then
    begin
      MDIChildren[I].BringToFront;
      SetActiveTabForChild(MDIChildren[I]);
      Exit;
    end;
  end;

  NewForm := FormClass.Create(Application);
  SyncTabsWithMDIChildren;
end;

procedure TFormTabbedMDIMain.MenuUserListClick(Sender: TObject);
begin
  OpenChildForm(TFormUserList);
end;

procedure TFormTabbedMDIMain.MenuSalesOrderClick(Sender: TObject);
begin
  OpenChildForm(TFormSalesOrder);
end;

procedure TFormTabbedMDIMain.MenuStockItemClick(Sender: TObject);
begin
  OpenChildForm(TFormStockItem);
end;

procedure TFormTabbedMDIMain.TreeViewSidebarDblClick(Sender: TObject);
var
  SelectedNode: TTreeNode;
begin
  SelectedNode := TreeViewSidebar.Selected;
  if (SelectedNode <> nil) and (SelectedNode.Parent <> nil) then
  begin
    if SelectedNode.Text = '사용자 목록 조회' then OpenChildForm(TFormUserList)
    else if SelectedNode.Text = '영업 주문 등록' then OpenChildForm(TFormSalesOrder)
    else if SelectedNode.Text = '품목 재고 현황' then OpenChildForm(TFormStockItem);
  end;
end;

procedure TFormTabbedMDIMain.MenuCloseCurrentClick(Sender: TObject);
begin
  if ActiveMDIChild <> nil then
    ActiveMDIChild.Close;
end;

procedure TFormTabbedMDIMain.MenuCloseAllClick(Sender: TObject);
var
  I: Integer;
begin
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].Close;
  SyncTabsWithMDIChildren;
end;

procedure TFormTabbedMDIMain.MenuExitClick(Sender: TObject);
begin
  Close;
end;

end.
