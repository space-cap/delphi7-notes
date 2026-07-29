unit LoginForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB, IniFiles;

type
  TFormLogin = class(TForm)
    PanelHeader: TPanel;
    LabelTitle: TLabel;
    LabelSubtitle: TLabel;
    LabelUserID: TLabel;
    LabelUserPW: TLabel;
    EditUserID: TEdit;
    EditUserPW: TEdit;
    BtnLogin: TButton;
    BtnCancel: TButton;
    BtnDBConfig: TButton;
    LabelStatus: TLabel;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure BtnLoginClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnDBConfigClick(Sender: TObject);
    procedure EditUserPWKeyPress(Sender: TObject; var Key: Char);
  private
    FLoggedInUserID: string;
    FLoggedInUserName: string;
    FLoggedInUserRole: string;
    FIniFilePath: string;
    procedure LoadDBConfigFromIni;
    procedure SaveDBConfigToIni(const AConnStr: string);
    function ConnectToDatabase: Boolean;
    function AuthenticateUser(const AUserID, AUserPW: string): Boolean;
  public
    property LoggedInUserID: string read FLoggedInUserID;
    property LoggedInUserName: string read FLoggedInUserName;
    property LoggedInUserRole: string read FLoggedInUserRole;
  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.dfm}

procedure TFormLogin.FormCreate(Sender: TObject);
begin
  Caption := '시스템 로그인';
  Position := poScreenCenter;
  BorderStyle := bsSingle;
  BorderIcons := [biSystemMenu, biMinimize];

  // 비밀번호 입력란 마스킹 처리
  EditUserPW.PasswordChar := '*';
  LabelStatus.Caption := '아이디와 비밀번호를 입력하고 로그인하세요.';
  LabelStatus.Font.Color := clGray;

  // 기본 테스트 계정 셋팅
  EditUserID.Text := 'admin';
  EditUserPW.Text := 'admin123!';

  // 실행 파일 위치의 dbconfig.ini 경로 설정
  FIniFilePath := ExtractFilePath(Application.ExeName) + 'dbconfig.ini';

  // 소스 코드 내 하드코딩 제거! 외부 INI 파일에서 DB 접속 정보 동적 로딩
  LoadDBConfigFromIni;
end;

procedure TFormLogin.LoadDBConfigFromIni;
var
  Ini: TIniFile;
  TemplatePath, Provider, Server, Database, UserID, Password, ConnStr: string;
begin
  ADOConnection1.LoginPrompt := False;

  // dbconfig.ini가 없는 경우 template 파일이 있으면 기본 템플릿 생성
  if not FileExists(FIniFilePath) then
  begin
    TemplatePath := ExtractFilePath(Application.ExeName) + 'dbconfig.ini.template';
    if FileExists(TemplatePath) then
      CopyFile(PChar(TemplatePath), PChar(FIniFilePath), True);
  end;

  if FileExists(FIniFilePath) then
  begin
    Ini := TIniFile.Create(FIniFilePath);
    try
      Provider := Ini.ReadString('DATABASE', 'Provider', 'SQLOLEDB.1');
      Server   := Ini.ReadString('DATABASE', 'Server', '127.0.0.1');
      Database := Ini.ReadString('DATABASE', 'Database', 'TestDB');
      UserID   := Ini.ReadString('DATABASE', 'UserID', '');
      Password := Ini.ReadString('DATABASE', 'Password', '');

      ConnStr := Format('Provider=%s;Data Source=%s;Initial Catalog=%s;User ID=%s;Password=%s;',
        [Provider, Server, Database, UserID, Password]);

      ADOConnection1.ConnectionString := ConnStr;
    finally
      Ini.Free;
    end;
  end;
end;

procedure TFormLogin.SaveDBConfigToIni(const AConnStr: string);
var
  Ini: TIniFile;
begin
  // 커넥션 스트링 설정 변경 시 INI 파일에 기록
  Ini := TIniFile.Create(FIniFilePath);
  try
    Ini.WriteString('DATABASE', 'ConnectionString', AConnStr);
  finally
    Ini.Free;
  end;
end;

