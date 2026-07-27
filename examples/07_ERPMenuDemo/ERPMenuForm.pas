unit ERPMenuForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, StdCtrls, ExtCtrls;

type
  TFormERPMenu = class(TForm)
    MainMenu1: TMainMenu;
    MenuSystem: TMenuItem;
    MenuUserMgmt: TMenuItem;
    MenuAuthMgmt: TMenuItem;
    N1: TMenuItem;
    MenuExit: TMenuItem;
    MenuSales: TMenuItem;
    MenuOrderReg: TMenuItem;
    MenuSalesStatus: TMenuItem;
    MenuStock: TMenuItem;
    MenuInbound: TMenuItem;
    MenuStockStatus: TMenuItem;
    MenuHelp: TMenuItem;
    MenuAbout: TMenuItem;
    PopupMenu1: TPopupMenu;
    PopupRefresh: TMenuItem;
    PopupClearLog: TMenuItem;
    PanelLeft: TPanel;
    LabelTreeTitle: TLabel;
    TreeViewMenu: TTreeView;
    Splitter1: TSplitter;
    PanelMain: TPanel;
    LabelStatus: TLabel;
    MemoLog: TMemo;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure MenuUserMgmtClick(Sender: TObject);
    procedure MenuAuthMgmtClick(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
    procedure MenuOrderRegClick(Sender: TObject);
    procedure MenuSalesStatusClick(Sender: TObject);
    procedure MenuInboundClick(Sender: TObject);
    procedure MenuStockStatusClick(Sender: TObject);
    procedure MenuAboutClick(Sender: TObject);
    procedure PopupRefreshClick(Sender: TObject);
    procedure PopupClearLogClick(Sender: TObject);
    procedure TreeViewMenuDblClick(Sender: TObject);
  private
    procedure InitTreeMenu;
    procedure OpenMenu(const MenuPath: String);
  public
    { Public declarations }
  end;

var
  FormERPMenu: TFormERPMenu;

implementation

{$R *.dfm}

procedure TFormERPMenu.FormCreate(Sender: TObject);
begin
  Caption := 'ERP 시스템 메인 메뉴 구성 실습';
  MemoLog.Lines.Clear;
  MemoLog.Lines.Add('=== ERP 시스템 메인 메뉴가 초기화되었습니다. ===');
  MemoLog.Lines.Add('상단 메뉴바 또는 좌측 트리뷰 메뉴를 클릭해 보세요.');

  InitTreeMenu;
end;

// 좌측 트리뷰 메뉴 초기화 생성
procedure TFormERPMenu.InitTreeMenu;
var
  NodeSystem, NodeSales, NodeStock: TTreeNode;
begin
  TreeViewMenu.Items.Clear;

  // 1. 시스템 관리 노드
  NodeSystem := TreeViewMenu.Items.Add(nil, '1. 시스템 관리');
  TreeViewMenu.Items.AddChild(NodeSystem, '사용자 관리');
  TreeViewMenu.Items.AddChild(NodeSystem, '권한 설정');

  // 2. 영업 관리 노드
  NodeSales := TreeViewMenu.Items.Add(nil, '2. 영업 관리');
  TreeViewMenu.Items.AddChild(NodeSales, '주문 등록');
  TreeViewMenu.Items.AddChild(NodeSales, '매출 현황');

  // 3. 재고 관리 노드
  NodeStock := TreeViewMenu.Items.Add(nil, '3. 재고 관리');
  TreeViewMenu.Items.AddChild(NodeStock, '입고 관리');
  TreeViewMenu.Items.AddChild(NodeStock, '재고 현황');

  // 전체 트리 펴기 (Expand)
  TreeViewMenu.FullExpand;
end;

// 메뉴 실행 헬퍼 프로시저
procedure TFormERPMenu.OpenMenu(const MenuPath: String);
var
  LogMsg: String;
begin
  LogMsg := '[' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + '] ' + MenuPath + ' 메뉴를 열었습니다.';
  LabelStatus.Caption := '현재 선택된 메뉴: ' + MenuPath;
  MemoLog.Lines.Add(LogMsg);
  StatusBar1.Panels[0].Text := '실행 중: ' + MenuPath;
end;

// 1. 상단 메인 메뉴 이벤트들
procedure TFormERPMenu.MenuUserMgmtClick(Sender: TObject);
begin
  OpenMenu('시스템 관리 > 사용자 관리');
end;

procedure TFormERPMenu.MenuAuthMgmtClick(Sender: TObject);
begin
  OpenMenu('시스템 관리 > 권한 설정');
end;

procedure TFormERPMenu.MenuOrderRegClick(Sender: TObject);
begin
  OpenMenu('영업 관리 > 주문 등록');
end;

procedure TFormERPMenu.MenuSalesStatusClick(Sender: TObject);
begin
  OpenMenu('영업 관리 > 매출 현황');
end;

procedure TFormERPMenu.MenuInboundClick(Sender: TObject);
begin
  OpenMenu('재고 관리 > 입고 관리');
end;

procedure TFormERPMenu.MenuStockStatusClick(Sender: TObject);
begin
  OpenMenu('재고 관리 > 재고 현황');
end;

procedure TFormERPMenu.MenuAboutClick(Sender: TObject);
begin
  ShowMessage('Delphi 7 ERP 메인 메뉴 실습 프로그램 v1.0');
end;

procedure TFormERPMenu.MenuExitClick(Sender: TObject);
begin
  Close;
end;

// 2. 우클릭 팝업 메뉴 이벤트들
procedure TFormERPMenu.PopupRefreshClick(Sender: TObject);
begin
  InitTreeMenu;
  MemoLog.Lines.Add('-> 메뉴가 새로고침되었습니다.');
end;

procedure TFormERPMenu.PopupClearLogClick(Sender: TObject);
begin
  MemoLog.Clear;
  MemoLog.Lines.Add('=== 로그 창이 초기화되었습니다. ===');
end;

// 3. 트리뷰 메뉴 더블클릭 이벤트
procedure TFormERPMenu.TreeViewMenuDblClick(Sender: TObject);
var
  SelectedNode: TTreeNode;
begin
  SelectedNode := TreeViewMenu.Selected;
  if (SelectedNode <> nil) and (SelectedNode.Parent <> nil) then
  begin
    OpenMenu(SelectedNode.Parent.Text + ' > ' + SelectedNode.Text);
  end;
end;

end.
