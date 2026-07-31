unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB, IniFiles,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridLevel, cxGrid, cxTextEdit, cxCalendar,
  cxCheckBox, cxSpinEdit;

type
  TfrmMain = class(TForm)
    pnlTop: TPanel;
    lblTitle: TLabel;
    lblSearch: TLabel;
    edtSearchText: TEdit;
    btnSearch: TButton;
    btnAdd: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    btnViewDetail: TButton;

    pnlPaging: TPanel;
    btnPrevPage: TButton;
    btnNextPage: TButton;
    lblPageInfo: TLabel;
    lblPageSize: TLabel;
    cbPageSize: TComboBox;

    // ADO 컴포넌트
    ADOConnection1: TADOConnection;
    qryBoard: TADOQuery;
    dsBoard: TDataSource;

    // DevExpress cxGrid 컴포넌트
    cxGrid1: TcxGrid;
    cxGrid1Level1: TcxGridLevel;
    tvBoard: TcxGridDBTableView;
    tvBoardBoardID: TcxGridDBColumn;
    tvBoardIsNotice: TcxGridDBColumn;
    tvBoardTitle: TcxGridDBColumn;
    tvBoardWriterName: TcxGridDBColumn;
    tvBoardViewCount: TcxGridDBColumn;
    tvBoardRegDate: TcxGridDBColumn;

    procedure FormCreate(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnViewDetailClick(Sender: TObject);
    procedure btnPrevPageClick(Sender: TObject);
    procedure btnNextPageClick(Sender: TObject);
    procedure cbPageSizeChange(Sender: TObject);
    procedure tvBoardDblClick(Sender: TObject);
    procedure tvBoardCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure edtSearchTextKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FCurrentPage: Integer;
    FTotalPages: Integer;
    FTotalCount: Integer;
    function InitDatabaseConnection: Boolean;
    procedure LoadBoardData;
    procedure UpdatePagingUI;
    function GetPageSize: Integer;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses BoardEditForm;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FCurrentPage := 1;
  cbPageSize.ItemIndex := 0; // 기본 10개씩 보기

  // DB 연결 시도 (try-except 예외 안전 처리)
  if InitDatabaseConnection then
  begin
    // 연결 성공 시 데이터 자동 조회
    btnSearchClick(Self);
  end;
end;

function TfrmMain.InitDatabaseConnection: Boolean;
var
  IniFile: TIniFile;
  IniPath, Server, Port, Database, UserID, Password, Provider: string;
  UseSSPI: Boolean;
  DataSourceStr, ConnStr: string;
begin
  Result := False;
  IniPath := ExtractFilePath(Application.ExeName) + 'dbconfig.ini';

  // dbconfig.ini 파일이 존재하지 않는 경우 기본 템플릿 파일 생성
  if not FileExists(IniPath) then
  begin
    IniFile := TIniFile.Create(IniPath);
    try
      IniFile.WriteString('DATABASE', 'Provider', 'SQLOLEDB.1');
      IniFile.WriteString('DATABASE', 'Server', 'localhost\SQLEXPRESS');
      IniFile.WriteString('DATABASE', 'Port', '1433');
      IniFile.WriteString('DATABASE', 'Database', 'BBSDB');
      IniFile.WriteString('DATABASE', 'UserID', 'sa');
      IniFile.WriteString('DATABASE', 'Password', '');
      IniFile.WriteBool('DATABASE', 'IntegratedSecurity', False);
    finally
      IniFile.Free;
    end;
    ShowMessage('기본 dbconfig.ini 파일이 생성되었습니다.' + sLineBreak +
                '서버 및 로그인 정보를 수정한 후 사용해 주세요.' + sLineBreak +
                '경로: ' + IniPath);
  end;

  // INI 파일에서 DB 연결 정보 읽기
  IniFile := TIniFile.Create(IniPath);
  try
    Provider := IniFile.ReadString('DATABASE', 'Provider', 'SQLOLEDB.1');
    Server   := IniFile.ReadString('DATABASE', 'Server', 'localhost\SQLEXPRESS');
    Port     := IniFile.ReadString('DATABASE', 'Port', '1433');
    Database := IniFile.ReadString('DATABASE', 'Database', 'BBSDB');
    UserID   := IniFile.ReadString('DATABASE', 'UserID', 'sa');
    Password := IniFile.ReadString('DATABASE', 'Password', '');
    UseSSPI  := IniFile.ReadBool('DATABASE', 'IntegratedSecurity', False);
  finally
    IniFile.Free;
  end;

  // DataSource 스마트 조립 (인스턴스명 지원)
  if Pos('\', Server) > 0 then
    DataSourceStr := Server
  else if (Port <> '') and (Port <> '1433') then
    DataSourceStr := Server + ',' + Port
  else
    DataSourceStr := Server;

  // ConnectionString 구성
  if UseSSPI then
  begin
    ConnStr := Format('Provider=%s;Integrated Security=SSPI;Initial Catalog=%s;Data Source=%s;',
                      [Provider, Database, DataSourceStr]);
  end
  else
  begin
    ConnStr := Format('Provider=%s;Persist Security Info=True;User ID=%s;Password=%s;Initial Catalog=%s;Data Source=%s;',
                      [Provider, UserID, Password, Database, DataSourceStr]);
  end;

  // DB 연결 시도 (try-except 예외 안전 처리)
  try
    ADOConnection1.Close;
    ADOConnection1.ConnectionString := ConnStr;
    ADOConnection1.Connected := True;
    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      lblPageInfo.Caption := 'DB 연결 실패 (dbconfig.ini 확인 필요)';
      ShowMessage('[DB 연결 실패]' + sLineBreak +
                  'dbconfig.ini 설정 또는 SQL Server 구동 상태를 확인해 주세요.' + sLineBreak + sLineBreak +
                  '오류 메세지: ' + E.Message);
    end;
  end;
end;

function TfrmMain.GetPageSize: Integer;
begin
  case cbPageSize.ItemIndex of
    0: Result := 10;
    1: Result := 20;
    2: Result := 50;
  else
    Result := 10;
  end;
end;

procedure TfrmMain.LoadBoardData;
var
  PageSize, StartRow, EndRow: Integer;
  SearchKeyword: string;
  CountQuery: TADOQuery;
begin
  // DB 연결 상태 확인
  if not ADOConnection1.Connected then
  begin
    ShowMessage('DB가 연결되어 있지 않습니다.' + sLineBreak + 'dbconfig.ini 설정 후 [조회] 버튼을 눌러주세요.');
    Exit;
  end;

  PageSize := GetPageSize;
  SearchKeyword := Trim(edtSearchText.Text);

  // 1. 전체 데이터 건수 조회 (총 페이지 수 계산용)
  CountQuery := TADOQuery.Create(Self);
  try
    CountQuery.Connection := ADOConnection1;
    if SearchKeyword <> '' then
    begin
      CountQuery.SQL.Text :=
        'SELECT COUNT(*) AS TotalCnt FROM dbo.TB_BOARD ' +
        'WHERE (Title LIKE ''%'' + :Search1 + ''%'' OR WriterName LIKE ''%'' + :Search2 + ''%'')';
      CountQuery.Parameters.ParamByName('Search1').Value := SearchKeyword;
      CountQuery.Parameters.ParamByName('Search2').Value := SearchKeyword;
    end
    else
    begin
      CountQuery.SQL.Text := 'SELECT COUNT(*) AS TotalCnt FROM dbo.TB_BOARD';
    end;
    
    try
      CountQuery.Open;
      FTotalCount := CountQuery.FieldByName('TotalCnt').AsInteger;
    except
      FTotalCount := 0;
    end;
  finally
    CountQuery.Free;
  end;

  // 총 페이지 수 계산
  if FTotalCount > 0 then
    FTotalPages := ((FTotalCount - 1) div PageSize) + 1
  else
    FTotalPages := 1;

  if FCurrentPage > FTotalPages then
    FCurrentPage := FTotalPages;
  if FCurrentPage < 1 then
    FCurrentPage := 1;

  // 페이징 행 범위 지정 (1-indexed)
  StartRow := ((FCurrentPage - 1) * PageSize) + 1;
  EndRow := FCurrentPage * PageSize;

  // 2. SQL Server CTE + ROW_NUMBER()를 활용한 서버 페이징 쿼리 실행
  qryBoard.Close;
  if SearchKeyword <> '' then
  begin
    qryBoard.SQL.Text :=
      'WITH PagedBoard AS (' +
      '  SELECT BoardID, Title, Content, WriterName, ViewCount, IsNotice, RegDate, ' +
      '         ROW_NUMBER() OVER (ORDER BY IsNotice DESC, BoardID DESC) AS RowNum ' +
      '  FROM dbo.TB_BOARD ' +
      '  WHERE (Title LIKE ''%'' + :Search1 + ''%'' OR WriterName LIKE ''%'' + :Search2 + ''%'') ' +
      ') ' +
      'SELECT BoardID, Title, Content, WriterName, ViewCount, IsNotice, RegDate ' +
      'FROM PagedBoard ' +
      'WHERE RowNum BETWEEN :StartRow AND :EndRow ' +
      'ORDER BY RowNum ASC';

    qryBoard.Parameters.ParamByName('Search1').Value := SearchKeyword;
    qryBoard.Parameters.ParamByName('Search2').Value := SearchKeyword;
    qryBoard.Parameters.ParamByName('StartRow').Value := StartRow;
    qryBoard.Parameters.ParamByName('EndRow').Value := EndRow;
  end
  else
  begin
    qryBoard.SQL.Text :=
      'WITH PagedBoard AS (' +
      '  SELECT BoardID, Title, Content, WriterName, ViewCount, IsNotice, RegDate, ' +
      '         ROW_NUMBER() OVER (ORDER BY IsNotice DESC, BoardID DESC) AS RowNum ' +
      '  FROM dbo.TB_BOARD ' +
      ') ' +
      'SELECT BoardID, Title, Content, WriterName, ViewCount, IsNotice, RegDate ' +
      'FROM PagedBoard ' +
      'WHERE RowNum BETWEEN :StartRow AND :EndRow ' +
      'ORDER BY RowNum ASC';

    qryBoard.Parameters.ParamByName('StartRow').Value := StartRow;
    qryBoard.Parameters.ParamByName('EndRow').Value := EndRow;
  end;

  try
    qryBoard.Open;
  except
    on E: Exception do
      ShowMessage('데이터 조회 중 오류가 발생했습니다:' + sLineBreak + E.Message);
  end;

  UpdatePagingUI;
end;

procedure TfrmMain.UpdatePagingUI;
begin
  lblPageInfo.Caption := Format('%d / %d 페이지 (총 %d건)', [FCurrentPage, FTotalPages, FTotalCount]);
  btnPrevPage.Enabled := (FCurrentPage > 1);
  btnNextPage.Enabled := (FCurrentPage < FTotalPages);
end;

procedure TfrmMain.edtSearchTextKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // 검색어 상자에서 엔터(VK_RETURN) 입력 시 조회 실행 및 경고음 방지
  if Key = VK_RETURN then
  begin
    Key := 0; // Windows 비프음(Beep) 방지
    btnSearchClick(Self);
  end;
end;

procedure TfrmMain.btnSearchClick(Sender: TObject);
begin
  if not ADOConnection1.Connected then
  begin
    if not InitDatabaseConnection then
      Exit;
  end;

  FCurrentPage := 1;
  LoadBoardData;
end;

procedure TfrmMain.btnPrevPageClick(Sender: TObject);
begin
  if FCurrentPage > 1 then
  begin
    Dec(FCurrentPage);
    LoadBoardData;
  end;
end;

procedure TfrmMain.btnNextPageClick(Sender: TObject);
begin
  if FCurrentPage < FTotalPages then
  begin
    Inc(FCurrentPage);
    LoadBoardData;
  end;
end;

procedure TfrmMain.cbPageSizeChange(Sender: TObject);
begin
  FCurrentPage := 1;
  LoadBoardData;
end;

procedure TfrmMain.btnAddClick(Sender: TObject);
var
  EditForm: TfrmBoardEdit;
begin
  if not ADOConnection1.Connected then
  begin
    ShowMessage('DB 연결이 필요합니다.');
    Exit;
  end;

  EditForm := TfrmBoardEdit.Create(Self);
  try
    EditForm.InitForm(bmInsert, 0, ADOConnection1);
    if EditForm.ShowModal = mrOk then
    begin
      ShowMessage('게시글이 등록되었습니다.');
      btnSearchClick(Self);
    end;
  finally
    EditForm.Free;
  end;
end;

procedure TfrmMain.btnEditClick(Sender: TObject);
var
  BoardID: Integer;
  EditForm: TfrmBoardEdit;
begin
  if not ADOConnection1.Connected or qryBoard.IsEmpty then
  begin
    ShowMessage('수정할 게시글을 선택하세요.');
    Exit;
  end;

  BoardID := qryBoard.FieldByName('BoardID').AsInteger;
  EditForm := TfrmBoardEdit.Create(Self);
  try
    EditForm.InitForm(bmEdit, BoardID, ADOConnection1);
    if EditForm.ShowModal = mrOk then
    begin
      ShowMessage('게시글이 수정되었습니다.');
      LoadBoardData;
    end;
  finally
    EditForm.Free;
  end;
end;

procedure TfrmMain.btnViewDetailClick(Sender: TObject);
var
  BoardID: Integer;
  EditForm: TfrmBoardEdit;
  UpdQuery: TADOQuery;
begin
  if not ADOConnection1.Connected or qryBoard.IsEmpty then
    Exit;

  BoardID := qryBoard.FieldByName('BoardID').AsInteger;

  // 1. 조회수 증가 쿼리 실행
  UpdQuery := TADOQuery.Create(Self);
  try
    UpdQuery.Connection := ADOConnection1;
    UpdQuery.SQL.Text := 'UPDATE dbo.TB_BOARD SET ViewCount = ViewCount + 1 WHERE BoardID = :ID';
    UpdQuery.Parameters.ParamByName('ID').Value := BoardID;
    try
      UpdQuery.ExecSQL;
    except
    end;
  finally
    UpdQuery.Free;
  end;

  // 2. 상세보기 모달 오픈
  EditForm := TfrmBoardEdit.Create(Self);
  try
    EditForm.InitForm(bmView, BoardID, ADOConnection1);
    EditForm.ShowModal;
    LoadBoardData;
  finally
    EditForm.Free;
  end;
end;

procedure TfrmMain.btnDeleteClick(Sender: TObject);
var
  BoardID: Integer;
  DelQuery: TADOQuery;
begin
  if not ADOConnection1.Connected or qryBoard.IsEmpty then
  begin
    ShowMessage('삭제할 게시글을 선택하세요.');
    Exit;
  end;

  BoardID := qryBoard.FieldByName('BoardID').AsInteger;

  if MessageDlg(Format('게시글 [%d번]을 정말 삭제하시겠습니까?', [BoardID]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DelQuery := TADOQuery.Create(Self);
    try
      DelQuery.Connection := ADOConnection1;
      DelQuery.SQL.Text := 'DELETE FROM dbo.TB_BOARD WHERE BoardID = :ID';
      DelQuery.Parameters.ParamByName('ID').Value := BoardID;
      DelQuery.ExecSQL;

      ShowMessage('성공적으로 삭제되었습니다.');
      LoadBoardData;
    finally
      DelQuery.Free;
    end;
  end;
end;

procedure TfrmMain.tvBoardDblClick(Sender: TObject);
begin
  btnViewDetailClick(Self);
end;

procedure TfrmMain.tvBoardCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
var
  IsNoticeVal: Variant;
begin
  // 공지사항(IsNotice = True) 행인 경우 배경색을 연한 앰버 강조
  IsNoticeVal := AViewInfo.GridRecord.Values[tvBoardIsNotice.Index];
  if not VarIsNull(IsNoticeVal) and (Boolean(IsNoticeVal) = True) then
  begin
    ACanvas.Brush.Color := $00E1F5FE;
    ACanvas.Font.Style := [fsBold];
  end;
end;

end.
