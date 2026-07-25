# 07-3. TDBGrid 및 데이터 바인딩 컴포넌트 활용 📊

> 💡 **초초보자를 위한 한 줄 요약**  
> **`TDataSource`** 컴포넌트를 중간 다리로 삼아서, DB 쿼리 데이터(`TADOQuery`)를 화면의 **표(`TDBGrid`)에 1초 만에 자동으로 그려내는 기술**입니다!

---

## 🌉 3대 컴포넌트 삼총사 연동 구조!

델파이에서 DB 데이터를 화면 표에 띄울 때 무조건 아래 3개가 삼총사로 연결되어야 합니다.

```text
[ TADOQuery ] ➡️ (DataSet 연결) ➡️ [ TDataSource ] ➡️ (DataSource 연결) ➡️ [ TDBGrid ]
  (진짜 데이터)                     (중간 연결 다리)                         (화면 표 그림)
```

---

## 🛠️ 화면 연동 3단계 세팅법 (코딩 없이 속성창으로 연결!)

1. **`TDataSource` 설정**:
   - `DataSource1.DataSet := ADOQuery1;` (쿼리를 연결한다!)
2. **`TDBGrid` 설정**:
   - `DBGrid1.DataSource := DataSource1;` (다리를 연결한다!)
3. **결과**:
   - 이제 `ADOQuery1.Open;` 하는 순간 소스 코드를 한 줄도 안 적어도 **`TDBGrid` 표에 DB 데이터가 짠! 하고 자동으로 뜹니다!**

---

## 🎯 초초보자를 위한 실무 요약

* `TDBGrid`는 마법처럼 DB 데이터를 자동으로 보여주는 최고의 델파이 표 컴포넌트이다!
* 중간에 **`TDataSource`** 라는 중간 연결 고리가 필수라는 점을 기억하자!

---

* **이전 단계**: [07-2. TDataSet 조작 (First, Next, Edit, Post, FieldByName)](02-dataset-operations.md)
* **다음 단계**: [08-1. TIniFile 및 TFileStream 활용법](../08-file-network/01-inifile-and-stream.md)
