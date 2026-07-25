# 04-2. TStringList 및 TList 활용법 📋

> 💡 **초초보자를 위한 한 줄 요약**  
> **`TStringList`**는 글자 목록을 줄바꿈 단위로 척척 관리하고, 파일 저장/읽기까지 1초 만에 해치우는 **델파이 최고의 만능 서류 가방**입니다!

---

## 📋 1. 델파이 개발자의 분신: `TStringList`

글자 목록을 추가, 삭제, 정렬하고 파일로 저장하거나 읽어오는 일을 전담하는 최고의 클래스입니다.

### 💻 TStringList 기본 사용법

```pascal
var
  List: TStringList;
begin
  List := TStringList.Create; // 1. 만능 가방 생성!
  try
    // 2. 글자 추가
    List.Add('사과');
    List.Add('바나나');
    List.Add('포도');
    
    // 3. 줄 수 확인 및 가져오기
    ShowMessage('총 과일 개수: ' + IntToStr(List.Count)); // 3개
    ShowMessage('첫 번째 과일: ' + List[0]); // 사과 (0번부터 시작!)
    
    // 4. 파일로 1초 만에 저장!
    List.SaveToFile('C:\Fruits.txt');
  finally
    List.Free; // 5. 안전하게 메모리 해제!
  end;
end;
```

---

## 🔑 `TStringList` 의 슈퍼 능력: Key=Value 쌍 관리

`Name=홍길동`, `Age=25` 형태의 데이터를 주고받을 때 미친 성능을 발휘합니다.

```pascal
List.Values['Name'] := '홍길동';
List.Values['Age']  := '25';

// 값 읽어오기
ShowMessage(List.Values['Name']); // 출력: 홍길동
```

---

## 📦 2. 객체나 포인터를 모아두는: `TList`

글자가 아니라 **객체(Object)나 메모리 포인터 뭉치**를 순서대로 나열해서 모아둘 때 쓰는 목록 상자입니다.

---

## 🎯 초초보자를 위한 실무 3줄 요약

1. 글자 목록 다룰 땐 무조건 **`TStringList`** 쓰기!
2. 텍스트 파일 저장(`SaveToFile`)과 읽기(`LoadFromFile`)가 단 한 줄로 가능!
3. 항목 가져올 땐 항상 **0번 인덱스**부터 시작함을 명심하기!

---

* **이전 단계**: [04-1. AnsiString 특성과 한글 문자열 처리](01-ansi-string.md)
* **다음 단계**: [04-3. 레코드(Record)와 동적 배열](03-record-and-array.md)
