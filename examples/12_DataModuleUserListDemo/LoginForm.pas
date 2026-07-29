unit LoginForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB, DataModule;

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
    ADOQueryLogin: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure BtnLoginClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnDBConfigClick(Sender: TObject);
    procedure EditUserPWKeyPress(Sender: TObject; var Key: Char);
  private
    FLoggedInUserID: string;
    FLoggedInUserName: string;
    FLoggedInUserRole: string;
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
  Caption := '시스템 로그인 (DataModule 커넥션 공유)';
  Position := poScreenCenter;
  BorderStyle := bsSingle;
  BorderIcons := [biSystemMenu, biMinimize];

  EditUserPW.PasswordChar := '*';
  LabelStatus.Caption := '공통 DataModule 커넥션을 통해 로그인합니다.';
  LabelStatus.Font.Color := clGray;

  EditUserID.Text := 'admin';
  EditUserPW.Text := 'admin123!';
end;

function TFormLogin.AuthenticateUser(const AUserID, AUserPW: string): Boolean;
begin
  Result := False;

  // 전역 DataModuleMain의 공통 DB 커넥션 사용!
  if not DataModuleMain.ConnectDB then Exit;

  try
    ADOQueryLogin.Close;
    // [핵심] DataModuleMain의 ADOConnection1 재활용!
    ADOQueryLogin.Connection := DataModuleMain.ADOConnection1;
    ADOQueryLogin.SQL.Clear;
    ADOQueryLogin.SQL.Add('SELECT User_ID, User_Name, User_Role, Is_Active');
    ADOQueryLogin.SQL.Add('FROM USERS');
    ADOQueryLogin.SQL.Add('WHERE User_ID = :UserID AND Password = :Password');

    ADOQueryLogin.Parameters.ParamByName('UserID').Value := AUserID;
    ADOQueryLogin.Parameters.ParamByName('Password').Value := AUserPW;

    ADOQueryLogin.Open;

    if ADOQueryLogin.IsEmpty then
    begin
      LabelStatus.Caption := '아이디 또는 비밀번호가 일치하지 않습니다.';
      LabelStatus.Font.Color := clRed;
      MessageDlg('로그인 실패: 아이디 또는 비밀번호를 확인하세요.', mtWarning, [mbOK], 0);
      EditUserPW.SetFocus;
      EditUserPW.SelectAll;
    end
    else
    begin
      if ADOQueryLogin.FieldByName('Is_Active').AsString <> 'Y' then
      begin
        LabelStatus.Caption := '비활성화된 계정입니다.';
        LabelStatus.Font.Color := clRed;
        MessageDlg('해당 계정은 사용이 정지되었습니다.', mtError, [mbOK], 0);
        Exit;
      end;

      FLoggedInUserID := ADOQueryLogin.FieldByName('User_ID').AsString;
      FLoggedInUserName := ADOQueryLogin.FieldByName('User_Name').AsString;
      FLoggedInUserRole := ADOQueryLogin.FieldByName('User_Role').AsString;

      LabelStatus.Caption := '로그인 성공!';
      LabelStatus.Font.Color := clGreen;
      Result := True;
    end;
  except
    on E: Exception do
    begin
      LabelStatus.Caption := '로그인 처리 중 오류 발생';
      LabelStatus.Font.Color := clRed;
      MessageDlg('로그인 검증 오류: ' + E.Message, mtError, [mbOK], 0);
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

  if AuthenticateUser(UserID, UserPW) then
    ModalResult := mrOk;
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
  NewConnStr := PromptDataSource(Handle, DataModuleMain.ADOConnection1.ConnectionString);
  if NewConnStr <> '' then
  begin
    if DataModuleMain.ADOConnection1.Connected then
      DataModuleMain.ADOConnection1.Close;
    DataModuleMain.ADOConnection1.ConnectionString := NewConnStr;
    DataModuleMain.SaveConfigToIni(NewConnStr);
    ShowMessage('DB 연결 설정이 변경되고 dbconfig.ini에 저장되었습니다.');
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
