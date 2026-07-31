# 14. DevExpress TcxGrid + MS SQL Server 게시판(BBS) CRUD & 페이징 실습 데모 📋

이 예제는 **MS SQL Server** 데이터베이스와 델파이 ADO(`TADOConnection`, `TADOQuery`), 그리고 **DevExpress QuantumGrid (`TcxGrid`)**를 연동하여 완전한 **게시판 CRUD (신규, 조회, 수정, 삭제)** 및 **서버 사이드 페이징(SQL Paging)**, 그리고 **`dbconfig.ini` 외부 파일 연동** 기능을 구현한 실무 응용 프로젝트입니다.

---

## 💡 웹 vs 델파이(C/S) 페이징(Paging)의 차이 및 구현 방식

### 1. 왜 웹과 델파이의 페이징 방식이 다를까요?
* **웹(Web)**: 무상태(Stateless) HTTP 환경입니다. 10만 건의 HTML 테이블 요소를 브라우저 DOM에 그리게 되면 메모리 과부하로 브라우저가 다운되므로 **페이지당 10~20건씩 잘라서 서버에서 전달받는 서버 페이징(SQL Paging)**이 필수입니다.
* **델파이(Client/Server)**: 데스크톱 애플리케이션(Stateful)입니다. `TcxGrid`는 1만~10만 건의 데이터를 메모리에 통째로 로딩해도 수 밀리초 만에 초고속 정렬, 필터링, 그룹핑이 가능합니다.

---

### 2. 델파이 C/S 실무에서 페이징을 구현하는 3가지 대표 기법

| 방식 | 설명 | 장점 | 단점 / 적합한 상황 |
| :--- | :--- | :--- | :--- |
| **① 메모리 일괄 로딩** | `SELECT TOP 1000 *` 또는 최근 1~3개월 데이터 전체 로드 | 엑셀처럼 실시간 클릭 필터링, 정렬, 부서별 그룹핑 가능 | 데이터가 수십만 건 이상일 때 초기 조회 속도 저하 |
| **② SQL 서버 페이징 (본 예제)** | `WITH CTE` 및 `ROW_NUMBER()` / `OFFSET...FETCH` 쿼리 활용 | 백만 건 이상의 데이터도 서버 메모리/네트워크 부담 최소화 | 10건씩만 로딩되므로 그리드 자체 전체 그룹핑 제한 |
| **③ DevExpress `GridMode`** | `tvBoard.DataController.DataModeController.GridMode := True` | 스크롤을 내릴 때마다 50건씩 자동으로 DB에서 추가 인출 | DB 커서 연결 유지 필요 |

---

## ⚙️ 1. `dbconfig.ini` 외부 설정 파일 연동

프로그램 실행 시 EXE 경로의 `dbconfig.ini` 파일에서 DB 연결 정보를 동적으로 읽어옵니다. 파일이 존재하지 않는 경우 자동으로 기본 템플릿 파일이 생성됩니다.

```ini
[DATABASE]
Provider=SQLOLEDB.1
Server=127.0.0.1
Port=1433
Database=master
UserID=sa
Password=sa
IntegratedSecurity=False
```

---

## 🗄️ 2. MS SQL Server 테이블 생성 스크립트 (`schema.sql`)

