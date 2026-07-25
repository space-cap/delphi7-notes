# 01_BasicSyntax 실습 가이드 🧪

초초보자를 위한 **델파이 7 기본 문법 콘솔 실습 가이드** 문서입니다.

---

## 🎯 이 실습에서 배우는 내용

1. 결과를 리턴하는 **함수(`function AddNumbers`)** 만들기
2. 일만 수행하는 **프로시저(`procedure PrintHeader`)** 만들기
3. 1부터 5까지 반복하는 **`for` 반복문**
4. **`TStringList`** 객체 생성 및 **`try...finally`** 안전한 메모리 해제

---

## 💻 델파이 7 IDE에서 실행하는 3단계 방법

### 1단계: 프로젝트 열기 📂
`examples/01_BasicSyntax/` 폴더로 이동한 뒤, **`BasicSyntaxDemo.dpr`** 파일을 마우스로 **닥블클릭**하여 델파이 7 IDE를 실행합니다.

### 2단계: 코드 실행하기 🚀
델파이 IDE가 열리면 키보드 상단의 **`F9`** 키를 누릅니다!  
(또는 델파이 상단 메뉴에서 `Run` ➡️ `Run` 을 누르셔도 됩니다.)

### 3단계: 실행 결과 확인하기 🖥️
까만색 콘솔(Command) 창이 뜨면서 아래와 같은 결과가 출력되는지 확인합니다!

```text
========================================
  Delphi 7 기본 문법 & TStringList 실습
========================================
1. AddNumbers(15, 25) 결과: 40

2. 1부터 5까지 반복문 실습:
   Count: 1
   Count: 2
   Count: 3
   Count: 4
   Count: 5

3. TStringList 활용 및 메모리 안전 해제:
   총 과일 개수: 3
   [0] 사과 (Apple)
   [1] 바나나 (Banana)
   [2] 포도 (Grape)
   -> FruitList 메모리가 안전하게 해제되었습니다.

엔터 키(Enter)를 누르면 프로그램이 종료됩니다...
```

---

## 🔍 핵심 소스 코드 한눈에 풀어보기

### 1) 함수 (`function`)
```pascal
function AddNumbers(A, B: Integer): Integer;
begin
  Result := A + B; // 마법의 변수 Result에 집어넣은 값이 반환됨!
end;
```

### 2) 메모리 안전 해제 (`try...finally`)
```pascal
FruitList := TStringList.Create; // 1. 가방 생성
try
  FruitList.Add('사과');
  // ... 일 수행 ...
finally
  FruitList.Free; // 2. 에러가 나건 말건 무조건 100% 가방을 지워줌!
end;
```

---

## 🏆 초초보자를 위한 1분 셀프 도전 과제!

직접 코드를 살짝 고쳐보면서 테스트해 보세요!

1. **도전 1**: `FruitList.Add('수박 (Watermelon)');` 코드를 한 줄 더 추가해서 과일이 4개가 되게 만들어보세요!
2. **도전 2**: 두 숫자를 곱해주는 `MultiplyNumbers(A, B: Integer): Integer;` 함수를 새로 만들어 호출해 보세요!

코드를 고친 뒤 다시 **`F9`** 키를 누르면 내가 고친 결과가 바로 화면에 나옵니다! 👏
