# 13. DevExpress TcxGrid (QuantumGrid 6) 완벽 실습 데모 📊

이 예제는 델파이 7 실무 프로젝트의 핵심 써드파티 컴포넌트인 **DevExpress QuantumGrid (`TcxGrid`)**의 기초 사용법 및 주요 고급 기능(그룹핑, 요약 Footer, 셀 커스텀 그리기, 런타임 동적 컬럼 생성, 엑셀 익스포트)을 실습하는 종합 프로젝트입니다.

---

## 🎯 학습 목표
1. `TcxGrid`의 3단계 구조 (**TcxGrid ➔ TcxGridLevel ➔ TcxGridDBTableView**) 이해하기
2. 델파이 표준 메모리 데이터셋 `TClientDataSet`과 `TcxGridDBTableView` 바인딩하기
3. 부서별 자동 그룹핑(Grouping) 및 그룹별/전체 하단 요약(Footer Summary) 구현하기
4. 런타임 코드 상에서 동적으로 컬럼(`TcxGridDBColumn`) 생성 및 프로퍼티 설정하기
5. `OnCustomDrawCell` 이벤트를 이용한 특정 데이터 셀 색상 하이라이트 구현하기
6. 그리드 데이터를 엑셀(XLS) 파일로 익스포트(`ExportGridToExcel`)하기

---

## 🏗️ TcxGrid 계층 구조 이해하기

델파이 기본 `TDBGrid`와 달리 DevExpress `TcxGrid`는 **컨테이너-레벨-뷰**의 3단계 독립적인 구조로 디자인되어 있습니다.

```
TcxGrid (최상위 컨트롤 / 화면 영역)
  └── TcxGridLevel (데이터 레벨 / Master-Detail 계층 표현)
        └── TcxGridDBTableView (실제 데이터 그리드 뷰)
              ├── TcxGridDBColumn (사번)
              ├── TcxGridDBColumn (성명 - TcxTextEditProperties)
              ├── TcxGridDBColumn (연봉 - TcxCurrencyEditProperties)
              ├── TcxGridDBColumn (입사일 - TcxDateEditProperties)
              └── TcxGridDBColumn (재직여부 - TcxCheckBoxProperties)
```

---

## 💡 주요 구현 코드 해설

### 1. 데이터셋 오픈 및 초기화 (`TClientDataSet`)
```pascal
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  if not cdsEmp.Active then
  begin
    cdsEmp.CreateDataSet; // 메모리 상에 테이블 데이터셋 생성
    LoadSampleData;
  end;
  SetupGridSummaries;
end;
```

### 2. 하단 요약(Footer Summary) 설정
```pascal
procedure TfrmMain.SetupGridSummaries;
begin
  tvEmp.OptionsView.Footer := True;
  tvEmp.OptionsView.GroupFooters := gfAlwaysVisible;

  // 전체 하단 사원 수 (COUNT)
  with tvEmp.DataController.Summary.FooterSummaryItems.Add as TcxGridDBTableSummaryItem do
  begin
    Column := tvEmpEmpName;
    Kind := skCount;
    Format := '총 인원: 0명';
  end;

  // 전체 하단 급여 합계 (SUM)
  with tvEmp.DataController.Summary.FooterSummaryItems.Add as TcxGridDBTableSummaryItem do
  begin
    Column := tvEmpSalary;
    Kind := skSum;
    Format := '합계: \,0원';
  end;
end;
```

### 3. 코드상에서 부서별 그룹핑 적용
```pascal
procedure TfrmMain.btnGroupDeptClick(Sender: TObject);
begin
  // DeptName 컬럼을 기준으로 1차 그룹핑 설정
  tvEmpDeptName.GroupIndex := 0;
end;
```

### 4. 동적 컬럼 생성 (Runtime Column Creation)
```pascal
var
  NewCol: TcxGridDBColumn;
begin
  NewCol := tvEmp.CreateColumn as TcxGridDBColumn;
  NewCol.Caption := '비고/상여율';
  NewCol.HeaderAlignmentHorz := taCenter;
  NewCol.Width := 100;
  NewCol.PropertiesClass := TcxTextEditProperties; // 에디터 타입 지정
end;
```

### 5. 조건별 셀 배경색 및 글꼴 변경 (`OnCustomDrawCell`)
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
      ACanvas.Brush.Color := $00E1FF78; // 연한 녹색 하이라이트
      ACanvas.Font.Style := [fsBold];
    end;
  end;
end;
```

### 6. 엑셀 파일 내보내기 (`ExportGridToExcel`)
```pascal
uses cxGridExportLink;

ExportGridToExcel('C:\Temp\EmployeeList.xls', cxGrid1, True, True, True, 'xls');
```

---

## 📂 파일 구성
* [`DevExpresscxGridDemo.dpr`](file:///h:/lee/delphi7-notes/examples/13_DevExpresscxGridDemo/DevExpresscxGridDemo.dpr): 델파이 프로젝트 파일
* [`MainForm.pas`](file:///h:/lee/delphi7-notes/examples/13_DevExpresscxGridDemo/MainForm.pas): 메인 폼 파스칼 소스 코드 (TClientDataSet 사용)
* [`MainForm.dfm`](file:///h:/lee/delphi7-notes/examples/13_DevExpresscxGridDemo/MainForm.dfm): 메인 폼 DFM 폼 정의 파일

---

## 🛠️ 실무 개발 시 자주 발생하는 오류 및 문제 해결

| 문제 상황 | 원인 | 해결 방법 |
| :--- | :--- | :--- |
| `Class TdxMemData not found` 오류 | `ExpressMemData` BPL 미설치 | 델파이 표준 내장 `TClientDataSet`으로 대체 사용 |
| `Class TcxGrid not found` 오류 | Design-time BPL 패키지 미등록 | `Component` -> `Install Packages`에서 `dclcxGridD7.bpl` 등록 확인 |
| `File not found: cxGrid.dcu` 오류 | Library Path에 DevExpress 경로 미추가 | `Tools` -> `Environment Options` -> `Library` -> `Library Path`에 Developer Express VCL 경로 추가 |
| `ExportGridToExcel` 컴파일 에러 | `uses` 절 누락 | 소스 상단 `uses` 절에 `cxGridExportLink` 추가 |
