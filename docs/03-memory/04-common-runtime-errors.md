# 03-4. 대표 런타임 에러 분석 (Access Violation, Index Out of Bounds 등) 💥

> 💡 **초초보자를 위한 한 줄 요약**  
> 델파이 개발하면서 보게 되는 3대 무서운 팝업 에러! 원인과 해결법만 알면 전혀 무섭지 않습니다.

---

## 💣 1위: `Access Violation at address ...` (액세스 바이올레이션)

델파이 개발자들의 영원한 숙적이자 가장 많이 만나는 에러입니다.

### ❓ 원인이 뭔가요?
* 존재하지 않는(메모리에 생성되지 않은) 객체를 쓰려고 했거나,
* 이미 메모리에서 해제(`Free`)되어 사라진 객체를 또 참조했을 때 발생합니다!

```pascal
// 💥 에러 발생 상황 예시!
var
  List: TStringList; // 선언만 하고
begin
  // List := TStringList.Create; <- ★ 이 Create를 깜빡함!
  List.Add('Hello'); // 🔥 Access Violation 팝업 쾅!!
end;
```

### 🛠️ 해결법!
* 에러가 난 줄 바로 위에서 **`객체 := T클래스.Create;`** 로 생성을 제대로 했는지 확인하세요!

---

## 💣 2위: `List index out of bounds (N)` (리스트 인덱스 범위 초과)

### ❓ 원인이 뭔가요?
* 데이터가 3개밖에 없는데 5번째 요소(`List[5]`)를 가져오라고 할 때 발생합니다!
* 델파이의 대부분 리스트 인덱스는 **0번부터 시작**한다는 것을 잊어서 자주 일어납니다.

```pascal
// 💥 에러 발생 상황 예시!
// 리스트에 데이터가 0번, 1번 총 2개 있음!
ShowMessage(List[2]); // 🔥 3번째를 가져오라니 List index out of bounds (2) 에러!!
```

### 🛠️ 해결법!
* `List.Count` (전체 개수)를 먼저 확인하고, 항상 **0부터 Count - 1 까지**만 접근하도록 수정하세요!

---

## 💣 3위: `Control '' has no parent window` (부모 윈도우 없음)

### ❓ 원인이 뭔가요?
* 버튼이나 에디트 박스 같은 UI 컴포넌트를 소스 코드(동적)로 만들었는데, 이 버튼이 들어앉을 **방(Form이나 Panel)**을 지정해주지 않았을 때 터집니다.

### 🛠️ 해결법!
* `MyBtn.Parent := Form1;` 또는 `MyBtn.Parent := Panel1;` 처럼 **`Parent` 속성을 반드시 지정**해 주세요!

---

## 🎯 초초보자를 위한 에러 대처 3계명

1. **`Access Violation`** ➡️ `Create` 생성을 안 했거나 이미 `Free` 했는지 확인!
2. **`List index out of bounds`** ➡️ 배열/리스트 범위(0부터 Count-1) 확인!
3. **`Has no parent window`** ➡️ `Parent := Form1;` 추가하기!

---

* **이전 단계**: [03-3. 포인터와 동적 메모리 할당](03-pointers.md)
* **다음 단계**: [04-1. AnsiString 특성과 한글 문자열 처리](../04-data/01-ansi-string.md)
