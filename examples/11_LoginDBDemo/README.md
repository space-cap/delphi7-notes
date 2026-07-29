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

4. **실시간 DB 대화형 설정 (`PromptDataSource`)**
   - `[DB 설정]` 버튼 클릭 시 MS OLE DB 데이터 원본 연결 대화상자가 열려 사용자가 직접 DB 커넥션 스트링을 선택 가능

---

## 🔑 DB 접속 정보(ConnectionString) 위치 및 설정 방법

### 1️⃣ 소스 코드 상의 기본 설정 위치
- 파일: [`LoginForm.pas`](file:///c:/workdir/space-cap/delphi7-notes/examples/11_LoginDBDemo/LoginForm.pas#L58-L62)
- 위치: `FormCreate` 이벤트 내부
```delphi
// 기본 연결 문자열 (Access / MS SQL / ODBC 설정)
ADOConnection1.LoginPrompt := False;
ADOConnection1.ConnectionString :=
  'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=SampleDB.mdb;Persist Security Info=False';
```

### 2️⃣ 주요 데이터베이스별 커넥션 스트링 예시

- **MS SQL Server (OLEDB)**:
  ```text
  Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=MyDatabase;Data Source=localhost
  ```
- **MS SQL Server (SQL 사용자 계정 로그인)**:
  ```text
  Provider=SQLOLEDB.1;Persist Security Info=True;User ID=sa;Password=myPassword;Initial Catalog=MyDatabase;Data Source=127.0.0.1
  ```
- **MS Access (MDB)**:
  ```text
  Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\MyPath\SampleDB.mdb;Persist Security Info=False
  ```

### 3️⃣ 프로그램 실행 중 DB 접속 정보 변경 방법
- 로그인 화면 오른쪽 아래의 **`[DB 설정]`** 버튼을 클릭하면, 델파이 표준 데이터 원본 설정 창이 나타나 서버 주소, DB 이름, 비밀번호를 직접 선택하고 연결 테스트를 진행할 수 있습니다.

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
