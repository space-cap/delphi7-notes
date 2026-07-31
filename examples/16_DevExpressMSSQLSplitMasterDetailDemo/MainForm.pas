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
    lblClient: TLabel;
    edtClient: TEdit;
    lblStatus: TLabel;
    cbStatus: TComboBox;
    btnSearch: TButton;
    btnExportExcel: TButton;

    pnlBottom: TPanel;
    lblInfo: TLabel;

    // 상하 분할 패널 및 스플리터
    pnlMaster: TPanel;
    pnlMasterHeader: TPanel;
    lblMasterTitle: TLabel;
    cxGridMaster: TcxGrid;
    tvSalesMaster: TcxGridDBTableView;
    cxGridMasterLevel1: TcxGridLevel;

    Splitter1: TSplitter;

    pnlDetail: TPanel;
    pnlDetailHeader: TPanel;
    lblDetailTitle: TLabel;
    cxGridDetail: TcxGrid;
    tvSalesDetail: TcxGridDBTableView;
    cxGridDetailLevel1: TcxGridLevel;

    // Master 컬럼
    tvSalesMasterSalesID: TcxGridDBColumn;
    tvSalesMasterSalesNo: TcxGridDBColumn;
    tvSalesMasterSalesDate: TcxGridDBColumn;
    tvSalesMasterClientName: TcxGridDBColumn;
    tvSalesMasterSalesRep: TcxGridDBColumn;
    tvSalesMasterPaymentStatus: TcxGridDBColumn;
    tvSalesMasterTotalPrice: TcxGridDBColumn;
    tvSalesMasterRemark: TcxGridDBColumn;

    // Detail 컬럼
    tvSalesDetailDetailID: TcxGridDBColumn;
    tvSalesDetailSalesID: TcxGridDBColumn;
    tvSalesDetailLineNo: TcxGridDBColumn;
    tvSalesDetailItemCode: TcxGridDBColumn;
    tvSalesDetailItemName: TcxGridDBColumn;
    tvSalesDetailPrice: TcxGridDBColumn;
    tvSalesDetailQty: TcxGridDBColumn;
    tvSalesDetailAmount: TcxGridDBColumn;

    // ADO 컴포넌트
    ADOConnection1: TADOConnection;
    qryMaster: TADOQuery;
    dsMaster: TDataSource;
    qryDetail: TADOQuery;
    dsDetail: TDataSource;

    procedure FormCreate(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnExportExcelClick(Sender: TObject);
    procedure edtClientKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure qryMasterAfterScroll(DataSet: TDataSet);
    procedure tvSalesMasterCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    function InitDatabaseConnection: Boolean;
    procedure LoadSalesMasterData;
    procedure LoadSalesDetailData(ASalesID: Integer);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  dtpStart.Date := Date - 30;
  dtpEnd.Date := Date;
  cbStatus.ItemIndex := 0;

  try
    if InitDatabaseConnection then
    begin
      btnSearchClick(Self);
    end;
  except
    on E: Exception do
      lblInfo.Caption := 'DB 연결 초기화 오류: ' + E.Message;
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
      IniFile.WriteString('DATABASE', 'Database', 'DELPHI7_DB');
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
    Database := IniFile.ReadString('DATABASE', 'Database', 'DELPHI7_DB');
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
                  'dbconfig.ini 설정 및 SALESDB 데이터베이스 생성을 확인해 주세요.' + sLineBreak + sLineBreak +
                  '오류 메세지: ' + E.Message);
    end;
  end;
end;

procedure TfrmMain.LoadSalesMasterData;
var
  ClientFilter, StatusFilter, SQLText: string;
