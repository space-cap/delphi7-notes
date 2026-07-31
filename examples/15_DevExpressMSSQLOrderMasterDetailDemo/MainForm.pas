unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB, IniFiles, ComCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridLevel, cxGrid, cxTextEdit, cxCalendar,
  cxCheckBox, cxSpinEdit, cxCurrencyEdit, cxGridExportLink;

type
  TfrmMain = class(TForm)
    pnlTop: TPanel;
    lblTitle: TLabel;
    lblDate: TLabel;
    dtpStart: TDateTimePicker;
    lblWave: TLabel;
    dtpEnd: TDateTimePicker;
    lblCustomer: TLabel;
    edtCustomer: TEdit;
    lblStatus: TLabel;
    cbStatus: TComboBox;
    btnSearch: TButton;
    btnExportExcel: TButton;

    pnlBottom: TPanel;
    lblInfo: TLabel;

    // ADO 컴포넌트
    ADOConnection1: TADOConnection;
    qryMaster: TADOQuery;
    dsMaster: TDataSource;
    qryDetail: TADOQuery;
    dsDetail: TDataSource;

    // DevExpress Master-Detail cxGrid 컴포넌트
    cxGrid1: TcxGrid;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1Level2: TcxGridLevel;
    tvOrderMaster: TcxGridDBTableView;
    tvOrderDetail: TcxGridDBTableView;

    // Master 컬럼
    tvOrderMasterOrderID: TcxGridDBColumn;
    tvOrderMasterOrderNo: TcxGridDBColumn;
    tvOrderMasterOrderDate: TcxGridDBColumn;
    tvOrderMasterCustomerName: TcxGridDBColumn;
    tvOrderMasterOrderStatus: TcxGridDBColumn;
    tvOrderMasterTotalAmount: TcxGridDBColumn;
    tvOrderMasterRemark: TcxGridDBColumn;

    // Detail 컬럼
    tvOrderDetailDetailID: TcxGridDBColumn;
    tvOrderDetailOrderID: TcxGridDBColumn;
    tvOrderDetailItemNo: TcxGridDBColumn;
    tvOrderDetailItemName: TcxGridDBColumn;
    tvOrderDetailUnitPrice: TcxGridDBColumn;
    tvOrderDetailQty: TcxGridDBColumn;
    tvOrderDetailSubTotal: TcxGridDBColumn;

    procedure FormCreate(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnExportExcelClick(Sender: TObject);
    procedure edtCustomerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tvOrderMasterCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    function InitDatabaseConnection: Boolean;
    procedure LoadOrderData;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // 날짜 범위 기본값: 최근 30일 ~ 오늘
  dtpStart.Date := Date - 30;
  dtpEnd.Date := Date;
  cbStatus.ItemIndex := 0; // 전체 보기

  // DB 연결 동적 로드
  if InitDatabaseConnection then
  begin
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

  if not FileExists(IniPath) then
  begin
    IniFile := TIniFile.Create(IniPath);
    try
      IniFile.WriteString('DATABASE', 'Provider', 'SQLOLEDB.1');
      IniFile.WriteString('DATABASE', 'Server', 'localhost\SQLEXPRESS');
      IniFile.WriteString('DATABASE', 'Port', '1433');
      IniFile.WriteString('DATABASE', 'Database', 'ORDERDB');
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

  IniFile := TIniFile.Create(IniPath);
  try
    Provider := IniFile.ReadString('DATABASE', 'Provider', 'SQLOLEDB.1');
    Server   := IniFile.ReadString('DATABASE', 'Server', 'localhost\SQLEXPRESS');
    Port     := IniFile.ReadString('DATABASE', 'Port', '1433');
    Database := IniFile.ReadString('DATABASE', 'Database', 'ORDERDB');
    UserID   := IniFile.ReadString('DATABASE', 'UserID', 'sa');
    Password := IniFile.ReadString('DATABASE', 'Password', '');
    UseSSPI  := IniFile.ReadBool('DATABASE', 'IntegratedSecurity', False);
  finally
    IniFile.Free;
  end;

  if Pos('\', Server) > 0 then
    DataSourceStr := Server
  else if (Port <> '') and (Port <> '1433') then
    DataSourceStr := Server + ',' + Port
  else
    DataSourceStr := Server;

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

  try
    ADOConnection1.Close;
    ADOConnection1.ConnectionString := ConnStr;
    ADOConnection1.Connected := True;
    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      lblInfo.Caption := 'DB 연결 실패 (dbconfig.ini 확인 필요)';
      ShowMessage('[DB 연결 실패]' + sLineBreak +
                  'dbconfig.ini 설정 또는 SQL Server 구동 상태를 확인해 주세요.' + sLineBreak + sLineBreak +
                  '오류 메세지: ' + E.Message);
    end;
  end;
end;

procedure TfrmMain.LoadOrderData;
var
  CustName, StatusFilter: string;
  SQLText: string;
begin
  if not ADOConnection1.Connected then
    Exit;

  CustName := Trim(edtCustomer.Text);
  StatusFilter := cbStatus.Text;

  // 1. 마스터 쿼리 구성 (TOP 1000 조건 포함)
  qryMaster.Close;
  SQLText := 'SELECT TOP 1000 OrderID, OrderNo, OrderDate, CustomerName, OrderStatus, TotalAmount, Remark ' +
             'FROM dbo.TB_ORDER_MASTER ' +
             'WHERE OrderDate BETWEEN :StartDate AND :EndDate ';

  if CustName <> '' then
    SQLText := SQLText + 'AND CustomerName LIKE ''%'' + :Customer + ''%'' ';

  if (StatusFilter <> '') and (StatusFilter <> '전체') then
    SQLText := SQLText + 'AND OrderStatus = :Status ';

  SQLText := SQLText + 'ORDER BY OrderID DESC';

  qryMaster.SQL.Text := SQLText;
  qryMaster.Parameters.ParamByName('StartDate').Value := FormatDateTime('YYYY-MM-DD 00:00:00', dtpStart.Date);
  qryMaster.Parameters.ParamByName('EndDate').Value := FormatDateTime('YYYY-MM-DD 23:59:59', dtpEnd.Date);

  if CustName <> '' then
    qryMaster.Parameters.ParamByName('Customer').Value := CustName;

  if (StatusFilter <> '') and (StatusFilter <> '전체') then
    qryMaster.Parameters.ParamByName('Status').Value := StatusFilter;

  try
    qryMaster.Open;
  except
    on E: Exception do
      ShowMessage('주문 마스터 데이터 조회 오류:' + sLineBreak + E.Message);
  end;

  // 2. 디테일 쿼리 인출
  qryDetail.Close;
  qryDetail.SQL.Text := 'SELECT DetailID, OrderID, ItemNo, ItemName, UnitPrice, Qty, SubTotal ' +
                        'FROM dbo.TB_ORDER_DETAIL ORDER BY OrderID, ItemNo';
  try
    qryDetail.Open;
  except
  end;

  lblInfo.Caption := Format('조회 완료: 마스터 %d건 (최대 1,000건 안전 제한)', [qryMaster.RecordCount]);
end;

procedure TfrmMain.btnSearchClick(Sender: TObject);
begin
  LoadOrderData;
end;

procedure TfrmMain.edtCustomerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    btnSearchClick(Self);
  end;
end;

procedure TfrmMain.tvOrderMasterCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
var
  StatusVal: Variant;
begin
  StatusVal := AViewInfo.GridRecord.Values[tvOrderMasterOrderStatus.Index];
  if not VarIsNull(StatusVal) then
  begin
    if StatusVal = '완료' then
    begin
      ACanvas.Font.Color := clGreen;
      ACanvas.Font.Style := [fsBold];
    end;
    else if StatusVal = '취소' then
    begin
      ACanvas.Font.Color := clRed;
      ACanvas.Font.Style := [fsStrikeOut];
    end;
  end;
end;

procedure TfrmMain.btnExportExcelClick(Sender: TObject);
var
  SaveDlg: TSaveDialog;
begin
  if qryMaster.IsEmpty then
  begin
    ShowMessage('엑셀로 저장할 데이터가 없습니다.');
    Exit;
  end;

  SaveDlg := TSaveDialog.Create(Self);
  try
    SaveDlg.Filter := 'Excel Files (*.xls)|*.xls';
    SaveDlg.FileName := Format('Order_MasterDetail_%s.xls', [FormatDateTime('YYYYMMDD', Date)]);
    if SaveDlg.Execute then
    begin
      ExportGrid4ToExcel(SaveDlg.FileName, cxGrid1, True, True, True, 'xls');
      ShowMessage('성공적으로 엑셀 파일이 저장되었습니다:' + sLineBreak + SaveDlg.FileName);
    end;
  finally
    SaveDlg.Free;
  end;
end;

end.
