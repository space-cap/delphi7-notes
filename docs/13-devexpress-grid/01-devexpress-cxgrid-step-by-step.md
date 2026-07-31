# DevExpress QuantumGrid (TcxGrid) 단계별 실습 가이드 🚀

이 문서는 델파이 7(Delphi 7) 환경에서 기업형 3rd Party 그리드 표준인 **DevExpress QuantumGrid (`TcxGrid`)**를 처음부터 직접 화면에 배치하고, 데이터를 연결하며, 그룹핑/요약합계/동적 컬럼 생성/엑셀 내보내기 기능까지 한 단계씩 따라 할 수 있도록 만든 실습 튜토리얼입니다.

---

## 📌 목차
1. [준비 사항](#1-준비-사항)
2. [1단계: 프로젝트 생성 및 폼 컨트롤 배치](#2-1단계-프로젝트-생성-및-폼-컨트롤-배치)
3. [2단계: TClientDataSet 데이터셋 구축](#3-2단계-tclientdataset-데이터셋-구축)
4. [3단계: TcxGrid 데이터 바인딩 및 컬럼 생성](#4-3단계-tcxgrid-데이터-바인딩-및-컬럼-생성)
5. [4단계: 핵심 소스 코드 구현 (MainForm.pas)](#5-4단계-핵심-소스-코드-구현-mainformpas)
6. [5단계: 실행 및 주요 기능 테스트](#6-5단계-실행-및-주요-기능-테스트)

---

## 1. 준비 사항

* **IDE**: Borland Delphi 7
* **컴포넌트**: DevExpress QuantumGrid v6 (VCL)
* **필요 패키지**: `cxGridD7.bpl`, `cxEditorsVCLD7.bpl`, `cxLibraryVCLD7.bpl`

---

## 2. 1단계: 프로젝트 생성 및 폼 컨트롤 배치

1. 델파이 7 실행 ➔ **`File` ➔ `New` ➔ `Application`** 선택
2. 메인 폼(`Form1`) 속성 변경:
   - `Name`: `frmMain`
   - `Caption`: `DevExpress TcxGrid 기초 실습 데모`
   - `Width`: `900`, `Height`: `600`

3. 상단 상자 배치 (`TPanel`):
   - Component Palette ➔ `Standard` 탭 ➔ **`TPanel`** 배치
   - `Align`: `alTop`, `Height`: `50`, `Caption`: `''` (빈 문자열)

4. 버튼 컨트롤 배치 (`TButton` 6개):
   - 상단 Panel 위에 아래 6개 버튼을 차례대로 배치합니다:

| 버튼 Name | Caption | 역할 |
| :--- | :--- | :--- |
| `btnInitData` | `데이터 초기화` | 샘플 데이터 8건 재로드 |
| `btnGroupDept` | `부서별 그룹핑` | 런타임에 부서명 기준 자동 그룹핑 |
| `btnClearGroup` | `그룹핑 해제` | 그룹핑을 풀고 기본 상태 복원 |
| `btnDynamicColumn` | `동적 컬럼 추가` | 런타임에 '상여금' 컬럼 생성 |
| `btnToggleFilterRow` | `필터 행 토글` | 그리드 상단 필터 입력창 토글 |
| `btnExportExcel` | `엑셀 저장` | 그리드 전체 내용을 XLS로 Export |

---

## 3. 2단계: TClientDataSet 데이터셋 구축

별도의 DB 서버 없이 메모리 기반으로 테스트하기 위해 `TClientDataSet`을 사용합니다.

1. Component Palette ➔ `Data Access` 탭 ➔ **`TClientDataSet`** (`cdsEmp`) 배치
2. Component Palette ➔ `Data Access` 탭 ➔ **`TDataSource`** (`dsEmp`) 배치
3. `dsEmp.DataSet` 속성을 **`cdsEmp`**로 지정합니다.

4. **컬럼 필드 생성**:
   - `cdsEmp` 컴포넌트 더블 클릭 ➔ Fields Editor 창 열기
   - 우클릭 ➔ `New Field`로 아래 7개 필드를 생성합니다:

| Field Name | Type | Size | Caption |
| :--- | :--- | :--- | :--- |
| `EmpID` | `Integer` | - | 사원번호 |
| `EmpName` | `String` | `20` | 성명 |
| `DeptName` | `String` | `30` | 부서명 |
| `Position` | `String` | `20` | 직급 |
| `Salary` | `Currency` | - | 급여 |
| `HireDate` | `DateTime` | - | 입사일 |
| `IsActive` | `Boolean` | - | 재직여부 |

---

## 4. 3단계: TcxGrid 데이터 바인딩 및 컬럼 생성

1. Component Palette ➔ `ExpressQuantumbit` (또는 `ExpressGrid`) 탭 ➔ **`TcxGrid`** 배치
2. `cxGrid1` 속성 변경:
   - `Align`: `alClient`

3. **GridView 유형 지정**:
   - `cxGrid1` 구조 창에서 `cxGrid1Level1` 선택
   - Properties ➔ `GridView` 속성을 **`DB Table View`** 선택 (이름: `tvEmp`)

4. **데이터 바인딩**:
   - `tvEmp` (TcxGridDBTableView) 선택
   - `DataController.DataSource` ➔ **`dsEmp`** 지정

5. **DB 컬럼 일괄 생성**:
   - `tvEmp` 우클릭 ➔ **`Create All Items`** 클릭!
   - `cdsEmp`에 정의된 7개 필드가 `tvEmpEmpID`, `tvEmpEmpName` 등의 그리드 컬럼으로 자동 생성됩니다.

---

## 5. 4단계: 핵심 소스 코드 구현 (MainForm.pas)

[`MainForm.pas`](file:///h:/lee/delphi7-notes/examples/13_DevExpresscxGridDemo/MainForm.pas) 소스 파일의 `uses`절에 `cxGridExportLink`를 포함하고 아래 코드를 작성합니다:

### 1) uses 절 추가
```pascal
uses
  ..., cxGridExportLink;
```

### 2) 폼 생성 및 샘플 데이터 로드 (`FormCreate`)
```pascal
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // 메모리 데이터셋 생성 및 샘플 데이터 로드
  if not cdsEmp.Active then
  begin
    cdsEmp.CreateDataSet;
    LoadSampleData;
  end;

  // 그리드 요약(Footer/Group Summary) 설정
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
```

### 3) 하단 요약 및 그룹 요약 설정 (`SetupGridSummaries`)
```pascal
procedure TfrmMain.SetupGridSummaries;
begin
  // 그리드 하단 Footer 표시
  tvEmp.OptionsView.Footer := True;
  tvEmp.OptionsView.GroupFooters := gfAlwaysVisible;

  // 전체 하단 요약 (FooterSummary)
  tvEmp.DataController.Summary.FooterSummaryItems.Clear;

  // 1. 성명 컬럼: 인원수 (skCount)
  with tvEmp.DataController.Summary.FooterSummaryItems.Add as TcxGridDBTableSummaryItem do
  begin
    Column := tvEmpEmpName;
    Kind := skCount;
    Format := '총 인원: 0명';
  end;

  // 2. 급여 컬럼: 급여 합계 (skSum)
  with tvEmp.DataController.Summary.FooterSummaryItems.Add as TcxGridDBTableSummaryItem do
  begin
    Column := tvEmpSalary;
    Kind := skSum;
    Format := '합계: \,0원';
  end;

  // 3. 그룹별 요약 (DefaultGroupSummaryItems)
  tvEmp.DataController.Summary.DefaultGroupSummaryItems.Clear;
  with tvEmp.DataController.Summary.DefaultGroupSummaryItems.Add as TcxGridDBTableSummaryItem do
  begin
    Column := tvEmpSalary;
    Kind := skSum;
    Format := '부서합계: \,0원';
    Position := spFooter;
  end;
end;
```

### 4) 동적 그룹핑 & 그룹 해제 이벤트
```pascal
procedure TfrmMain.btnGroupDeptClick(Sender: TObject);
begin
  // 부서명(DeptName) 컬럼을 그룹핑 우선순위 0번으로 지정
  tvEmpDeptName.GroupIndex := 0;
end;

procedure TfrmMain.btnClearGroupClick(Sender: TObject);
begin
  // 전체 그룹핑 해제
  tvEmp.DataController.Groups.ClearGrouping;
end;
```

### 5) 런타임 동적 컬럼 생성 (`btnDynamicColumnClick`)
```pascal
procedure TfrmMain.btnDynamicColumnClick(Sender: TObject);
var
  NewCol: TcxGridDBColumn;
begin
  if tvEmp.GetColumnByFieldName('Bonus') <> nil then
  begin
    ShowMessage('이미 동적 컬럼(Bonus)이 추가되어 있습니다.');
    Exit;
  end;

  NewCol := tvEmp.CreateColumn as TcxGridDBColumn;
  NewCol.DataBinding.FieldName := 'Bonus';
  NewCol.Caption := '상여금';
  NewCol.HeaderAlignmentHorz := taCenter;
  NewCol.Width := 100;
  NewCol.PropertiesClass := TcxTextEditProperties;
end;
```

### 6) 급여 600만원 이상 조건부 색상 강조 (`tvEmpCustomDrawCell`)
```pascal
procedure TfrmMain.tvEmpCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
var
  Val: Variant;
begin
  if AViewInfo.Item = tvEmpSalary then
  begin
    Val := AViewInfo.GridRecord.Values[tvEmpSalary.Index];
    if not VarIsNull(Val) and (Val >= 6000000) then
    begin
      ACanvas.Brush.Color := $00E1FF78; // 연두색 배경
      ACanvas.Font.Style := [fsBold];
    end;
  end;
end;
```

### 7) 엑셀 저장 구현 (`btnExportExcelClick`)
```pascal
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
      ShowMessage('엑셀 저장이 완료되었습니다: ' + SaveDlg.FileName);
    end;
  finally
    SaveDlg.Free;
  end;
end;
```

---

## 6. 5단계: 실행 및 주요 기능 테스트

1. 델파이 7에서 **`F9`** 키를 눌러 프로젝트를 실행합니다.
2. **기능 검증 체크리스트**:
   - [x] **초기 화면**: 8명의 사원 목록이 표출되고 하단 Footer에 `총 인원: 8명` 및 급여 합계가 표시되는지 확인합니다.
   - [x] **조건부 셀 강조**: 급여가 600만원 이상인 박민수(720만), 김철수(650만) 사원의 급여 셀이 연두색 굵은 글씨로 강조되는지 확인합니다.
   - [x] **[부서별 그룹핑] 버튼**: 클릭 시 부서별로 그룹 트리가 접히고 펼쳐지며 부서 소계가 표시되는지 확인합니다.
   - [x] **[동적 컬럼 추가] 버튼**: 클릭 시 '상여금' 컬럼이 런타임에 즉시 그리드 끝에 추가되는지 확인합니다.
   - [x] **[필터 행 토글] 버튼**: 각 컬럼 상단에 필터 입력창이 토글되어 키워드 검색이 되는지 확인합니다.
   - [x] **[엑셀 저장] 버튼**: 클릭 후 `.xls` 파일로 내보내기 성공 메시지가 뜨는지 확인합니다.
