# 16. DevExpress TcxGrid 상하 분할 (Split-Panel) 마스터-디테일 데모

이 예제는 기업형 C/S 입력 및 연동 업무에서 가장 많이 사용하는 **[상하 분할 패널(TSplitter)]** 레이아웃과 **[Master-Detail 실시간 쿼리 연동]** 패턴을 실습하는 프로젝트입니다.

---

## 1. 실무 분할 그리드 연동 원칙

1. **`TSplitter` 분할 레이아웃**:
   - 상단 패널(`pnlMaster`)과 하단 패널(`pnlDetail`) 사이에 `TSplitter` 컴포넌트를 배치하여 사용자가 마우스 드래그로 그리드 높이를 자유롭게 조절할 수 있습니다.

2. **`DataSet.AfterScroll` 실시간 데이터 수신**:
   - 상단 마스터 그리드(`tvSalesMaster`)에서 마우스 클릭이나 키보드 화살표(Up, Down)로 행을 이동할 때마다 `qryMasterAfterScroll` 이벤트가 트리거됩니다.
   - 현재 선택된 전표 PK(`SalesID`)를 파라미터로 하여 하단 `qryDetail`을 즉시 재조회(Open)합니다.

---

## 2. DB 스크립트 실행 (`schema.sql`)

SSMS에서 [`schema.sql`](file:///h:/lee/delphi7-notes/examples/16_DevExpressMSSQLSplitMasterDetailDemo/schema.sql) 스크립트를 실행하여 `SALESDB` 데이터베이스, `TB_SALES_MASTER` (매출 전표), `TB_SALES_DETAIL` (품목 세부내역) 테이블 및 샘플 데이터 40건/품목 120건을 생성합니다.

---

## 3. 파일 구성
* [`schema.sql`](file:///h:/lee/delphi7-notes/examples/16_DevExpressMSSQLSplitMasterDetailDemo/schema.sql): MS SQL Server DB/테이블 생성 및 샘플 데이터
* [`dbconfig.ini.template`](file:///h:/lee/delphi7-notes/examples/16_DevExpressMSSQLSplitMasterDetailDemo/dbconfig.ini.template): DB 접속 동적 설정 템플릿 (`Database=SALESDB`)
* [`DevExpressMSSQLSplitMasterDetailDemo.dpr`](file:///h:/lee/delphi7-notes/examples/16_DevExpressMSSQLSplitMasterDetailDemo/DevExpressMSSQLSplitMasterDetailDemo.dpr): 델파이 메인 프로젝트 파일
* [`MainForm.pas`](file:///h:/lee/delphi7-notes/examples/16_DevExpressMSSQLSplitMasterDetailDemo/MainForm.pas) / [`MainForm.dfm`](file:///h:/lee/delphi7-notes/examples/16_DevExpressMSSQLSplitMasterDetailDemo/MainForm.dfm): 상하 분할 마스터-디테일 메인 폼
