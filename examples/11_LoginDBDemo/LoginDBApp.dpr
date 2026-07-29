program LoginDBApp;

uses
  Forms,
  Controls,
  LoginForm in 'LoginForm.pas' {FormLogin},
  MainForm in 'MainForm.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '델파이 7 DB 로그인 시스템';

  // 1. 로그인 폼 생성 및 모달 띄우기
  FormLogin := TFormLogin.Create(nil);
  try
    if FormLogin.ShowModal = mrOk then
    begin
      // 로그인 성공 시 메인 폼 생성 및 실행
      Application.CreateForm(TFormMain, FormMain);

      // 로그인 사용자 정보를 메인 폼으로 전달
      FormMain.SetUserInfo(
        FormLogin.LoggedInUserID,
        FormLogin.LoggedInUserName,
        FormLogin.LoggedInUserRole
      );

      FormLogin.Free; // 로그인 폼 메모리 해제
      Application.Run;
    end
    else
    begin
      // 로그인 취소 또는 실패 시 프로그램 종료
      FormLogin.Free;
      Application.Terminate;
    end;
  except
    FormLogin.Free;
    raise;
  end;
end.
