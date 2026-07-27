# 05_MSSQLADODemo MS-SQL ADO DB 연동 실습 가이드 🛢️

> 💡 **초초보자를 위한 한 줄 요약**  
> 델파이 7에서 표준 **ADO (`TADOConnection`, `TADOQuery`, `TDataSource`, `TDBGrid`)** 컴포넌트를 사용하여 **MS-SQL Server DB**에 접속하고 쿼리를 실행해 결과를 화면에 띄우는 완전 가이드입니다!

---

## 🎯 이 실습에서 배우는 내용

1. **`TADOConnection`**: MS-SQL DB 서버 연결 설정 (`ConnectionString`)
2. **`TADOQuery`**: SQL 문장(`SELECT ...`) 전송 및 데이터 조회 (`Open`)
3. **`TDataSource`**: DB 쿼리와 화면 UI 사이를 바인딩하는 중간 다리
4. **`TDBGrid`**: 가져온 DB 테이블 데이터를 엑셀처럼 화면에 자동 출력하기
5. **`try...except`**: DB 연결 실패 및 쿼리 에러 안전하게 예외 처리하기

---

## 🛢️ 테스트용 SQL 스크립트 실행 (`init_test_db.sql`)

실습을 위해 준비된 **[init_test_db.sql](init_test_db.sql)** 파일에는 아래 내용이 포함되어 있습니다:
1. `TestDB` 데이터베이스 생성
2. `TB_MEMBER` (회원 정보) 테이블 생성
3. 샘플 회원 데이터 5건 (`홍길동`, `김철수`, `이영희`, `박민수`, `최지은`) 자동 입력

> 💡 **사용 방법**: SSMS(SQL Server Management Studio) 또는 Query Tool에서 **[init_test_db.sql](init_test_db.sql)** 스크립트를 전체 실행(F5)한 뒤, 델파이 프로그램에서 `DB연결 & 조회` 버튼을 클릭하시면 회원 데이터 5건이 `TDBGrid` 화면에 엑셀처럼 짠! 뜹니다.

---

## 🏗️ DB 연동 삼각 편대 연결 구조

델파이에서 DB를 화면에 띄우는 정석 구조는 다음과 같습니다:

```text
[ MS-SQL DB 서버 ]
       │
       ▼ (OLE DB Provider / SQLOLEDB)
[ TADOConnection ] (DB 물리적 연결)
       │
       ▼
[ TADOQuery ] (SQL 쿼리 실행)
       │
       ▼
[ TDataSource ] (화면 전달 매개체)
       │
       ▼
[ TDBGrid ] (화면에 엑셀처럼 출력)
```

---

## 📄 파스칼 주요 소스 코드 해설 (`MSSQLForm.pas`)

### 1) MS-SQL 커넥션 스트링(ConnectionString) 생성

```pascal
function TFormMSSQL.BuildConnectionString: String;
begin
  // SQLOLEDB (MS-SQL OLE DB Provider) 기본 연결 문자열
  Result := 'Provider=SQLOLEDB.1;' +
            'Persist Security Info=False;' +
            'Data Source=' + EditServer.Text + ';' +  // DB 서버 IP 또는 이름
            'Initial Catalog=' + EditDB.Text + ';' +   // 데이터베이스명
            'User ID=' + EditUser.Text + ';' +         // DB 접속 계정
            'Password=' + EditPassword.Text + ';';     // DB 접속 비밀번호
end;
```

### 2) DB 연결 및 SQL 쿼리 실행

```pascal
procedure TFormMSSQL.BtnConnectClick(Sender: TObject);
begin
  try
    // 1. 기존 DB 연결 해제 후 새 커넥션 스트링 설정
    if ADOConnection1.Connected then ADOConnection1.Close;
    ADOConnection1.ConnectionString := BuildConnectionString;
    ADOConnection1.Connected := True; // DB 접속!

    // 2. SQL 쿼리 작성 및 실행
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Text := 'SELECT * FROM MyTable';
    ADOQuery1.Open; // SELECT 쿼리는 Open 메소드로 실행!

  except
    on E: Exception do
      ShowMessage('DB 오류 발생: ' + E.Message);
  end;
end;
```

---

## 💻 델파이 7 IDE에서 실습하는 방법

1. `examples/05_MSSQLADODemo/` 폴더로 이동합니다.
2. **`MSSQLADODemo.dpr`** 프로젝트 파일을 더블클릭하여 델파이 7 IDE를 엽니다.
3. 키보드의 **`F9`** 키를 눌러 실행합니다.
4. 화면 상단의 **서버 IP, DB 이름, 계정 정보**를 입력하고 **`[DB 연결 & 조회]`** 버튼을 클릭하여 결과를 확인합니다!

---

* **이전 단계**: [04_MemoryAndThread 멀티스레드 실습](../04_MemoryAndThread/README.md)
