# DevExpress QuantumGrid (TcxGrid) 단계별 실습 가이드 3편: 실무형 PAS 코드 기반 런타임 동적 컬럼 & DB 연동 🚀

이 문서는 델파이 7(Delphi 7) 기업형 실무 프로젝트(ERP/MES/금융/물류)에서 가장 널리 쓰이는 **"DFM 속성 설정 최소화 + PAS 런타임 동적 컬럼 생성 & 세팅"** 기법을 다루는 단계별 실습 튜토리얼입니다.

2편에서 다룬 디자인타임(Object Inspector) 방식의 한계를 극복하고, **Git 협업 충돌 방지, 코드 재사용성 극대화, 단 몇 줄의 헬퍼 함수로 그리드 컬럼을 자유자재로 제어하는 실무 개발자의 코딩 패턴**을 그대로 따라 해 봅니다.

---

## 📌 목차
1. [실습 개요: 왜 실무에서는 PAS 코드로 컬럼을 세팅하는가?](#1-실습-개요-왜-실무에서는-pas-코드로-컬럼을-세팅하는가)
2. [1단계: 데이터베이스 사전 확인 (users 테이블)](#2-1단계-데이터베이스-사전-확인-users-테이블)
3. [2단계: 델파이 7 폼 디자인 (최소한의 컨트롤 배치 - 3분 컷!)](#3-2단계-델파이-7-폼-디자인-최소한의-컨트롤-배치---3분-컷)
4. [3단계: 실무형 그리드 헬퍼(Grid Helper) 함수 설계](#4-3단계-실무형-그리드-헬퍼grid-helper-함수-설계)
5. [4단계: 그리드 초기화 프로시저 작성 (InitGridColumns)](#5-4단계-그리드-초기화-프로시저-작성-initgridcolumns)
6. [5단계: 핵심 전체 소스 코드 구현 (MainForm.pas)](#6-5단계-핵심-전체-소스-코드-구현-mainformpas)
7. [6단계: 소스 코드 복사/붙여넣기 후 필수 작업: 이벤트 연결 (Events 탭)](#7-6단계-소스-코드-복사붙여넣기-후-필수-작업-이벤트-연결-events-탭)
8. [7단계: 실행 및 단계별 기능 검증](#8-7단계-실행-및-단계별-기능-검증)
9. [8단계: 실무 심화 테크닉 (권한별 동적 컬럼 제어 & 팀 협업 노하우)](#9-8단계-실무-심화-테크닉-권한별-동적-컬럼-제어--팀-협업-노하우)

---

## 1. 실습 개요: 왜 실무에서는 PAS 코드로 컬럼을 세팅하는가?

### ⚖️ 2편(Object Inspector 방식) vs 3편(PAS 런타임 방식) 비교

| 비교 항목 | 2편: Object Inspector (디자인타임) | 3편: PAS 런타임 코드 (실무 표준) ⭐ |
| :--- | :--- | :--- |
| **컬럼 생성 위치** | 델파이 폼 디자이너 (`Create All Items`) | `MainForm.pas` 코드 (`tvUsers.CreateColumn`) |
| **속성/체크박스 설정**| F11 속성창에서 마우스로 클릭 및 입력 | 헬퍼 함수 호출 (`AddCheckBoxColumn(...)`) |
| **DFM 파일 용량** | 수백 줄의 메타데이터가 기록됨 | **단 10~20줄로 매우 가벼움** |
| **Git 버전 관리** | 다수 개발자 작업 시 `.dfm` Merge 충돌 발생 | **충돌 거의 없음 (PAS 소스만 병합)** |
| **유지보수 / 변경** | 30개 폼의 컬럼 폰트/색상 변경 시 일일이 클릭 | **공통 헬퍼 함수 1개만 수정하면 전체 화면 일괄 반영** |
| **가변 컬럼 / 권한** | 로그인 권한별 컬럼 숨김/추가 제어 어려움 | **`if IsAdmin then AddColumn(...)` 형태로 완벽 제어** |

---

## 2. 1단계: 데이터베이스 사전 확인 (users 테이블)

2편에서 구축한 MS SQL Server의 `DELPHI7_DB` 및 `dbo.users` 테이블을 그대로 사용합니다.

```sql
-- 접속 정보: localhost\SQLEXPRESS (sa / doolman)
USE [DELPHI7_DB];
GO

SELECT user_id, user_name, department, position, email, phone, is_active, created_at 
  FROM dbo.users;
GO
```

---

## 3. 2단계: 델파이 7 폼 디자인 (최소한의 컨트롤 배치 - 3분 컷!)

실무 스타일에서는 **폼 디자이너에서 컬럼을 일절 만들지 않고, 껍데기 컴포넌트만 올리고 연결**합니다.

```
+-----------------------------------------------------------------------------------+
| frmUserListCode                                                         [_][O][X] |
+-----------------------------------------------------------------------------------+
| [pnlTop (Align: alTop, Height: 55)]                                               |
|  [ 성명 검색: ] [ edtSearchName ]  [🔍 사용자 조회 (btnSearch)]  [ 엑셀 저장 ]       |
+-----------------------------------------------------------------------------------+
| [cxGrid1 (Align: alClient)]                                                       |
|  +------------------------------------------------------------------------------+ |
|  | (디자인타임에는 빈 그리드 상태! 런타임에 코드로 컬럼 8개가 자동 생성됩니다.)       | |
|  +------------------------------------------------------------------------------+ |
+-----------------------------------------------------------------------------------+
| [statBar (Align: alBottom) - 상태 표시줄]                                         |
+-----------------------------------------------------------------------------------+
```

### 📋 컴포넌트 배치 및 기본 속성 (끝!)
1. **`TPanel`** (`pnlTop`): `Align: alTop`, `Height: 55`
   - `TLabel` (`lblSearch`): `Caption: '성명 검색:'`
   - `TEdit` (`edtSearchName`): `Text: ''`
   - `TButton` (`btnSearch`): `Caption: '🔍 사용자 조회'`
   - `TButton` (`btnClear`): `Caption: '초기화'`
   - `TButton` (`btnExportExcel`): `Caption: '📊 엑셀 저장'`
2. **`TcxGrid`** (`cxGrid1`): `Align: alClient`
   - `cxGrid1Level1` ➔ `GridView` 속성을 **`TcxGridDBTableView`**로 선택 (Name: **`tvUsers`**)
3. **`TADOConnection`** (`ADOConnection1`): `LoginPrompt: False`
4. **`TADOQuery`** (`qryUsers`): `Connection: ADOConnection1`
5. **`TDataSource`** (`dsUsers`): `DataSet: qryUsers`
6. **`tvUsers`**: `DataController.DataSource: dsUsers`
7. **`TStatusBar`** (`statBar`): `Align: alBottom`, `SimplePanel: True`

> [!IMPORTANT]
> **디자인타임에서는 더 이상 아무것도 건드리지 마세요!**
> `Create All Items`도 누르지 않고, 빈 상태 그대로 둡니다. 모든 작업은 이제 `MainForm.pas`에서 코드로 처리합니다.

---

## 4. 3단계: 실무형 그리드 헬퍼(Grid Helper) 함수 설계

실무에서는 반복적인 컬럼 생성 코드를 줄이기 위해 **전용 헬퍼 함수(Helper Functions)**를 만들어 사용합니다.

### 1) 일반 텍스트 컬럼 추가 함수 (`AddTextColumn`)
```pascal
function AddTextColumn(AView: TcxGridDBTableView; const AFieldName, ACaption: string;
  AWidth: Integer; AAlign: TAlignment = taCenter): TcxGridDBColumn;
begin
  Result := AView.CreateColumn as TcxGridDBColumn;
  Result.DataBinding.FieldName := AFieldName;
  Result.Caption := ACaption;
  Result.Width := AWidth;
  Result.HeaderAlignmentHorz := AAlign;
  Result.PropertiesClass := TcxTextEditProperties;
end;
```

### 2) 체크박스 컬럼 추가 함수 (`AddCheckBoxColumn`)
```pascal
function AddCheckBoxColumn(AView: TcxGridDBTableView; const AFieldName, ACaption: string;
  AWidth: Integer; const ACheckedVal: string = 'Y'; const AUncheckedVal: string = 'N'): TcxGridDBColumn;
var
  Prop: TcxCheckBoxProperties;
begin
  Result := AView.CreateColumn as TcxGridDBColumn;
  Result.DataBinding.FieldName := AFieldName;
  Result.Caption := ACaption;
  Result.Width := AWidth;
  Result.HeaderAlignmentHorz := taCenter;
  
  // 체크박스 속성 생성 및 'Y'/'N' 바인딩
  Result.PropertiesClass := TcxCheckBoxProperties;
  Prop := Result.Properties as TcxCheckBoxProperties;
  Prop.ValueChecked := ACheckedVal;
  Prop.ValueUnchecked := AUncheckedVal;
  Prop.DisplayChecked := ACheckedVal;
  Prop.DisplayUnchecked := AUncheckedVal;
  Prop.NullStyle := nssUnchecked;
end;
```

### 3) 날짜 컬럼 추가 함수 (`AddDateColumn`)
```pascal
function AddDateColumn(AView: TcxGridDBTableView; const AFieldName, ACaption: string;
  AWidth: Integer): TcxGridDBColumn;
begin
  Result := AView.CreateColumn as TcxGridDBColumn;
  Result.DataBinding.FieldName := AFieldName;
  Result.Caption := ACaption;
  Result.Width := AWidth;
  Result.HeaderAlignmentHorz := taCenter;
  Result.PropertiesClass := TcxDateEditProperties;
end;
```

### 4) 하단 Footer 집계 요약 추가 함수 (`AddFooterSummary`)
```pascal
procedure AddFooterSummary(AView: TcxGridDBTableView; AColumn: TcxGridDBColumn;
  AKind: TcxSummaryKind; const AFormat: string);
var
  SummaryItem: TcxGridDBTableSummaryItem;
begin
  AView.OptionsView.Footer := True; // Footer 영역 활성화
  
  SummaryItem := AView.DataController.Summary.FooterSummaryItems.Add as TcxGridDBTableSummaryItem;
  SummaryItem.Column := AColumn;
  SummaryItem.Kind := AKind;
  SummaryItem.Format := AFormat;
end;
```

---

## 5. 4단계: 그리드 초기화 프로시저 작성 (`InitGridColumns`)

위에서 만든 헬퍼 함수들을 이용하면, 8개 컬럼과 요약 설정을 **단 10줄의 깔끔한 코드**로 완성할 수 있습니다!

```pascal
procedure TfrmUserListCode.InitGridColumns;
var
  ColUserName: TcxGridDBColumn;
begin
  // 1. 기존 컬럼 및 요약 설정 초기화
  tvUsers.ClearItems;
  tvUsers.DataController.Summary.FooterSummaryItems.Clear;

  // 2. 그리드 뷰 기본 옵션 설정
  tvUsers.OptionsView.GroupByBox := False;     // 상단 그룹박스 숨김
  tvUsers.OptionsView.Indicator := True;       // 좌측 레코드 인디케이터 표시
  tvUsers.OptionsSelection.CellSelect := True; // 셀 선택 모드
  tvUsers.OptionsView.ColumnAutoWidth := False;// 수동 너비 유지

  // 3. 8개 컬럼 동적 생성 (헬퍼 함수 호출)
  AddTextColumn(tvUsers, 'user_id',    '아이디',   90,  taCenter);
  ColUserName := AddTextColumn(tvUsers, 'user_name',  '성명',     90,  taCenter);
  AddTextColumn(tvUsers, 'department', '부서명',   110, taCenter);
  AddTextColumn(tvUsers, 'position',   '직급',     80,  taCenter);
  AddTextColumn(tvUsers, 'email',      '이메일',   160, taLeftJustify);
  AddTextColumn(tvUsers, 'phone',      '연락처',   120, taCenter);
  AddCheckBoxColumn(tvUsers, 'is_active', '활성여부', 70, 'Y', 'N');
  AddDateColumn(tvUsers, 'created_at', '등록일시', 140);

  // 4. 하단 요약(Footer) 설정 (성명 컬럼에 총 인원수 카운트)
  AddFooterSummary(tvUsers, ColUserName, skCount, '총 사용자: 0명');
end;
```

---

## 6. 5단계: 핵심 전체 소스 코드 구현 (MainForm.pas)

아래 전체 소스코드를 `MainForm.pas`에 작성합니다.

```pascal
unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, ExtCtrls, ComCtrls,
  // DevExpress QuantumGrid 필수 유닛
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, cxCalendar,
  cxTextEdit, cxGridExportLink;

type
  TfrmUserListCode = class(TForm)
    pnlTop: TPanel;
    lblSearch: TLabel;
    edtSearchName: TEdit;
    btnSearch: TButton;
    btnClear: TButton;
    btnExportExcel: TButton;
    statBar: TStatusBar;

    // 데이터 액세스 컴포넌트
    ADOConnection1: TADOConnection;
    qryUsers: TADOQuery;
    dsUsers: TDataSource;

    // 빈 껍데기 그리드 컴포넌트
    cxGrid1: TcxGrid;
    cxGrid1Level1: TcxGridLevel;
    tvUsers: TcxGridDBTableView;

    // 이벤트 핸들러
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSearchClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnExportExcelClick(Sender: TObject);
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
  Result.PropertiesClass := TcxTextEditProperties;
end;

// 2. 체크박스 컬럼 생성 헬퍼
function AddCheckBoxColumn(AView: TcxGridDBTableView; const AFieldName, ACaption: string;
  AWidth: Integer; const ACheckedVal: string = 'Y'; const AUncheckedVal: string = 'N'): TcxGridDBColumn;
var
  Prop: TcxCheckBoxProperties;
begin
  Result := AView.CreateColumn as TcxGridDBColumn;
  Result.DataBinding.FieldName := AFieldName;
  Result.Caption := ACaption;
  Result.Width := AWidth;
  Result.HeaderAlignmentHorz := taCenter;

  Result.PropertiesClass := TcxCheckBoxProperties;
  Prop := Result.Properties as TcxCheckBoxProperties;
  Prop.ValueChecked := ACheckedVal;
  Prop.ValueUnchecked := AUncheckedVal;
  Prop.DisplayChecked := ACheckedVal;
  Prop.DisplayUnchecked := AUncheckedVal;
  Prop.NullStyle := nssUnchecked;
end;

// 3. 날짜 컬럼 생성 헬퍼
function AddDateColumn(AView: TcxGridDBTableView; const AFieldName, ACaption: string;
  AWidth: Integer): TcxGridDBColumn;
begin
  Result := AView.CreateColumn as TcxGridDBColumn;
  Result.DataBinding.FieldName := AFieldName;
  Result.Caption := ACaption;
  Result.Width := AWidth;
  Result.HeaderAlignmentHorz := taCenter;
  Result.PropertiesClass := TcxDateEditProperties;
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
  AddCheckBoxColumn(tvUsers, 'is_active', '활성여부', 70, 'Y', 'N');
  AddDateColumn(tvUsers, 'created_at', '등록일시', 140);

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

procedure TfrmUserListCode.btnExportExcelClick(Sender: TObject);
var
  SaveDlg: TSaveDialog;
begin
  if not qryUsers.Active or (qryUsers.RecordCount = 0) then
  begin
    ShowMessage('엑셀로 저장할 조회 데이터가 없습니다.');
    Exit;
  end;

  SaveDlg := TSaveDialog.Create(Self);
  try
    SaveDlg.Title := '사용자 목록 엑셀 저장';
    SaveDlg.Filter := 'Excel Files (*.xls)|*.xls';
    SaveDlg.FileName := 'UserList_' + FormatDateTime('yyyymmdd', Now) + '.xls';
    if SaveDlg.Execute then
    begin
      ExportGridToExcel(SaveDlg.FileName, cxGrid1, True, True, True, 'xls');
      ShowMessage('엑셀 저장이 완료되었습니다: ' + SaveDlg.FileName);
    end;
  finally
    SaveDlg.Free;
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
```

---

## 7. 💡 [필독] 소스 코드 복사/붙여넣기 후 필수 작업: 이벤트 연결 (Events 탭)

> [!CAUTION]
> **"코드를 그대로 복사해서 붙여넣었는데 `FormCreate`나 버튼 클릭 시 아무 반응이 없어요!"**  
> 델파이에서는 소스 코드(`.pas`)에 함수를 작성해 넣는 것만으로는 이벤트가 실행되지 않습니다!  
> 반드시 화면의 컴포넌트와 소스 코드의 함수를 연결(Event Binding)해주어야 합니다.

### 🔍 왜 이벤트가 실행되지 않을까요?
델파이는 **`.dfm`(폼 디자인 파일)**과 **`.pas`(소스 코드)**가 짝을 이룹니다.  
코드를 복사해서 붙여넣기만 하면, 폼의 `OnCreate`나 버튼의 `OnClick` 속성이 **비어있는 상태(`nil`)**로 남아있기 때문에 폼이 실행되어도 코드를 호출하지 못합니다.

---

### 🛠️ Object Inspector의 `Events` 탭에서 연결하는 방법 (30초 완료!)

1. 델파이 화면에서 **연결할 컨트롤(폼 바탕, 버튼 등)**을 클릭합니다.
2. 좌측 **Object Inspector (단축키 `F11`)**에서 상단의 **`Events` 탭**을 클릭합니다.
3. 해당 이벤트 항목 우측의 **드롭다운 화살표(▼)**를 누르면 이미 작성해둔 함수 이름이 나타납니다. 이를 선택합니다!

```
[Object Inspector 창의 Events 탭 설정 예시]
┌─────────────────────────────────────────────────────────────┐
│ frmUserListCode : TfrmUserListCode (폼 바탕 클릭 시)        │
├─────────────────────────────────────────────────────────────┤
│ Properties  [Events]  <-- Events 탭 클릭!                    │
├─────────────────────────────────────────────────────────────┤
│ OnActivate                                                  │
│ OnClick                                                     │
│ OnClose      FormClose            <-- 드롭다운에서 선택!     │
│ OnCreate     FormCreate           <-- 드롭다운에서 선택! ⭐  │
│ OnDestroy                                                   │
└─────────────────────────────────────────────────────────────┘
```

---

### 📋 본 실습 필수 이벤트 연결 목록표

아래 표를 보고 각 컴포넌트를 클릭한 후 `Events` 탭에서 알맞은 함수를 지정해주세요:

| 컴포넌트 선택 (클릭) | Events 탭 항목 | 드롭다운에서 선택할 이벤트 함수 | 설명 |
| :--- | :--- | :--- | :--- |
| **폼 빈 바탕** (`frmUserListCode`) | **`OnCreate`** | **`FormCreate`** | 실행 시 그리드 컬럼 생성 및 DB 연결 |
| **폼 빈 바탕** (`frmUserListCode`) | **`OnClose`** | **`FormClose`** | 종료 시 쿼리 및 DB 연결 해제 |
| **`btnSearch`** (조회 버튼) | **`OnClick`** | **`btnSearchClick`** | 버튼 클릭 시 사용자 조회 쿼리 실행 |
| **`btnClear`** (초기화 버튼) | **`OnClick`** | **`btnClearClick`** | 버튼 클릭 시 조회 목록 초기화 |
| **`btnExportExcel`** (엑셀 버튼) | **`OnClick`** | **`btnExportExcelClick`** | 그리드 내용을 XLS 파일로 저장 |
| **`tvUsers`** (그리드 DB 뷰) | **`OnCustomDrawCell`**| **`tvUsersCustomDrawCell`**| 비활성 회원 회색 텍스트 강조 |

> [!TIP]
> **실무 꿀팁: 이벤트가 풀리지 않게 작성하는 요령**  
> 다음부터 새 프로젝트를 만들 때는 코드를 먼저 붙여넣지 말고:
> 1. 폼 바탕을 **더블 클릭** ➔ IDE가 `OnCreate` 이벤트 연결과 함수 껍데기를 자동 생성
> 2. 버튼을 **더블 클릭** ➔ IDE가 `OnClick` 이벤트 연결과 함수 껍데기를 자동 생성
> 3. 그 후 `begin ... end` 사이에 내부 로직(`InitGridColumns;`, `InitDBConnection;` 등)만 복사해 넣으면 이벤트가 절대 풀리지 않습니다!

---

## 8. 7단계: 실행 및 단계별 기능 검증

1. 델파이 7에서 **`F9`** 키를 눌러 실행합니다.
2. **동작 검증 포인트**:
   - [x] **디자인타임 vs 런타임**: 디자인타임에는 빈 그리드였지만, 실행 즉시 8개 한글 헤더 컬럼과 하단 Footer가 코드로 깔끔하게 나타나는지 확인합니다.
   - [x] **[🔍 사용자 조회]**: 버튼 클릭 시 SQL Server의 `users` 테이블 데이터 8건이 로드되고 체크박스가 정상 작동하는지 확인합니다.
   - [x] **조건 검색 & 엔터키**: 성명 검색창에 `김` 입력 후 `Enter`를 누르면 즉시 필터링 조회되는지 확인합니다.
   - [x] **엑셀 내보내기**: `[📊 엑셀 저장]` 버튼 클릭 시 `.xls` 파일로 내보내기가 정상 수행되는지 확인합니다.

---

## 9. 8단계: 실무 심화 테크닉 (권한별 동적 컬럼 제어 & 팀 협업 노하우)

### 💡 1. 사용자 권한에 따른 동적 컬럼 표시/숨김
실무에서는 관리자(`Admin`)에게만 민감한 컬럼(예: 급여, 주민번호)을 보여주어야 하는 경우가 많습니다. PAS 코드 방식에서는 조건문 하나로 간단하게 처리됩니다:

```pascal
// 로그인 사용자가 관리자일 때만 '급여' 컬럼을 동적으로 추가
if FCurrentUserRole = 'ADMIN' then
begin
  AddCurrencyColumn(tvUsers, 'salary', '기본급', 100);
end;
```

### 💡 2. 컬럼명(FieldName)으로 컬럼 객체 안전하게 찾기
Object Inspector에서 컬럼을 생성하지 않으면 `tvUsersuser_id` 같은 컴포넌트 변수가 선언부에 생성되지 않습니다. 대신 **`GetColumnByFieldName`** 메서드를 사용하면 언제 어디서든 컬럼을 안전하게 제어할 수 있습니다:

```pascal
var
  Col: TcxGridDBColumn;
begin
  Col := tvUsers.GetColumnByFieldName('email') as TcxGridDBColumn;
  if Col <> nil then
  begin
    Col.Visible := False; // 런타임에 이메일 컬럼 숨기기
  end;
end;
```

### 💡 3. 팀 프로젝트 Git 협업 팁
* 실무에서 팀원들과 델파이 프로젝트를 협업할 때는 `.dfm`에 폰트 크기, 컬럼 세부 속성을 넣지 말고 본 실습처럼 **모든 그리드 세팅을 `InitGridColumns` 프로시저 안에 몰아서 작성**하세요.
* Git Merge 충돌이 90% 이상 줄어들며, 코드 리뷰 시에도 어떤 컬럼이 추가되고 변경되었는지 명확하게 추적할 수 있습니다.
