# DevExpress QuantumGrid (TcxGrid) 단계별 실습 가이드 2편: MS SQL Server DB 연동 & Users 테이블 조회 🚀

이 문서는 델파이 7(Delphi 7) 환경에서 **MS SQL Server Express** 데이터베이스에 연결하여 `users` 테이블의 데이터를 조회하고, 3rd Party 그리드 표준인 **DevExpress QuantumGrid (`TcxGrid`)**에 바인딩하여 화면에 깔끔하게 출력하는 과정을 기초부터 하나씩 따라 할 수 있도록 정리한 튜토리얼입니다.

---

## 📌 목차
1. [실습 개요 및 환경 정보](#1-실습-개요-및-환경-정보)
2. [1단계: MS SQL Server 데이터베이스 & 테이블 구축 (DDL/DML)](#2-1단계-ms-sql-server-데이터베이스--테이블-구축-ddldml)
3. [2단계: 델파이 7 프로젝트 생성 및 화면 컨트롤 배치](#3-2단계-델파이-7-프로젝트-생성-및-화면-컨트롤-배치)
4. [3단계: ADO 컴포넌트 구성 (TADOConnection, TADOQuery, TDataSource)](#4-3단계-ado-컴포넌트-구성-tadoconnection-tadoquery-tdatasource)
5. [5단계: TcxGrid 데이터 바인딩 및 컬럼 커스터마이징](#5-4단계-tcxgrid-데이터-바인딩-및-컬럼-커스터마이징)
6. [6단계: 핵심 소스 코드 구현 (MainForm.pas)](#6-5단계-핵심-소스-코드-구현-mainformpas)
7. [7단계: 실행 및 단계별 기능 검증](#7-6단계-실행-및-단계별-기능-검증)
8. [8단계: 실무 트러블슈팅 & 핵심 팁](#8-7단계-실무-트러블슈팅--핵심-팁)

---

## 1. 실습 개요 및 환경 정보

이번 실습에서는 `TADOConnection`과 `TADOQuery`를 이용해 실제 SQL Server와 통신하고, `[조회]` 버튼 클릭 시 `users` 테이블의 목록을 `TcxGrid`에 즉시 표출합니다.

### 📋 접속 환경 정보
| 항목 | 설정 값 | 비고 |
| :--- | :--- | :--- |
| **DBMS** | Microsoft SQL Server (Express) | `localhost\SQLEXPRESS` |
| **데이터베이스명** | `DELPHI7_DB` | 없으면 신규 생성 |
| **인증 방식** | SQL Server 인증 (SQL Server Authentication) | |
| **접속 계정 (ID)** | `sa` | 시스템 관리자 계정 |
| **접속 암호 (PW)** | `doolman` | |
| **테이블명** | `dbo.users` | 사용자 정보 테이블 |

---

## 2. 1단계: MS SQL Server 데이터베이스 & 테이블 구축 (DDL/DML)

SSMS(SQL Server Management Studio) 또는 `sqlcmd`를 열고 아래 SQL 스크립트를 복사하여 실행합니다.

```sql
-- =========================================================
-- 1. 데이터베이스 생성 (DELPHI7_DB)
-- =========================================================
USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'DELPHI7_DB')
BEGIN
    CREATE DATABASE [DELPHI7_DB];
    PRINT 'DELPHI7_DB 데이터베이스가 생성되었습니다.';
END
GO

USE [DELPHI7_DB];
GO

-- =========================================================
-- 2. users 테이블 생성
-- =========================================================
IF OBJECT_ID('dbo.users', 'U') IS NOT NULL 
    DROP TABLE dbo.users;
GO

CREATE TABLE dbo.users (
    user_id     VARCHAR(20)   NOT NULL,         -- 사용자 아이디 (PK)
    user_name   NVARCHAR(50)  NOT NULL,         -- 성명
    department  NVARCHAR(50)  NOT NULL,         -- 부서명
    position    NVARCHAR(30)  NULL,             -- 직급
    email       VARCHAR(100)  NULL,             -- 이메일
    phone       VARCHAR(20)   NULL,             -- 연락처
    is_active   CHAR(1)       DEFAULT 'Y' NOT NULL, -- 활성여부 (Y/N)
    created_at  DATETIME      DEFAULT GETDATE() NOT NULL, -- 등록일시
    CONSTRAINT PK_users PRIMARY KEY CLUSTERED (user_id)
);
GO

-- =========================================================
-- 3. 샘플 데이터 8건 INSERT
-- =========================================================
INSERT INTO dbo.users (user_id, user_name, department, position, email, phone, is_active, created_at)
VALUES 
('admin',     N'최고관리자', N'전산운영팀', N'팀장',   'admin@company.com',   '010-1111-2222', 'Y', '2023-01-01 09:00:00'),
('kcs77',     N'김철수',     N'IT개발팀',   N'수석',   'cs.kim@company.com',  '010-2345-6789', 'Y', '2023-03-15 10:30:00'),
('lee_yh',    N'이영희',     N'IT개발팀',   N'선임',   'yh.lee@company.com',  '010-3456-7890', 'Y', '2023-07-01 11:20:00'),
('park_ms',   N'박민수',     N'영업기획팀', N'차장',   'ms.park@company.com', '010-4567-8901', 'Y', '2024-01-10 14:00:00'),
('jung_sj',   N'정수진',     N'영업기획팀', N'대리',   'sj.jung@company.com', '010-5678-9012', 'Y', '2024-02-15 16:45:00'),
('choi_dh',   N'최동현',     N'인사총무팀', N'과장',   'dh.choi@company.com', '010-6789-0123', 'Y', '2024-05-20 09:15:00'),
('kang_nr',   N'강나래',     N'인사총무팀', N'사원',   'nr.kang@company.com', '010-7890-1234', 'N', '2024-08-01 13:30:00'),
('hong_gd',   N'홍길동',     N'품질관리팀', N'주임',   'gd.hong@company.com', '010-8901-2345', 'Y', '2024-09-12 15:10:00');
GO

-- 4. 생성 확인
SELECT COUNT(*) AS [users_총건수] FROM dbo.users;
SELECT * FROM dbo.users;
GO
```

---

## 3. 2단계: 델파이 7 프로젝트 생성 및 화면 컨트롤 배치

1. 델파이 7 실행 ➔ **`File` ➔ `New` ➔ `Application`**
2. 메인 폼(`Form1`) 속성 설정:
   - `Name`: `frmUserList`
   - `Caption`: `QuantumGrid(TcxGrid) MS SQL DB 연동 실습`
   - `Width`: `960`, `Height`: `640`
   - `Position`: `poScreenCenter`

3. 컨트롤 배치:

```
+-----------------------------------------------------------------------------------+
| frmUserList                                                             [_][O][X] |
+-----------------------------------------------------------------------------------+
| [pnlTop (Align: alTop, Height: 55)]                                               |
|  [ 성명 검색: ] [ edtSearchName ]  [🔍 사용자 조회 (btnSearch)]  [ 엑셀 저장 ]       |
+-----------------------------------------------------------------------------------+
| [cxGrid1 (Align: alClient)]                                                       |
|  +------------------------------------------------------------------------------+ |
|  | 아이디 | 성명   | 부서명     | 직급 | 이메일            | 연락처      | 활성  | |
|  +--------+--------+------------+------+-------------------+-------------+------+ |
|  | admin  | 관리자 | 전산운영팀 | 팀장 | admin@company.com | 010-1111... | [V]  | |
|  | kcs77  | 김철수 | IT개발팀   | 수석 | cs.kim@company.com| 010-2345... | [V]  | |
|  +------------------------------------------------------------------------------+ |
|  | Footer: 총 사용자: 8명                                                         | |
+-----------------------------------------------------------------------------------+
| [statBar (Align: alBottom) - 상태: DB 연결 대기 / 조회 결과 건수 표시]              |
+-----------------------------------------------------------------------------------+
```

### 배치 컨트롤 상세 속성표
| 탭 (Palette) | 컨트롤 타입 | Name | 주요 속성 설정 |
| :--- | :--- | :--- | :--- |
| `Standard` | `TPanel` | `pnlTop` | `Align: alTop`, `Height: 55`, `Caption: ''` |
| `Standard` | `TLabel` | `lblSearch` | `Caption: '성명 검색:'`, `Left: 16`, `Top: 18` |
| `Standard` | `TEdit` | `edtSearchName` | `Text: ''`, `Left: 80`, `Top: 14`, `Width: 120` |
| `Standard` | `TButton` | `btnSearch` | `Caption: '🔍 사용자 조회'`, `Left: 210`, `Top: 12`, `Height: 30` |
| `Standard` | `TButton` | `btnClear` | `Caption: '초기화'`, `Left: 320`, `Top: 12`, `Height: 30` |
| `Standard` | `TButton` | `btnExportExcel` | `Caption: '📊 엑셀 저장'`, `Left: 400`, `Top: 12`, `Height: 30` |
| `Win32` | `TStatusBar` | `statBar` | `Align: alBottom`, `SimplePanel: True` |

---

## 4. 3단계: ADO 컴포넌트 구성 (TADOConnection, TADOQuery, TDataSource)

데이터베이스 통신을 담당하는 3대 데이터 액세스 컴포넌트를 폼 위에 올려놓습니다.

1. **컴포넌트 배치**:
   - `ADO` 탭 ➔ **`TADOConnection`** 배치 (Name: `ADOConnection1`)
   - `ADO` 탭 ➔ **`TADOQuery`** 배치 (Name: `qryUsers`)
   - `Data Access` 탭 ➔ **`TDataSource`** 배치 (Name: `dsUsers`)

2. **컴포넌트 속성 연결**:
   - `ADOConnection1`:
     - `LoginPrompt`: `False` (접속 시 다이얼로그 창 팝업 방지)
     - `KeepConnection`: `True`
   - `qryUsers`:
     - `Connection`: `ADOConnection1`
   - `dsUsers`:
     - `DataSet`: `qryUsers`

3. **연결 문자열(ConnectionString) 설정**:
   - 런타임에 소스 코드로 직접 연결하거나, 디자인타임에 `ADOConnection1.ConnectionString`에 아래 문자열을 입력합니다:
   ```text
   Provider=SQLOLEDB.1;Data Source=localhost\SQLEXPRESS;Initial Catalog=DELPHI7_DB;User ID=sa;Password=doolman;Persist Security Info=True
   ```
   > [!TIP]
   > 델파이 디자인타임에서 `ADOConnection1.Connected := True`로 설정했을 때 에러 없이 연결되면 정상입니다. (배포 시에는 소스 코드의 `FormCreate`에서 동적으로 연결하는 방식을 추천합니다.)

---

## 5. 4단계: TcxGrid 데이터 바인딩 및 컬럼 커스터마이징

1. **그리드 배치**:
   - `ExpressQuantumGrid` 탭 ➔ **`TcxGrid`** 배치 (Name: `cxGrid1`)
   - `cxGrid1.Align`: `alClient`

2. **DB TableView 생성**:
   - `cxGrid1`의 레벨 구조 창에서 `cxGrid1Level1`을 선택합니다.
   - Object Inspector에서 `GridView` 속성의 콤보박스를 눌러 **`TcxGridDBTableView`**를 선택합니다.
   - 생성된 View의 이름을 **`tvUsers`**로 변경합니다.

3. **데이터 소스 바인딩**:
   - `tvUsers`를 선택하고 `DataController.DataSource` 속성을 **`dsUsers`**로 지정합니다.

4. **컬럼 자동 생성 (`Create All Items`)**:
   - `qryUsers.SQL.Text`에 `SELECT * FROM users`를 임시 입력하고 `qryUsers.Active := True`로 설정합니다.
   - `tvUsers`를 마우스 우클릭 ➔ **`Create All Items`**를 클릭합니다!
   - `user_id`, `user_name`, `department`, `position`, `email`, `phone`, `is_active`, `created_at` 컬럼이 자동 생성됩니다.

5. **컬럼 속성 다듬기 (Object Inspector)**:

| 컬럼 Name | DataBinding.FieldName | Caption (한글) | Width | HeaderAlignmentHorz | PropertiesClass |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `tvUsersuser_id` | `user_id` | `아이디` | `90` | `taCenter` | `TcxTextEditProperties` |
| `tvUsersuser_name` | `user_name` | `성명` | `90` | `taCenter` | `TcxTextEditProperties` |
| `tvUsersdepartment`| `department` | `부서명` | `110` | `taCenter` | `TcxTextEditProperties` |
| `tvUsersposition`  | `position` | `직급` | `80` | `taCenter` | `TcxTextEditProperties` |
| `tvUsersemail`     | `email` | `이메일` | `160` | `taLeftJustify` | `TcxTextEditProperties` |
| `tvUsersphone`     | `phone` | `연락처` | `120` | `taCenter` | `TcxTextEditProperties` |
| `tvUsersis_active` | `is_active` | `활성여부` | `70` | `taCenter` | `TcxCheckBoxProperties` |
| `tvUserscreated_at`| `created_at` | `등록일시` | `140` | `taCenter` | `TcxDateEditProperties` |

> [!NOTE]
> `tvUsersis_active` 컬럼에 `TcxCheckBoxProperties`를 지정한 후:
> - `Properties.ValueChecked`: `'Y'`
> - `Properties.ValueUnchecked`: `'N'`
> 으로 설정하면 그리드 상에서 체크박스 형태로 깔끔하게 표시됩니다.

6. **그리드 하단 Footer 요약 설정**:
   - `tvUsers.OptionsView.Footer`: `True`
   - `tvUsers.DataController.Summary.FooterSummaryItems`에 항목 추가:
     - `Column`: `tvUsersuser_name`
     - `Kind`: `skCount`
     - `Format`: `'총 사용자: 0명'`

---

## 6. 5단계: 핵심 소스 코드 구현 (MainForm.pas)

전체 소스 코드 구현 내용입니다. `uses` 절에 `cxGridExportLink`를 포함해 엑셀 내보내기를 지원합니다.

```pascal
unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, ExtCtrls, ComCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, cxCalendar,
  cxTextEdit, cxGridExportLink;

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
    
    // QuantumGrid 컴포넌트
    cxGrid1: TcxGrid;
    cxGrid1Level1: TcxGridLevel;
    tvUsers: TcxGridDBTableView;
    tvUsersuser_id: TcxGridDBColumn;
    tvUsersuser_name: TcxGridDBColumn;
    tvUsersdepartment: TcxGridDBColumn;
    tvUsersposition: TcxGridDBColumn;
    tvUsersemail: TcxGridDBColumn;
    tvUsersphone: TcxGridDBColumn;
    tvUsersis_active: TcxGridDBColumn;
    tvUserscreated_at: TcxGridDBColumn;

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
    procedure ExecuteQuery(const ASearchName: string);
  public
    { Public declarations }
  end;

var
  frmUserList: TfrmUserList;

implementation

{$R *.dfm}

{-------------------------------------------------------------------------------
  1. 폼 생성 시 DB 커넥션 초기화
-------------------------------------------------------------------------------}
procedure TfrmUserList.FormCreate(Sender: TObject);
begin
  statBar.SimpleText := 'DB 연결 시도 중...';
  InitDBConnection;
  
  // 엔터키 검색 지원
  edtSearchName.OnKeyPress := edtSearchNameKeyPress;
end;

procedure TfrmUserList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if qryUsers.Active then
    qryUsers.Close;
  if ADOConnection1.Connected then
    ADOConnection1.Connected := False;
end;

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
  4. [🔍 사용자 조회] 버튼 클릭 이벤트
-------------------------------------------------------------------------------}
procedure TfrmUserList.btnSearchClick(Sender: TObject);
begin
  ExecuteQuery(edtSearchName.Text);
end;

{-------------------------------------------------------------------------------
  5. 검색창 엔터키 입력 시 자동 조회
-------------------------------------------------------------------------------}
procedure TfrmUserList.edtSearchNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0; // 삐- 소리 방지
    btnSearch.Click;
  end;
end;

{-------------------------------------------------------------------------------
  6. [초기화] 버튼 클릭 이벤트
-------------------------------------------------------------------------------}
procedure TfrmUserList.btnClearClick(Sender: TObject);
begin
  qryUsers.Close;
  edtSearchName.Text := '';
  statBar.SimpleText := '조회 화면이 초기화되었습니다.';
end;

{-------------------------------------------------------------------------------
  7. [📊 엑셀 저장] 버튼 클릭 이벤트 (ExportGridToExcel)
-------------------------------------------------------------------------------}
procedure TfrmUserList.btnExportExcelClick(Sender: TObject);
var
  SaveDlg: TSaveDialog;
begin
  if not qryUsers.Active or (qryUsers.RecordCount = 0) then
  begin
    ShowMessage('엑셀로 내보낼 데이터가 없습니다. 먼저 조회를 진행해주세요.');
    Exit;
  end;

  SaveDlg := TSaveDialog.Create(Self);
  try
    SaveDlg.Title := '사용자 목록 엑셀 파일 저장';
    SaveDlg.Filter := 'Excel Files (*.xls)|*.xls';
    SaveDlg.FileName := 'UserList_' + FormatDateTime('yyyymmdd', Now) + '.xls';
    
    if SaveDlg.Execute then
    begin
      // TcxGrid의 뷰를 직접 엑셀 파일로 고속 변환
      ExportGridToExcel(SaveDlg.FileName, cxGrid1, True, True, True, 'xls');
      ShowMessage('엑셀 파일 저장이 완료되었습니다!'#13#10 + SaveDlg.FileName);
    end;
  finally
    SaveDlg.Free;
  end;
end;

{-------------------------------------------------------------------------------
  8. 조건부 셀 그리기 (비활성 'N' 회원은 텍스트 회색 처리)
-------------------------------------------------------------------------------}
procedure TfrmUserList.tvUsersCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
var
  ActiveVal: Variant;
begin
  // is_active 컬럼의 레코드 값을 검사
  ActiveVal := AViewInfo.GridRecord.Values[tvUsersis_active.Index];
  if not VarIsNull(ActiveVal) and (VarToStr(ActiveVal) = 'N') then
  begin
    // 비활성 사용자는 글자색을 회색으로 흐리게 표시
    ACanvas.Font.Color := clGray;
  end;
end;

end.
```

---

## 7. 6단계: 실행 및 단계별 기능 검증

1. 델파이 7에서 **`F9`** 키를 눌러 컴파일 및 실행합니다.
2. **기능 검증 체크리스트**:
   - [x] **DB 연결 상태 확인**: 프로그램 실행 직후 하단 상태바(`statBar`)에 `DB 연결 성공: localhost\SQLEXPRESS` 메시지가 출력되는지 확인합니다.
   - [x] **전체 목록 조회**: `[🔍 사용자 조회]` 버튼을 누르면 `users` 테이블의 8건 목록이 `TcxGrid`에 즉시 로드되는지 확인합니다.
   - [x] **Footer 요약 건수**: 그리드 하단 Footer 영역에 `총 사용자: 8명`이 정상 표시되는지 확인합니다.
   - [x] **키워드 조건 검색**: 검색창에 `김` 또는 `이`를 입력하고 엔터를 치거나 조회 버튼을 누르면 해당 성명의 사용자만 필터링되어 출력되는지 확인합니다.
   - [x] **체크박스 렌더링**: `활성여부` 컬럼에 `Y`는 체크(V), `N`은 빈 네모(공백)로 표시되는지 확인합니다.
   - [x] **엑셀 내보내기**: `[📊 엑셀 저장]` 버튼을 누르고 파일 경로를 지정해 `.xls` 파일이 정상 생성되고 엑셀에서 열리는지 확인합니다.

---

## 8. 7단계: 실무 트러블슈팅 & 핵심 팁

### 💡 1. `localhost\SQLEXPRESS` 접속 에러 시 점검 사항
1. **SQL Server 서비스 동작 확인**:
   - `Win + R` ➔ `services.msc` 실행
   - `SQL Server (SQLEXPRESS)` 서비스가 **실행 중(Running)**인지 확인합니다.
2. **TCP/IP 프로토콜 활성화**:
   - `SQL Server 구성 관리자(SQL Server Configuration Manager)` 실행
   - `SQL Server 네트워크 구성` ➔ `SQLEXPRESS의 프로토콜` ➔ `TCP/IP` 상태를 **사용(Enabled)**으로 변경 후 서비스 재시작.
3. **혼합 모드 인증(Mixed Mode Authentication)**:
   - `sa` 계정으로 접속하려면 SQL Server 속성에서 인증 모드가 **'SQL Server 및 Windows 인증 모드'**로 설정되어 있어야 합니다.

### 💡 2. 파라미터 쿼리(Prepared Statement) 필수 사용
- 사용자의 입력값을 SQL 문자열에 직접 더하는 방식(`WHERE user_name = '''' + edtSearchName.Text + ''''`)은 **SQL Injection 공격에 취약**하며 특수문자(`'`) 입력 시 에러가 발생합니다.
- 본 실습과 같이 반드시 `:SearchName` 형태의 파라미터를 사용하세요:
  ```pascal
  qryUsers.Parameters.ParamByName('SearchName').Value := '%' + Trim(ASearchName) + '%';
  ```

### 💡 3. DisableControls / EnableControls 패턴
- 대량의 데이터를 `TADOQuery`로 오픈할 때 그리드와 컨트롤이 매 행마다 리페인트(Repaint)되면 속도가 느려집니다.
- 조회 쿼리 실행 전 `qryUsers.DisableControls;`를 호출하고 `try ... finally` 블록에서 `qryUsers.EnableControls;`를 실행하면 초고속 데이터 렌더링이 가능합니다.
