unit MainFormLee3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, ComCtrls, ADODB, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  StdCtrls, ExtCtrls;

type
  TfrmUserListCode = class(TForm)
    pnlTop: TPanel;
    edtSearchName: TEdit;
    lblSearch: TLabel;
    btnSearch: TButton;
    btnClear: TButton;
    btnExportExcel: TButton;


    // 빈 껍데기 그리드 컴포넌트
    tvUsers: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;

    // 데이터 액세스 컴포넌트
    ADOConnection1: TADOConnection;
    qryUsers: TADOQuery;
    dsUsers: TDataSource;
    statBar: TStatusBar;

    // 이벤트 핸들러
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSearchClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
//    procedure btnExportExcelClick(Sender: TObject);
    procedure edtSearchNameKeyPress(Sender: TObject; var Key: Char);
    procedure tvUsersCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);


  private
    { Private declarations }
    procedure InitDBConnection;
    procedure InitGridColumns;
    procedure ExecuteQuery(const ASearchName: string);

  public
    { Public declarations }
  end;

var
  frmUserListCode: TfrmUserListCode;

implementation

{$R *.dfm}

{===============================================================================
  그리드 컬럼 생성 공통 헬퍼 함수 (Grid Helper Functions)
===============================================================================}

// 1. 텍스트 컬럼 생성 헬퍼
function AddTextColumn(AView: TcxGridDBTableView; const AFieldName, ACaption: string;
  AWidth: Integer; AAlign: TAlignment = taCenter): TcxGridDBColumn;
begin
  Result := AView.CreateColumn as TcxGridDBColumn;
  Result.DataBinding.FieldName := AFieldName;
  Result.Caption := ACaption;
  Result.Width := AWidth;
  Result.HeaderAlignmentHorz := AAlign;
  // Result.PropertiesClass := TcxTextEditProperties;
end;





// 4. 하단 요약(Footer) 항목 추가 헬퍼
procedure AddFooterSummary(AView: TcxGridDBTableView; AColumn: TcxGridDBColumn;
  AKind: TcxSummaryKind; const AFormat: string);
var
  SummaryItem: TcxGridDBTableSummaryItem;
begin
  AView.OptionsView.Footer := True;
  SummaryItem := AView.DataController.Summary.FooterSummaryItems.Add as TcxGridDBTableSummaryItem;
  SummaryItem.Column := AColumn;
  SummaryItem.Kind := AKind;
  SummaryItem.Format := AFormat;
end;

{===============================================================================
  TfrmUserListCode 폼 라이프사이클 이벤트
===============================================================================}

procedure TfrmUserListCode.FormCreate(Sender: TObject);
begin
  // 1. 코드로 그리드 컬럼 & 뷰 세팅 초기화
  InitGridColumns;

  // 2. DB 연결 초기화
  statBar.SimpleText := 'DB 연결 시도 중...';
  InitDBConnection;

  // 3. 검색창 엔터키 이벤트 바인딩
  edtSearchName.OnKeyPress := edtSearchNameKeyPress;
end;

procedure TfrmUserListCode.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if qryUsers.Active then
    qryUsers.Close;
  if ADOConnection1.Connected then
    ADOConnection1.Connected := False;
end;

{-------------------------------------------------------------------------------
  DB 연결 런타임 설정
-------------------------------------------------------------------------------}
procedure TfrmUserListCode.InitDBConnection;
const
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
      ShowMessage('데이터베이스 연결 실패: ' + E.Message);
    end;
  end;
end;

{-------------------------------------------------------------------------------
  런타임 그리드 컬럼 동적 구성 (InitGridColumns)
-------------------------------------------------------------------------------}
procedure TfrmUserListCode.InitGridColumns;
var
  ColUserName: TcxGridDBColumn;
begin
  tvUsers.ClearItems;
  tvUsers.DataController.Summary.FooterSummaryItems.Clear;

  // 뷰 기본 스타일
  tvUsers.OptionsView.GroupByBox := False;
  tvUsers.OptionsView.Indicator := True;

  // 8개 컬럼 동적 생성
  AddTextColumn(tvUsers, 'user_id',    '아이디',   90,  taCenter);
  ColUserName := AddTextColumn(tvUsers, 'user_name',  '성명',     90,  taCenter);
  AddTextColumn(tvUsers, 'department', '부서명',   110, taCenter);
  AddTextColumn(tvUsers, 'position',   '직급',     80,  taCenter);
  AddTextColumn(tvUsers, 'email',      '이메일',   160, taLeftJustify);
  AddTextColumn(tvUsers, 'phone',      '연락처',   120, taCenter);
  //AddCheckBoxColumn(tvUsers, 'is_active', '활성여부', 70, 'Y', 'N');
//  AddDateColumn(tvUsers, 'created_at', '등록일시', 140);

  // 하단 요약 (성명 컬럼 기준 총 건수)
  AddFooterSummary(tvUsers, ColUserName, skCount, '총 사용자: 0명');
end;

{-------------------------------------------------------------------------------
  조회 쿼리 실행
-------------------------------------------------------------------------------}
procedure TfrmUserListCode.ExecuteQuery(const ASearchName: string);
begin
  if not ADOConnection1.Connected then
  begin
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

    if Trim(ASearchName) <> '' then
    begin
      qryUsers.SQL.Add(' WHERE user_name LIKE :SearchName ');
      qryUsers.Parameters.ParamByName('SearchName').Value := '%' + Trim(ASearchName) + '%';
    end;

    qryUsers.SQL.Add(' ORDER BY user_id ASC ');
    qryUsers.Open;

    statBar.SimpleText := Format('조회 완료: 총 %d건의 사용자 정보가 로드되었습니다.', [qryUsers.RecordCount]);
  finally
    qryUsers.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

{-------------------------------------------------------------------------------
  버튼 이벤트 핸들러
-------------------------------------------------------------------------------}
procedure TfrmUserListCode.btnSearchClick(Sender: TObject);
begin
  ExecuteQuery(edtSearchName.Text);
end;

procedure TfrmUserListCode.btnClearClick(Sender: TObject);
begin
  qryUsers.Close;
  edtSearchName.Text := '';
  statBar.SimpleText := '조회 화면이 초기화되었습니다.';
end;

procedure TfrmUserListCode.edtSearchNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnSearch.Click;
  end;
end;


procedure TfrmUserListCode.tvUsersCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  ActiveCol: TcxCustomGridTableItem;
  ActiveVal: Variant;
begin
  // 런타임에 동적으로 'is_active' 컬럼을 찾아 비활성('N') 회원 텍스트를 회색으로 강조
  ActiveCol := tvUsers.GetColumnByFieldName('is_active');
  if ActiveCol <> nil then
  begin
    ActiveVal := AViewInfo.GridRecord.Values[ActiveCol.Index];
    if not VarIsNull(ActiveVal) and (VarToStr(ActiveVal) = 'N') then
    begin
      ACanvas.Font.Color := clGray;
    end;
  end;
end;


end.
