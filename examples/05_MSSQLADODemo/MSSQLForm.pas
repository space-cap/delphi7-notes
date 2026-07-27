unit MSSQLForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls;

type
  TFormMSSQL = class(TForm)
    LabelServer: TLabel;
    EditServer: TEdit;
    LabelDB: TLabel;
    EditDB: TEdit;
    LabelUser: TLabel;
    EditUser: TEdit;
    BtnConnect: TButton;
    DBGrid1: TDBGrid;
    MemoLog: TMemo;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure BtnConnectClick(Sender: TObject);
  private
    function BuildConnectionString: String;
  public
    { Public declarations }
  end;

var
  FormMSSQL: TFormMSSQL;

implementation

{$R *.dfm}

procedure TFormMSSQL.FormCreate(Sender: TObject);
begin
  Caption := 'Delphi 7 MS-SQL ADO DB 접속 실습';
  MemoLog.Lines.Clear;
  MemoLog.Lines.Add('=== MS-SQL ADO DB 접속 준비 완료 ===');
  MemoLog.Lines.Add('서버 정보를 입력하고 [DB 연결 & 조회] 버튼을 누르세요.');

  // DataSource와 DBGrid 연결
  DataSource1.DataSet := ADOQuery1;
  DBGrid1.DataSource := DataSource1;
end;

// MS-SQL OLE DB Provider 커넥션 스트링 생성 함수
function TFormMSSQL.BuildConnectionString: String;
var
  Server, DBName, UserID, PasswordStr: String;
begin
  Server := Trim(EditServer.Text);
  DBName := Trim(EditDB.Text);
  UserID := Trim(EditUser.Text);
  PasswordStr := 'pms'; // 실제 환경에 맞춰 비밀번호 변경 가능

  // SQLOLEDB (MS-SQL OLE DB Provider) 기본 커넥션 스트링 생성
  Result := 'Provider=SQLOLEDB.1;' +
            'Persist Security Info=False;' +
            'Data Source=' + Server + ';' +
            'Initial Catalog=' + DBName + ';' +
            'User ID=' + UserID + ';' +
            'Password=' + PasswordStr + ';';
end;

procedure TFormMSSQL.BtnConnectClick(Sender: TObject);
begin
  MemoLog.Lines.Add('----------------------------------------');
  MemoLog.Lines.Add('MS-SQL DB 연결을 시도합니다...');

  try
    // 1. 기존 연결 해제
    if ADOConnection1.Connected then
      ADOConnection1.Close;

    // 2. 커넥션 스트링 설정 및 연결
    ADOConnection1.ConnectionString := BuildConnectionString;
    ADOConnection1.Connected := True;

    MemoLog.Lines.Add('-> DB 연결 성공! (Connected: True)');

    // 3. ADOQuery 실행 (TB_MEMBER 샘플 테이블 조회)
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    
    // init_test_db.sql 로 생성된 TB_MEMBER 회원 테이블 조회
    ADOQuery1.SQL.Text := 
      'SELECT MEMBER_ID AS [회원번호], MEMBER_NAME AS [이름], ' +
      '       EMAIL AS [이메일], AGE AS [나이], ' +
      '       CONVERT(VARCHAR(19), REG_DATE, 120) AS [가입일시] ' +
      'FROM TB_MEMBER ORDER BY MEMBER_ID ASC';

    ADOQuery1.Open;

    MemoLog.Lines.Add('-> 쿼리 조회 성공! (가져온 행 개수: ' + IntToStr(ADOQuery1.RecordCount) + '건)');

  except
    on E: Exception do
    begin
      MemoLog.Lines.Add('[DB 오류 발생]: ' + E.Message);
      ShowMessage('DB 연결 또는 쿼리 실행 실패:' + sLineBreak + E.Message);
    end;
  end;
end;

end.
