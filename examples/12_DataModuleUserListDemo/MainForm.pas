unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UserListForm;

type
  TFormMain = class(TForm)
    PanelTop: TPanel;
    LabelWelcome: TLabel;
    LabelInfo: TLabel;
    BtnLogout: TButton;
    MemoMain: TMemo;
    PanelCenter: TPanel;
    BtnOpenUserList: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnLogoutClick(Sender: TObject);
    procedure BtnOpenUserListClick(Sender: TObject);
  private
    FUserID: string;
    FUserName: string;
    FUserRole: string;
  public
    procedure SetUserInfo(const AUserID, AUserName, AUserRole: string);
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Caption := '메인 시스템 화면 (DataModule 커넥션 공유 구조)';
  Position := poScreenCenter;
end;

procedure TFormMain.SetUserInfo(const AUserID, AUserName, AUserRole: string);
begin
  FUserID := AUserID;
  FUserName := AUserName;
  FUserRole := AUserRole;

  LabelWelcome.Caption := Format('%s(%s) 님 환영합니다!', [FUserName, FUserID]);
  LabelInfo.Caption := Format('접속 권한: [%s] | 로그인 시간: %s', [FUserRole, DateTimeToStr(Now)]);

  MemoMain.Lines.Clear;
  MemoMain.Lines.Add('===============================================');
  MemoMain.Lines.Add('  DataModule 전역 DB 커넥션 공유 시스템 접속 완료');
  MemoMain.Lines.Add('===============================================');
  MemoMain.Lines.Add('');
  MemoMain.Lines.Add('▶ 접속 사용자 아이디 : ' + FUserID);
  MemoMain.Lines.Add('▶ 접속 사용자 이름   : ' + FUserName);
  MemoMain.Lines.Add('▶ 계정 보유 권한     : ' + FUserRole);
  MemoMain.Lines.Add('');
  MemoMain.Lines.Add('아래 [사용자 목록 관리] 버튼을 누르면 DB 접속을 새로 하지 않고');
  MemoMain.Lines.Add('DataModule의 기존 DB 커넥션을 재활용하여 유저 리스트를 조회합니다.');
end;

procedure TFormMain.BtnOpenUserListClick(Sender: TObject);
var
  FormUserList: TFormUserList;
begin
  FormUserList := TFormUserList.Create(Self);
  try
    FormUserList.ShowModal;
  finally
    FormUserList.Free;
  end;
end;

procedure TFormMain.BtnLogoutClick(Sender: TObject);
begin
  if MessageDlg('로그아웃하고 프로그램을 종료하시겠습니까?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Close;
  end;
end;

end.
