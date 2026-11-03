program DataModuleDemoApp;

uses
  Forms,
  Controls,
  DataModule in 'DataModule.pas' {DataModuleMain: TDataModule},
  LoginForm in 'LoginForm.pas' {FormLogin},
  MainForm in 'MainForm.pas' {FormMain},
  UserListForm in 'UserListForm.pas' {FormUserList},
  DataModuleStock in 'DataModuleStock.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'DataModule DB 커넥션 공유 및 유저 목록 데모';

  // 1. 전역 DataModule 먼저 생성 (DB 커넥션 관리)
  Application.CreateForm(TDataModuleMain, DataModuleMain);
  Application.CreateForm(TDataModule1, DataModule1);
  // 2. 로그인 폼 모달 실행 (DataModule의 커넥션 공유)
  FormLogin := TFormLogin.Create(nil);
  try
    if FormLogin.ShowModal = mrOk then
    begin
      // 로그인 성공 시 메인 화면 띄우기
      Application.CreateForm(TFormMain, FormMain);
      FormMain.SetUserInfo(
        FormLogin.LoggedInUserID,
        FormLogin.LoggedInUserName,
        FormLogin.LoggedInUserRole
      );
      FormLogin.Free;
      Application.Run;
    end
    else
    begin
      FormLogin.Free;
      Application.Terminate;
    end;
  except
    FormLogin.Free;
    raise;
  end;
end.
