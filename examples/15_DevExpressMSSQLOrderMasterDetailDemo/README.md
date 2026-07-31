# 15. DevExpress TcxGrid 수주 마스터-디테일 (Master-Detail) & 기간 검색 데모

이 예제는 기업형 C/S 실무에서 가장 많이 사용하는 **[기간 검색 + TOP 1000 제한]** 조건 검색 패턴과 **[DevExpress QuantumGrid Master-Detail (계층구조 그리드)]** 기능을 연동한 실전 응용 프로젝트입니다.

---

## 1. 실무 비(非)페이징 설계 원칙

1. **왜 페이징을 쓰지 않나요?**
   - ERP/MES 실무 사용자는 수백 건의 주문서 및 전표 데이터를 그리드에서 **직접 부서별/거래처별로 그룹핑**하고 **소계/합계(Footer Summary)를 검증**한 후 **엑셀로 내보내는 작업**을 수행합니다. 페이징이 들어가면 10건씩만 계산되므로 이 작업을 수행할 수 없습니다.

2. **안전 장치 (TOP 1000 + Date Range)**:
   - 데이터 과부하로 인한 DB/클라이언트 다운(Freeze)을 막기 위해 **기본 조회 기간(시작일~종료일)** 및 **`SELECT TOP 1000` 상위 인출 제한**을 둡니다.

---

## 2. DB 스크립트 실행 (`schema.sql`)

SSMS에서 통합 마스터 스크립트 [`examples/schema_master_delphi7.sql`](file:///h:/lee/delphi7-notes/examples/schema_master_delphi7.sql) 또는 [`schema.sql`](file:///h:/lee/delphi7-notes/examples/15_DevExpressMSSQLOrderMasterDetailDemo/schema.sql)을 실행하여 `DELPHI7_DB` 데이터베이스에 테이블 및 샘플 수주 데이터를 생성합니다.

---

## 3. 파일 구성
* [`schema.sql`](file:///h:/lee/delphi7-notes/examples/15_DevExpressMSSQLOrderMasterDetailDemo/schema.sql): MS SQL Server DB/테이블 생성 및 샘플 데이터
* [`dbconfig.ini.template`](file:///h:/lee/delphi7-notes/examples/15_DevExpressMSSQLOrderMasterDetailDemo/dbconfig.ini.template): DB 접속 동적 설정 템플릿 (`Database=DELPHI7_DB`)
* [`DevExpressMSSQLOrderMasterDetailDemo.dpr`](file:///h:/lee/delphi7-notes/examples/15_DevExpressMSSQLOrderMasterDetailDemo/DevExpressMSSQLOrderMasterDetailDemo.dpr): 델파이 메인 프로젝트 파일
* [`MainForm.pas`](file:///h:/lee/delphi7-notes/examples/15_DevExpressMSSQLOrderMasterDetailDemo/MainForm.pas) / [`MainForm.dfm`](file:///h:/lee/delphi7-notes/examples/15_DevExpressMSSQLOrderMasterDetailDemo/MainForm.dfm): 마스터-디테일 그리드 & 기간 검색 메인 폼