function TFormLogin.ConnectToDatabase: Boolean;
begin
  Result := False;
  try
    if not ADOConnection1.Connected then
    begin
      if Trim(ADOConnection1.ConnectionString) = '' then
      begin
        ShowMessage('DB 연결 설정이 없습니다. [DB 설정] 버튼으로 dbconfig.ini 및 접속 정보를 설정하세요.');
        Exit;
      end;
      ADOConnection1.Connected := True;
    end;
    Result := ADOConnection1.Connected;
  except
    on E: Exception do
    begin
      LabelStatus.Caption := 'DB 접속 실패: ' + E.Message;
      LabelStatus.Font.Color := clRed;
      MessageDlg('데이터베이스 접속 중 오류가 발생했습니다:' + #13#10 +
        'dbconfig.ini 파일 설정 및 네트워크 상태를 확인하세요.' + #13#10 + #13#10 + E.Message,
        mtError, [mbOK], 0);
    end;
  end;
end;

function TFormLogin.AuthenticateUser(const AUserID, AUserPW: string): Boolean;
begin
  Result := False;

  if not ConnectToDatabase then Exit;

  try
    ADOQuery1.Close;
    ADOQuery1.Connection := ADOConnection1;
    ADOQuery1.SQL.Clear;

    // 파라미터화 쿼리 사용 (SQL Injection 예방 필수!)
    ADOQuery1.SQL.Add('SELECT User_ID, User_Name, User_Role, Is_Active');
    ADOQuery1.SQL.Add('FROM USERS');
    ADOQuery1.SQL.Add('WHERE User_ID = :UserID AND Password = :Password');

    // 파라미터 값 바인딩
    ADOQuery1.Parameters.ParamByName('UserID').Value := AUserID;
    ADOQuery1.Parameters.ParamByName('Password').Value := AUserPW;

    ADOQuery1.Open;

    if ADOQuery1.IsEmpty then
    begin
      LabelStatus.Caption := '아이디 또는 비밀번호가 일치하지 않습니다.';
      LabelStatus.Font.Color := clRed;
      MessageDlg('로그인 실패: 아이디 또는 비밀번호를 확인하세요.', mtWarning, [mbOK], 0);
      EditUserPW.SetFocus;
      EditUserPW.SelectAll;
    end
    else
    begin
      // 계정 활성화 상태 체크
      if ADOQuery1.FieldByName('Is_Active').AsString <> 'Y' then
      begin
        LabelStatus.Caption := '비활성화된 계정입니다. 관리자에게 문의하세요.';
        LabelStatus.Font.Color := clRed;
        MessageDlg('해당 계정은 사용이 정지되었습니다.', mtError, [mbOK], 0);
        Exit;
      end;

      // 로그인 사용자 정보 저장
      FLoggedInUserID := ADOQuery1.FieldByName('User_ID').AsString;
      FLoggedInUserName := ADOQuery1.FieldByName('User_Name').AsString;
      FLoggedInUserRole := ADOQuery1.FieldByName('User_Role').AsString;

      LabelStatus.Caption := '로그인 성공!';
      LabelStatus.Font.Color := clGreen;
      Result := True;
    end;
  except
    on E: Exception do
    begin
      LabelStatus.Caption := '로그인 처리 중 DB 오류 발생';
      LabelStatus.Font.Color := clRed;
      MessageDlg('로그인 조회 중 오류가 발생했습니다:' + #13#10 + E.Message, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TFormLogin.BtnLoginClick(Sender: TObject);
var
  UserID, UserPW: string;
begin
  UserID := Trim(EditUserID.Text);
  UserPW := Trim(EditUserPW.Text);

  if UserID = '' then
  begin
    ShowMessage('아이디를 입력해 주세요.');
    EditUserID.SetFocus;
    Exit;
  end;

  if UserPW = '' then
  begin
    ShowMessage('비밀번호를 입력해 주세요.');
    EditUserPW.SetFocus;
    Exit;
  end;

  // DB 아이디, 비번 검증
  if AuthenticateUser(UserID, UserPW) then
  begin
    ModalResult := mrOk; // 모달 결과 OK 반환하여 메인 화면으로 이동
  end;
end;

procedure TFormLogin.BtnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TFormLogin.BtnDBConfigClick(Sender: TObject);
var
  NewConnStr: string;
begin
  NewConnStr := PromptDataSource(Handle, ADOConnection1.ConnectionString);
  if NewConnStr <> '' then
  begin
    if ADOConnection1.Connected then
      ADOConnection1.Close;
    ADOConnection1.ConnectionString := NewConnStr;
    SaveDBConfigToIni(NewConnStr);
    ShowMessage('DB 연결 정보가 성공적으로 변경되어 dbconfig.ini에 저장되었습니다.');
  end;
end;

procedure TFormLogin.EditUserPWKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    BtnLoginClick(BtnLogin);
  end;
end;

end.
