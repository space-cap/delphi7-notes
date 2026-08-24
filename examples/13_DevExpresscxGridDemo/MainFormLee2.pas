unit MainFormLee2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ComCtrls, StdCtrls, ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid;

type
  TfrmUserList = class(TForm)
    pnlTop: TPanel;
    lblSearch: TLabel;
    edtSearchName: TEdit;
    btnSearch: TButton;
    btnClear: TButton;
    btnExportExcel: TButton;
    statBar: TStatusBar;

    // ADO 컴포넌트
    ADOConnection1: TADOConnection;
    qryUsers: TADOQuery;
    dsUsers: TDataSource;
    tvUsers: TcxGridDBTableView;

    // QuantumGrid 컴포넌트
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    tvUsersuser_id: TcxGridDBColumn;
    tvUsersuser_name: TcxGridDBColumn;
    tvUsersdepartment: TcxGridDBColumn;
    tvUsersposition: TcxGridDBColumn;
    tvUsersemail: TcxGridDBColumn;
    tvUsersphone: TcxGridDBColumn;
    tvUsersis_active: TcxGridDBColumn;
    tvUserscreated_at: TcxGridDBColumn;

    // 이벤트 핸들러
    procedure btnSearchClick(Sender: TObject);



  private
    { Private declarations }
    procedure InitDBConnection;
    procedure ExecuteQuery(const ASearchName: string);

  public
    { Public declarations }
  end;

var
  frmUserList: TfrmUserList;

implementation

{$R *.dfm}

{-------------------------------------------------------------------------------
  2. ADOConnection 런타임 동적 연결 설정
-------------------------------------------------------------------------------}
procedure TfrmUserList.InitDBConnection;
const
  // 사용자 환경에 맞춘 연결 문자열
  CONN_STR = 'Provider=SQLOLEDB.1;' +
             'Data Source=localhost\SQLEXPRESS;' +
             'Initial Catalog=DELPHI7_DB;' +
             'User ID=sa;' +
             'Password=doolman;' +
             'Persist Security Info=True';
begin
  try
    ADOConnection1.Connected := False;
    ADOConnection1.LoginPrompt := False;
    ADOConnection1.ConnectionString := CONN_STR;
    ADOConnection1.Connected := True;
    
    statBar.SimpleText := 'DB 연결 성공: localhost\SQLEXPRESS (DELPHI7_DB)';
  except
    on E: Exception do
    begin
      statBar.SimpleText := 'DB 연결 실패: ' + E.Message;
      ShowMessage('데이터베이스 연결에 실패했습니다.'#13#10 +
                  '서버 주소와 계정 정보를 확인해주세요.'#13#10#13#10 + E.Message);
    end;
  end;
end;

{-------------------------------------------------------------------------------
  3. 사용자 목록 조회 쿼리 실행
-------------------------------------------------------------------------------}
procedure TfrmUserList.ExecuteQuery(const ASearchName: string);
begin
  if not ADOConnection1.Connected then
  begin
    ShowMessage('데이터베이스가 연결되어 있지 않습니다. 다시 연결을 시도합니다.');
    InitDBConnection;
    if not ADOConnection1.Connected then Exit;
  end;

  Screen.Cursor := crHourGlass;
  qryUsers.DisableControls;
  try
    qryUsers.Close;
    qryUsers.SQL.Clear;
    qryUsers.SQL.Add('SELECT user_id, user_name, department, position, ');
    qryUsers.SQL.Add('       email, phone, is_active, created_at ');
    qryUsers.SQL.Add('  FROM dbo.users ');
    
    // 조건 검색 (성명 키워드 검색 지원)
    if Trim(ASearchName) <> '' then
    begin
      qryUsers.SQL.Add(' WHERE user_name LIKE :SearchName ');
      qryUsers.Parameters.ParamByName('SearchName').Value := '%' + Trim(ASearchName) + '%';
    end;
    
    qryUsers.SQL.Add(' ORDER BY user_id ASC ');
    
    qryUsers.Open;
    
    // 상태바에 건수 업데이트
    statBar.SimpleText := Format('조회 완료: 총 %d건의 사용자 정보가 조회되었습니다.', [qryUsers.RecordCount]);
  finally
    qryUsers.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

{-------------------------------------------------------------------------------
  4. [사용자 조회] 버튼 클릭 이벤트
-------------------------------------------------------------------------------}
procedure TfrmUserList.btnSearchClick(Sender: TObject);
begin
  ExecuteQuery(edtSearchName.Text);
end;

end.
