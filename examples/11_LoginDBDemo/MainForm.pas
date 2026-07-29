unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormMain = class(TForm)
    PanelTop: TPanel;
    LabelWelcome: TLabel;
    LabelInfo: TLabel;
    MemoMain: TMemo;
    BtnLogout: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnLogoutClick(Sender: TObject);
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
  Caption := '메인 시스템 화면';
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
  MemoMain.Lines.Add('  데이터베이스 로그인 인증이 성공적으로 완료되었습니다.');
  MemoMain.Lines.Add('===============================================');
  MemoMain.Lines.Add('');
  MemoMain.Lines.Add('▶ 접속 사용자 아이디 : ' + FUserID);
  MemoMain.Lines.Add('▶ 접속 사용자 이름   : ' + FUserName);
  MemoMain.Lines.Add('▶ 계정 보유 권한     : ' + FUserRole);
  MemoMain.Lines.Add('');
  MemoMain.Lines.Add('※ 시스템 주요 기능을 이용하실 수 있습니다.');
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