프로젝트 내 [`schema.sql`](file:///h:/lee/delphi7-notes/examples/14_DevExpressMSSQLBBSDemo/schema.sql) 파일을 SSMS(SQL Server Management Studio)에서 실행하여 테이블을 생성합니다.

```sql
CREATE TABLE dbo.TB_BOARD (
    BoardID     INT IDENTITY(1,1) NOT NULL, -- 게시글 고유 번호 (PK)
    Title       NVARCHAR(200) NOT NULL,      -- 글 제목
    Content     NVARCHAR(MAX) NULL,          -- 글 내용
    WriterName  NVARCHAR(50)  NOT NULL,      -- 작성자 이름
    ViewCount   INT DEFAULT 0 NOT NULL,      -- 조회수
    IsNotice    BIT DEFAULT 0 NOT NULL,      -- 공지사항 여부 (1: 공지, 0: 일반)
    RegDate     DATETIME DEFAULT GETDATE() NOT NULL, -- 등록일시
    ModDate     DATETIME NULL,               -- 수정일시
    CONSTRAINT PK_TB_BOARD PRIMARY KEY CLUSTERED (BoardID)
);
```

---

## 💻 3. 핵심 구현 알고리즘 해설

### ① SQL Server CTE + `ROW_NUMBER()` 기반 서버 페이징 쿼리 (`MainForm.pas`)
SQL Server 2005 ~ 2022 모든 버전에서 지원되는 안전하고 빠른 페이징 쿼리입니다.

```pascal
procedure TfrmMain.LoadBoardData;
var
  PageSize, StartRow, EndRow: Integer;
begin
  PageSize := GetPageSize;
  StartRow := ((FCurrentPage - 1) * PageSize) + 1;
  EndRow := FCurrentPage * PageSize;

  qryBoard.Close;
  qryBoard.SQL.Text :=
    'WITH PagedBoard AS (' +
    '  SELECT BoardID, Title, Content, WriterName, ViewCount, IsNotice, RegDate, ' +
    '         ROW_NUMBER() OVER (ORDER BY IsNotice DESC, BoardID DESC) AS RowNum ' +
    '  FROM dbo.TB_BOARD ' +
    '  WHERE (:Search1 = '''' OR Title LIKE ''%'' + :Search2 + ''%'' OR WriterName LIKE ''%'' + :Search3 + ''%'') ' +
    ') ' +
    'SELECT BoardID, Title, Content, WriterName, ViewCount, IsNotice, RegDate ' +
    'FROM PagedBoard ' +
    'WHERE RowNum BETWEEN :StartRow AND :EndRow ' +
    'ORDER BY RowNum ASC';

  qryBoard.Parameters.ParamByName('Search1').Value := SearchKeyword;
  qryBoard.Parameters.ParamByName('Search2').Value := SearchKeyword;
  qryBoard.Parameters.ParamByName('Search3').Value := SearchKeyword;
  qryBoard.Parameters.ParamByName('StartRow').Value := StartRow;
  qryBoard.Parameters.ParamByName('EndRow').Value := EndRow;
  qryBoard.Open;
end;
```

---

### ② 게시판 CRUD 구현 

1. **Create (글쓰기)**:
   - `btnAddClick` ➔ `BoardEditForm` 모달 생성 (`InitForm(bmInsert, 0, ADOConnection1)`)
   - `INSERT INTO dbo.TB_BOARD (Title, Content, WriterName, IsNotice, RegDate) ...`

2. **Read (목록 & 상세보기)**:
   - 그리드 더블클릭(`tvBoardDblClick`) 시 해당 글의 `ViewCount`를 1 증가시키고 상세보기 모달 열기 (`InitForm(bmView, BoardID, ADOConnection1)`)

3. **Update (글수정)**:
   - `btnEditClick` ➔ `InitForm(bmEdit, BoardID, ADOConnection1)` 모달 열기
   - `UPDATE dbo.TB_BOARD SET Title = :Title, Content = :Content, ModDate = GETDATE() WHERE BoardID = :ID`

4. **Delete (글삭제)**:
   - `btnDeleteClick` ➔ `MessageDlg` 삭제 확인창 팝업 ➔ `DELETE FROM dbo.TB_BOARD WHERE BoardID = :ID`

---

## 📂 파일 구성
* [`dbconfig.ini.template`](file:///h:/lee/delphi7-notes/examples/14_DevExpressMSSQLBBSDemo/dbconfig.ini.template): DB 접속 설정 파일 템플릿
* [`schema.sql`](file:///h:/lee/delphi7-notes/examples/14_DevExpressMSSQLBBSDemo/schema.sql): MS SQL Server DDL 테이블 생성 & 샘플 데이터 스크립트
* [`DevExpressMSSQLBBSDemo.dpr`](file:///h:/lee/delphi7-notes/examples/14_DevExpressMSSQLBBSDemo/DevExpressMSSQLBBSDemo.dpr): 델파이 메인 프로젝트 파일
* [`MainForm.pas`](file:///h:/lee/delphi7-notes/examples/14_DevExpressMSSQLBBSDemo/MainForm.pas) / [`MainForm.dfm`](file:///h:/lee/delphi7-notes/examples/14_DevExpressMSSQLBBSDemo/MainForm.dfm): 메인 게시판 목록 & 페이징 툴바 폼
* [`BoardEditForm.pas`](file:///h:/lee/delphi7-notes/examples/14_DevExpressMSSQLBBSDemo/BoardEditForm.pas) / [`BoardEditForm.dfm`](file:///h:/lee/delphi7-notes/examples/14_DevExpressMSSQLBBSDemo/BoardEditForm.dfm): 글쓰기/수정/상세보기 모달 폼
