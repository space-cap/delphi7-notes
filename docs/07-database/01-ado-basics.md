# 07-1. TADOConnection 및 TADOQuery 기초 🗄️

> 💡 **초초보자를 위한 한 줄 요약**  
> * **`TADOConnection`**: DB 문을 열고 접속 아이디/비밀번호를 입력하는 **"DB 통로"**  
> * **`TADOQuery`**: DB에 SQL 명령어를 던져서 결과를 받아오는 **"심부름꾼"**

---

## 🗄️ 1. DB 접속 통로: `TADOConnection`

DB(MS-SQL, Oracle, MySQL 등)에 연결 통로를 뚫는 부품입니다.

### 연결 문자열 (ConnectionString)
* 델파이 IDE에서 `ADOConnection` 컴포넌트를 누르고 `ConnectionString` 속성을 누른 후 마법사를 통해 접속 서버 IP, DB 이름, 계정/비밀번호를 지정합니다.
* `ADOConnection1.Connected := True;` 명령으로 DB에 접속합니다.

---

## ✉️ 2. SQL 심부름꾼: `TADOQuery`

DB에 "회원 목록 가져와!", "새 회원 등록해!" 하고 SQL 문장을 보내는 컴포넌트입니다.

* **`Connection` 속성**: 위에서 만든 `ADOConnection1`을 지정하여 연결합니다.

---

## 💻 SQL 쿼리 실행하는 2가지 패턴!

### 패턴 A: 조회 (SELECT 쿼리 - 결과를 받아올 때) ➡️ `Open`
```pascal
ADOQuery1.Close; // 이전 쿼리 닫기
ADOQuery1.SQL.Clear; // 이전 SQL문 비우기
ADOQuery1.SQL.Add('SELECT * FROM USERS WHERE AGE >= 20');
ADOQuery1.Open; // ★ SELECT 조회를 실행하고 결과를 받아올 땐 Open!
```

### 패턴 B: CUD (INSERT, UPDATE, DELETE 쿼리 - DB 내용을 수정할 때) ➡️ `ExecSQL`
```pascal
ADOQuery1.Close;
ADOQuery1.SQL.Clear;
ADOQuery1.SQL.Add('INSERT INTO USERS (NAME, AGE) VALUES (''홍길동'', 25)');
ADOQuery1.ExecSQL; // ★ 수정/등록/삭제를 실행할 땐 ExecSQL!
```

---

## 🎯 초초보자를 위한 실무 황금 공식

* 데이터 가져와서 볼 땐 ➡️ **`ADOQuery1.Open;`**
* 데이터 추가/수정/삭제할 땐 ➡️ **`ADOQuery1.ExecSQL;`**

---

* **이전 단계**: [06-3. 필수 `.gitignore` 설정 및 파일 관리](../06-tips/03-gitignore.md)
* **다음 단계**: [07-2. TDataSet 조작 (First, Next, Edit, Post, FieldByName)](02-dataset-operations.md)
