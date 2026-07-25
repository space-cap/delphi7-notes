# 07-2. TDataSet 조작 (First, Next, Edit, Post, FieldByName) 🔄

> 💡 **초초보자를 위한 한 줄 요약**  
> DB에서 가져온 레코드(행) 목록을 **커서(Cursor)를 타고 위아래로 움직이며 값을 읽고 수정**하는 델파이 표준 메서드들입니다!

---

## 🏃‍♂️ 1. 레코드 커서 이동 5대 마법 키워드!

| 메서드 | 이동 방향 | 비유 |
| :--- | :--- | :--- |
| **`ADOQuery1.First;`** | 맨 첫 번째 행으로 이동 | 1등 줄로 돌아가기 |
| **`ADOQuery1.Next;`** | 바로 다음 행으로 이동 | 다음 사람! |
| **`ADOQuery1.Prior;`** | 바로 이전 행으로 이동 | 이전 사람! |
| **`ADOQuery1.Last;`** | 맨 마지막 행으로 이동 | 제일 꼴찌 줄로 가기 |
| **`ADOQuery1.Eof`** | End Of File (마지막을 지났는가?) | 줄이 끝났는지 확인하는 센서 |

---

## 🔄 전체 DB 목록을 순회하며 읽는 정석 `while` 루프!

DB에서 조회해 온 100개의 데이터를 처음부터 끝까지 읽는 실무 무적 공식입니다.

```pascal
ADOQuery1.First; // 1. 맨 처음 행으로 이동!

while not ADOQuery1.Eof do // 2. 마지막 행을 지날 때까지 반복!
begin
  // 3. 현재 행의 컬럼 값 읽어오기
  ShowMessage(ADOQuery1.FieldByName('NAME').AsString);
  
  // 4. ★ 필수: 다음 행으로 커서 이동! (안 쓰면 무한 루프 갇힘!)
  ADOQuery1.Next;
end;
```

---

## ✏️ 2. 값 읽고 수정하기 (`FieldByName`, `Edit`, `Post`)

### 값 읽기: `FieldByName('컬럼명').As자료형`
```pascal
UserName := ADOQuery1.FieldByName('NAME').AsString; // 글자로 읽기
UserAge  := ADOQuery1.FieldByName('AGE').AsInteger;  // 숫자로 읽기
```

### 소스 코드로 DB 직접 수정하기: `Edit` ➡️ `Post`
```pascal
ADOQuery1.Edit; // 1. 지금 행을 "수정 모드"로 변경!
ADOQuery1.FieldByName('AGE').AsInteger := 26; // 2. 값 변경
ADOQuery1.Post; // 3. ★ DB에 진짜 저장 반영! (Post 안 누르면 취소됨)
```

---

* **이전 단계**: [07-1. TADOConnection 및 TADOQuery 기초](01-ado-basics.md)
* **다음 단계**: [07-3. TDBGrid 및 데이터 바인딩 컴포넌트 활용](03-dbgrid-binding.md)
