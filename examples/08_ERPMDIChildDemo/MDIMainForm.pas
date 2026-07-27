unit MDIMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls;

type
  TFormMDIMain = class(TForm)
    MainMenu1: TMainMenu;
    MenuSystem: TMenuItem;
    MenuUserMgmt: TMenuItem;
    N1: TMenuItem;
    MenuExit: TMenuItem;
    MenuSales: TMenuItem;
    MenuOrderReg: TMenuItem;
    MenuWindow: TMenuItem;
    MenuCascade: TMenuItem;
    MenuTile: TMenuItem;
    MenuCloseAll: TMenuItem;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure MenuUserMgmtClick(Sender: TObject);
    procedure MenuOrderRegClick(Sender: TObject);
    procedure MenuCascadeClick(Sender: TObject);
    procedure MenuTileClick(Sender: TObject);
    procedure MenuCloseAllClick(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
  private
    function OpenChildForm(FormClass: TFormClass): TForm;
    procedure UpdateStatusBar;
  public
    procedure ChildFormClosed;
  end;

var
  FormMDIMain: TFormMDIMain;

implementation

uses UserMgmtForm, OrderRegForm;

{$R *.dfm}

procedure TFormMDIMain.FormCreate(Sender: TObject);
begin
  Caption := '진짜 ERP 시스템 MDI 메인 화면 (FormStyle = fsMDIForm)';
  UpdateStatusBar;
end;

// MDI 열린 창 상태바 업데이트
procedure TFormMDIMain.UpdateStatusBar;
begin
  StatusBar1.Panels[1].Text := '열린 자식 창: ' + IntToStr(MDIChildCount) + '개';
end;

// 실무 ERP 핵심 폼 오픈 패턴!
// 이미 창이 열려있으면 앞으로 가져오고(BringToFront), 없으면 새로 생성(Create)!
function TFormMDIMain.OpenChildForm(FormClass: TFormClass): TForm;
var
  I: Integer;
begin
  // 1. 이미 열려있는 MDI Child 창 중에서 동일한 클래스가 있는지 검색
  for I := 0 to MDIChildCount - 1 do
  begin
    if MDIChildren[I] is FormClass then
    begin
      Result := MDIChildren[I];
      Result.BringToFront; // 이미 있으면 맨 앞으로 가져오기!
      Exit;
    end;
  end;

  // 2. 열려있는 창이 없으면 새로 생성 (MDI Child 폼으로 띄우기)
  Result := FormClass.Create(Application);
  UpdateStatusBar;
end;

procedure TFormMDIMain.ChildFormClosed;
begin
  UpdateStatusBar;
end;

// 1. 사용자 관리 창 열기
procedure TFormMDIMain.MenuUserMgmtClick(Sender: TObject);
begin
  OpenChildForm(TFormUserMgmt);
end;

// 2. 주문 등록 창 열기
procedure TFormMDIMain.MenuOrderRegClick(Sender: TObject);
begin
  OpenChildForm(TFormOrderReg);
end;

// 3. 창 계단식 정렬
procedure TFormMDIMain.MenuCascadeClick(Sender: TObject);
begin
  Cascade;
end;

// 4. 창 바둑판 정렬
procedure TFormMDIMain.MenuTileClick(Sender: TObject);
begin
  Tile;
end;

// 5. 열린 자식 창 모두 닫기
procedure TFormMDIMain.MenuCloseAllClick(Sender: TObject);
var
  I: Integer;
begin
  for I := MDIChildCount - 1 downto 0 do
  begin
    MDIChildren[I].Close;
  end;
  UpdateStatusBar;
end;

procedure TFormMDIMain.MenuExitClick(Sender: TObject);
begin
  Close;
end;

end.
