unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, DBClient,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridLevel, cxGrid, cxTextEdit, cxCurrencyEdit,
  cxCheckBox, cxDropDownEdit, cxCalendar, cxGridExportLink;

type
  TfrmMain = class(TForm)
    pnlTop: TPanel;
    lblTitle: TLabel;
    btnInitData: TButton;
    btnGroupDept: TButton;
    btnClearGroup: TButton;
    btnDynamicColumn: TButton;
    btnExportExcel: TButton;
    btnToggleFilterRow: TButton;
    
    // Dataset & DataSource (Standard Delphi TClientDataSet)
    cdsEmp: TClientDataSet;
    cdsEmpEmpID: TIntegerField;
    cdsEmpEmpName: TStringField;
    cdsEmpDeptName: TStringField;
    cdsEmpPosition: TStringField;
    cdsEmpSalary: TCurrencyField;
    cdsEmpHireDate: TDateTimeField;
    cdsEmpIsActive: TBooleanField;
    dsEmp: TDataSource;

    // DevExpress cxGrid Components
    cxGrid1: TcxGrid;
    cxGrid1Level1: TcxGridLevel;
    tvEmp: TcxGridDBTableView;
    tvEmpEmpID: TcxGridDBColumn;
    tvEmpEmpName: TcxGridDBColumn;
    tvEmpDeptName: TcxGridDBColumn;
    tvEmpPosition: TcxGridDBColumn;
    tvEmpSalary: TcxGridDBColumn;
    tvEmpHireDate: TcxGridDBColumn;
    tvEmpIsActive: TcxGridDBColumn;

    procedure FormCreate(Sender: TObject);
    procedure btnInitDataClick(Sender: TObject);
    procedure btnGroupDeptClick(Sender: TObject);
    procedure btnClearGroupClick(Sender: TObject);
    procedure btnDynamicColumnClick(Sender: TObject);
    procedure btnExportExcelClick(Sender: TObject);
    procedure btnToggleFilterRowClick(Sender: TObject);
    procedure tvEmpCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    procedure LoadSampleData;
    procedure SetupGridSummaries;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // 1. 메모리 데이터셋 생성 및 데이터 로드
  if not cdsEmp.Active then
  begin
    cdsEmp.CreateDataSet;
    LoadSampleData;
  end;

  // 2. 그리드 요약(Summary) 설정
  SetupGridSummaries;
end;

procedure TfrmMain.LoadSampleData;
  procedure AddRow(ID: Integer; const Name, Dept, Pos: string; Sal: Currency; DateStr: string; Active: Boolean);
  begin
    cdsEmp.Append;
    cdsEmp.FieldByName('EmpID').AsInteger := ID;
    cdsEmp.FieldByName('EmpName').AsString := Name;
    cdsEmp.FieldByName('DeptName').AsString := Dept;
    cdsEmp.FieldByName('Position').AsString := Pos;
    cdsEmp.FieldByName('Salary').AsCurrency := Sal;
    cdsEmp.FieldByName('HireDate').AsDateTime := StrToDate(DateStr);
    cdsEmp.FieldByName('IsActive').AsBoolean := Active;
    cdsEmp.Post;
  end;
begin
  cdsEmp.DisableControls;
  try
    if not cdsEmp.Active then
      cdsEmp.CreateDataSet
    else
      cdsEmp.EmptyDataSet;

    AddRow(1001, '김철수', 'IT개발팀', '부장', 6500000, '2018-03-01', True);
    AddRow(1002, '이영희', 'IT개발팀', '과장', 4800000, '2020-07-15', True);
    AddRow(1003, '박민수', '영업부', '부장', 7200000, '2015-01-10', True);
    AddRow(1004, '정수진', '영업부', '대리', 4100000, '2021-11-01', True);
    AddRow(1005, '최동현', '인사총무팀', '차장', 5300000, '2019-05-20', True);
    AddRow(1006, '홍길동', 'IT개발팀', '사원', 3800000, '2023-01-02', True);
    AddRow(1007, '강나래', '인사총무팀', '사원', 3200000, '2024-02-15', False);
    AddRow(1008, '윤상호', '영업부', '차장', 5900000, '2017-09-01', True);
  finally
    cdsEmp.EnableControls;
  end;
end;