begin
  if not ADOConnection1.Connected then
  begin
    ShowMessage('DB가 연결되어 있지 않습니다.');
    Exit;
  end;

  ClientFilter := Trim(edtClient.Text);
  StatusFilter := cbStatus.Text;

  qryMaster.DisableControls;
  try
    qryMaster.Close;
    SQLText := 'SELECT TOP 1000 SalesID, SalesNo, SalesDate, ClientName, SalesRep, PaymentStatus, TotalPrice, Remark ' +
               'FROM dbo.TB_SALES_MASTER ' +
               'WHERE SalesDate BETWEEN :StartDate AND :EndDate ';

    if ClientFilter <> '' then
      SQLText := SQLText + 'AND ClientName LIKE ''%'' + :Client + ''%'' ';

    if (StatusFilter <> '') and (StatusFilter <> '전체') then
      SQLText := SQLText + 'AND PaymentStatus = :Status ';

    SQLText := SQLText + 'ORDER BY SalesID DESC';

    qryMaster.SQL.Text := SQLText;
    qryMaster.Parameters.ParamByName('StartDate').Value := FormatDateTime('YYYY-MM-DD 00:00:00', dtpStart.Date);
    qryMaster.Parameters.ParamByName('EndDate').Value := FormatDateTime('YYYY-MM-DD 23:59:59', dtpEnd.Date);

    if ClientFilter <> '' then
      qryMaster.Parameters.ParamByName('Client').Value := ClientFilter;

    if (StatusFilter <> '') and (StatusFilter <> '전체') then
      qryMaster.Parameters.ParamByName('Status').Value := StatusFilter;

    try
      qryMaster.Open;
    except
      on E: Exception do
        ShowMessage('매출 마스터 조회 오류:' + sLineBreak + E.Message);
    end;
  finally
    qryMaster.EnableControls;
  end;

  lblInfo.Caption := Format('조회 완료: 매출 전표 %d건 인출 (최대 1,000건 제한)', [qryMaster.RecordCount]);

  // 마스터 조회가 끝나면 현재 행의 디테일 자동 수신
  if not qryMaster.IsEmpty then
    LoadSalesDetailData(qryMaster.FieldByName('SalesID').AsInteger)
  else
  begin
    qryDetail.Close;
    lblDetailTitle.Caption := ' [상세 품목 목록] - 전표가 선택되지 않았습니다.';
  end;
end;

procedure TfrmMain.LoadSalesDetailData(ASalesID: Integer);
begin
  if not ADOConnection1.Connected or (ASalesID <= 0) then
    Exit;

  qryDetail.DisableControls;
  try
    qryDetail.Close;
    qryDetail.SQL.Text := 'SELECT DetailID, SalesID, LineNo, ItemCode, ItemName, Price, Qty, Amount ' +
                          'FROM dbo.TB_SALES_DETAIL ' +
                          'WHERE SalesID = :SalesID ' +
                          'ORDER BY LineNo ASC';
    qryDetail.Parameters.ParamByName('SalesID').Value := ASalesID;
    try
      qryDetail.Open;
    except
    end;
  finally
    qryDetail.EnableControls;
  end;

  lblDetailTitle.Caption := Format(' [상세 품목 목록] - 전표번호: %s (총 %d건 품목)',
                              [qryMaster.FieldByName('SalesNo').AsString, qryDetail.RecordCount]);
end;

procedure TfrmMain.qryMasterAfterScroll(DataSet: TDataSet);
var
  CurSalesID: Integer;
begin
  // 마스터 그리드에서 키보드 화살표나 마우스로 행을 이동할 때마다 실시간으로 하단 디테일 쿼리 인출!
  if not qryMaster.IsEmpty then
  begin
    CurSalesID := qryMaster.FieldByName('SalesID').AsInteger;
    LoadSalesDetailData(CurSalesID);
  end;
end;

procedure TfrmMain.btnSearchClick(Sender: TObject);
begin
  if not ADOConnection1.Connected then
  begin
    if not InitDatabaseConnection then
      Exit;
  end;

  LoadSalesMasterData;
end;

procedure TfrmMain.edtClientKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    btnSearchClick(Self);
  end;
end;

procedure TfrmMain.tvSalesMasterCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
var
  StatusVal: Variant;
begin
  StatusVal := AViewInfo.GridRecord.Values[tvSalesMasterPaymentStatus.Index];
  if not VarIsNull(StatusVal) then
  begin
    if StatusVal = '완납' then
    begin
      ACanvas.Font.Color := clGreen;
      ACanvas.Font.Style := [fsBold];
    end
    else if StatusVal = '미수' then
    begin
      ACanvas.Font.Color := clRed;
      ACanvas.Font.Style := [fsBold];
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
    SaveDlg.FileName := Format('Sales_Split_MasterDetail_%s.xls', [FormatDateTime('YYYYMMDD', Date)]);
    if SaveDlg.Execute then
    begin
      ExportGridToExcel(SaveDlg.FileName, cxGridMaster, True, True, True, 'xls');
      ShowMessage('성공적으로 마스터 매출 전표가 엑셀 파일로 저장되었습니다:' + sLineBreak + SaveDlg.FileName);
    end;
  finally
    SaveDlg.Free;
  end;
end;

end.
