# 12. DataModule 기반 DB 커넥션 공유 및 유저 리스트 실습 (12_DataModuleUserListDemo)

본 예제는 **델파이 7(Delphi 7)** 실무 개발의 핵심 아키텍처인 **`TDataModule` (공통 데이터 모듈)** 을 도입하여 **DB 커넥션(`TADOConnection`)을 단 1개만 열어두고 모든 서브 화면에서 재활용(공유)** 하는 방식을 실습하는 데모 프로젝트입니다.

---

## 📌 주요 특징 및 구현 내용

1. **전역 공통 데이터 모듈 (`DataModule.pas`)**
   - 애플리케이션 시작 시 단 1개의 `TADOConnection` 커넥션을 생성하여 유지
   - `dbconfig.ini` 외부 파일에서 접속 정보 동적 로딩

2. **커넥션 공유 - 로그인 화면 (`LoginForm.pas`)**
   - 자체 DB 커넥션을 만들지 않고 `DataModuleMain.ADOConnection1`을 재활용하여 로그인 검증

3. **커넥션 공유 - 유저 목록 조회 화면 (`UserListForm.pas`)**
   - DB에 새로 접속하지 않고 `DataModuleMain.ADOConnection1`을 재활용하여 `USERS` 테이블 전체 유저 목록 조회 및 검색 (`TDBGrid` 사용)

4. **메인 화면 (`MainForm.pas`)**
   - `[사용자 목록 관리]` 버튼 클릭 시 `UserListForm` 모달을 호출하여 기존 커넥션 기반의 빠른 데이터 조회 확인

---

## 🏗️ 다중 DB(유저 DB, 재고 DB 등 2개 이상) 사용 시 설계 가이드

> **Q. 만약 DB를 2개(예: 유저 DB, 재고 DB) 사용한다면 TDataModule도 2개를 만들어야 하나요?**
>
> **A. 2가지 방식 모두 가능하며, 프로젝트 규모와 팀 개발 방식에 따라 선택합니다!**

### 💡 방식 1. 1개의 TDataModule 안에 TADOConnection 2개 배치 (중소규모 추천)
- `DM.pas` 하나에 `ADOConnectionUser` (유저 DB용)와 `ADOConnectionStock` (재고 DB용) 2개를 올려놓고 관리합니다.
- **장점**: 데이터 모듈 파일 1개만 관리하므로 커넥션 초기화/관리 코드가 한곳에 모여 편리합니다.

### 💡 방식 2. TDataModule을 2개로 분리 (대규모 ERP / 모듈별 독립 개발 추천)
- `DMUser.pas` (유저/인사 시스템 DB 전용 DataModule)
- `DMStock.pas` (재고/물류 시스템 DB 전용 DataModule)
- **장점**: 유저 모듈 개발자와 재고 모듈 개발자가 서로 다른 파일(`DMUser`, `DMStock`)을 다루므로 **Git/SVN 소스 충돌이 없고 업무 독립성이 매우 뛰어납니다.**

---

## 🛠️ 실행 가이드

1. **`11_LoginDBDemo` 의 `schema.sql` 스크립트를 먼저 실행**하여 `USERS` 테이블을 만듭니다.
2. [`DataModuleDemoApp.dpr`](file:///c:/workdir/space-cap/delphi7-notes/examples/12_DataModuleUserListDemo/DataModuleDemoApp.dpr) 파일 열기
3. `F9` 또는 `Run`을 눌러 프로젝트 실행
4. 기본 테스트 계정으로 로그인 (`admin` / `admin123!`)
5. 메인 화면의 `[사용자 목록 관리]` 버튼을 클릭하여 유저 리스트가 즉시 그려지는 것을 확인합니다.
