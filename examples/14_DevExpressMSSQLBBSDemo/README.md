# 14. DevExpress TcxGrid + MS SQL Server 게시판 (BBS) 데모

이 예제는 DevExpress QuantumGrid (`TcxGrid`)와 MS SQL Server (`DELPHI7_DB`)를 연동하여 웹 방식의 페이징(SQL Paging) 처리와 게시물 CRUD(생성/조회/수정/삭제)를 구현한 프로젝트입니다.

---

## 1. 주요 기능
- **SQL Server CTE Paging**: `ROW_NUMBER() OVER (ORDER BY IsNotice DESC, BoardID DESC)`를 활용한 고속 서버 페이징
- **INI 설정 연동**: `dbconfig.ini` 기반 동적 DB 커넥션
- **예외 안전 처리**: DB 접속 실패 시 프로그램 중단 없는 예외 감싸기(`try...except`)

---

## 2. 파일 구성
* [`schema.sql`](file:///h:/lee/delphi7-notes/examples/14_DevExpressMSSQLBBSDemo/schema.sql): MS SQL Server DDL 및 1,000건 대량 샘플 데이터
* [`MainForm.pas`](file:///h:/lee/delphi7-notes/examples/14_DevExpressMSSQLBBSDemo/MainForm.pas) / [`MainForm.dfm`](file:///h:/lee/delphi7-notes/examples/14_DevExpressMSSQLBBSDemo/MainForm.dfm): 게시판 메인 폼
* [`BoardEditForm.pas`](file:///h:/lee/delphi7-notes/examples/14_DevExpressMSSQLBBSDemo/BoardEditForm.pas) / [`BoardEditForm.dfm`](file:///h:/lee/delphi7-notes/examples/14_DevExpressMSSQLBBSDemo/BoardEditForm.dfm): 모달 편집 폼
