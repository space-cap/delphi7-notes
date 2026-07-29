# 11. 델파이 7 DB 로그인 샘플 프로젝트 (11_LoginDBDemo)

본 예제는 **델파이 7(Delphi 7)** 환경에서 **TADOConnection**과 **TADOQuery**를 활용하여 데이터베이스에 접속하고, 아이디 및 비밀번호를 안전하게 검증하는 회원 로그인 샘플입니다.

---

## 📌 주요 특징 및 구현 내용

1. **SQL 데이터베이스 스크립트 제공 (`schema.sql`)**
   - `USERS` 사용자 테이블 생성 구문
   - 테스트용 기본 계정 (`admin`, `user1`) 데이터 제공
   - 계정 활성화 상태(`Is_Active = 'Y'`) 처리 및 권한 필드 관리

2. **SQL Injection 방지 (Parameterized Query)**
   - 쿼리 문자열 조합 대신 파라미터 바인딩(`:UserID`, `:Password`)을 사용하여 보안 강화

3. **정석 델파이 로그인 모달 폼 구조 (`LoginDBApp.dpr`)**
   - `LoginForm.ShowModal = mrOk` 결과일 때만 메인 화면(`MainForm`)을 생성하여 실행
   - 로그인 성공 시 사용자 정보(아이디, 이름, 권한)를 메인 화면으로 전달

4. **보안 및 외부 설정 관리 (`dbconfig.ini` & `dbconfig.ini.template`)**
   - 소스 코드 내 DB 접속 정보(IP, 계정, 비밀번호) 하드코딩 완전 제거
   - `dbconfig.ini` 파일을 통한 동적 접속 정보 관리 및 Git 커밋 예외 처리

---

## 🔑 DB 접속 정보(ConnectionString) 위치 및 설정 방법

### 1️⃣ 소스 코드 상의 기본 설정 위치
- 파일: [`LoginForm.pas`](file:///c:/workdir/space-cap/delphi7-notes/examples/11_LoginDBDemo/LoginForm.pas#L74-L95)
- 위치: `LoadDBConfigFromIni` 이벤트 내부 (`dbconfig.ini` 동적 로딩)

### 2️⃣ 프로그램 실행 중 DB 접속 정보 변경 방법
- 로그인 화면 오른쪽 아래의 **`[DB 설정]`** 버튼을 클릭하면, 델파이 표준 데이터 원본 설정 창이 나타나 서버 주소, DB 이름, 비밀번호를 직접 선택하고 변경된 접속 정보가 `dbconfig.ini` 파일에 저장됩니다.

---

## 🏗️ 실무 확장 아키텍처: DataModule을 통한 DB 커넥션 재활용

> **Q. 유저 리스트 등 신규 화면을 추가할 때 매번 DB에 새로 접속해야 하나요?**
>
> **A. 아니오! 연결(Connection)을 공유해서 재활용하는 것이 정석입니다.**

화면을 열 때마다 DB에 새로 접속(Connect)하면 네트워크 및 서버 오버헤드로 앱이 느려집니다. 실무 델파이 개발에서는 **`TDataModule` (공통 데이터 모듈)** 을 활용하여 DB 커넥션을 애플리케이션 수명 동안 1개만 열어두고 모든 서브 화면에서 재활용합니다.

```text
[DataModule (DM.pas)] 
   └── TADOConnection (전역 DB 커넥션 1개 유지)
          ├── LoginForm (로그인 화면에서 공유)
          ├── UserListForm (유저 리스트 화면에서 공유)
          └── OrderForm (수주 관리 화면에서 공유)
```

### 💡 실무 구현 코드 예시

1. **공통 데이터 모듈 (`DM.pas`)**
   ```delphi
   type
     TDM = class(TDataModule)
       ADOConnection1: TADOConnection; // 전역 1개 연결 유지
     end;
   ```

2. **유저 리스트 등 신규 화면 (`UserListForm.pas`)**
   ```delphi
   procedure TFormUserList.FormShow(Sender: TObject);
   begin
     // 공통 DataModule의 커넥션을 그대로 재활용!
     ADOQuery1.Connection := DM.ADOConnection1;
     ADOQuery1.SQL.Text := 'SELECT User_ID, User_Name, User_Role FROM USERS';
     ADOQuery1.Open;
   end;
   ```

---

## 🛠️ 실행 방법 및 설정 가이드

1. **DB 테이블 구축 (`schema.sql`)**
   - MS SQL Server, MS Access, SQLite 등 사용하는 DB 관리도구에서 `schema.sql` 스크립트를 실행하여 `USERS` 테이블을 생성합니다.

2. **델파이 프로젝트 열기 및 실행**
   - [`LoginDBApp.dpr`](file:///c:/workdir/space-cap/delphi7-notes/examples/11_LoginDBDemo/LoginDBApp.dpr) 파일 열기
   - `F9` 또는 `Run`을 눌러 프로젝트 실행

3. **테스트 기본 계정 정보**
   - **관리자 계정**: ID `admin` / Password `admin123!`
   - **일반 사용자**: ID `user1` / Password `pass1234`