procedure TfrmMain.SetupGridSummaries;
begin
  // 그리드 하단 Footer 표시 활성화
  tvEmp.OptionsView.Footer := True;
  tvEmp.OptionsView.GroupFooters := gfAlwaysVisible;

  // 전체 하단 요약 (Footer): 총 인원 및 급여 합계
  tvEmp.DataController.Summary.FooterSummaryItems.Clear;

  // 성명 컬럼 하단: COUNT
  with tvEmp.DataController.Summary.FooterSummaryItems.Add as TcxGridDBTableSummaryItem do
  begin
    Column := tvEmpEmpName;
    Kind := skCount;
    Format := '총 인원: 0명';
  end;

  // 급여 컬럼 하단: SUM
  with tvEmp.DataController.Summary.FooterSummaryItems.Add as TcxGridDBTableSummaryItem do
  begin
    Column := tvEmpSalary;
    Kind := skSum;
    Format := '합계: \,0원';
  end;

  // 그룹별 요약 (Group Summary): 부서별 급여 합계
  tvEmp.DataController.Summary.DefaultGroupSummaryItems.Clear;
  with tvEmp.DataController.Summary.DefaultGroupSummaryItems.Add as TcxGridDBTableSummaryItem do
  begin
    Column := tvEmpSalary;
    Kind := skSum;
    Format := '부서합계: \,0원';
    Position := spFooter;
  end;
end;

procedure TfrmMain.btnInitDataClick(Sender: TObject);
begin
  LoadSampleData;
  ShowMessage('샘플 데이터가 로드되었습니다.');
end;

procedure TfrmMain.btnGroupDeptClick(Sender: TObject);
begin
  // 코드상에서 'DeptName' 컬럼 동적 그룹핑
  tvEmpDeptName.GroupIndex := 0; // 0번째 수석 그룹핑
  ShowMessage('부서(DeptName)로 그룹핑되었습니다.');
end;

procedure TfrmMain.btnClearGroupClick(Sender: TObject);
begin
  // 그룹핑 해제
  tvEmp.DataController.Groups.ClearGrouping;
  ShowMessage('그룹핑이 해제되었습니다.');
end;

procedure TfrmMain.btnDynamicColumnClick(Sender: TObject);
var
  NewCol: TcxGridDBColumn;
begin
  // 이미 존재하는지 확인
  if tvEmp.GetColumnByFieldName('Bonus') <> nil then
  begin
    ShowMessage('이미 동적 컬럼(Bonus)이 생성되어 있습니다.');
    Exit;
  end;

  // 런타임에 커스텀 컬럼 생성하는 방법
  NewCol := tvEmp.CreateColumn as TcxGridDBColumn;
  NewCol.DataBinding.FieldName := 'Bonus';
  NewCol.Caption := '상여금';
  NewCol.HeaderAlignmentHorz := taCenter;
  NewCol.Width := 100;
  NewCol.PropertiesClass := TcxTextEditProperties;

  ShowMessage('동적 컬럼(Bonus)이 런타임에 추가되었습니다!');
end;

procedure TfrmMain.btnToggleFilterRowClick(Sender: TObject);
begin
  // 필터 행(Filter Row) 토글
  tvEmp.FilterRow.Visible := not tvEmp.FilterRow.Visible;
end;

procedure TfrmMain.btnExportExcelClick(Sender: TObject);
var
  SaveDlg: TSaveDialog;
begin
  SaveDlg := TSaveDialog.Create(Self);
  try
    SaveDlg.Filter := 'Excel Files (*.xls)|*.xls';
    SaveDlg.FileName := 'EmployeeList.xls';
    if SaveDlg.Execute then
    begin
      ExportGridToExcel(SaveDlg.FileName, cxGrid1, True, True, True, 'xls');
      ShowMessage('엑셀 저장 완료: ' + SaveDlg.FileName);
    end;
  finally
    SaveDlg.Free;
  end;
end;

procedure TfrmMain.tvEmpCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
var
  Val: Variant;
begin
  // 급여 600만원 이상 고액 급여 수령자 하이라이트
  if AViewInfo.Item = tvEmpSalary then
  begin
    Val := AViewInfo.GridRecord.Values[tvEmpSalary.Index];
    if not VarIsNull(Val) and (Val >= 6000000) then
    begin
      ACanvas.Brush.Color := $00E1FF78;
      ACanvas.Font.Style := [fsBold];
    end;
  end;
end;

end.
