# 01-4. 프로시저와 함수 (procedure & function) ⚙️

> 💡 **초초보자를 위한 한 줄 요약**  
> 프로시저와 함수는 반복되는 긴 코드를 **"자판기 버튼 하나"**로 묶어놓은 것입니다!  
> * 결과를 돌려주면 ➡️ **`function` (함수)**  
> * 일만 하고 결과는 안 주면 ➡️ **`procedure` (프로시저)**

---

## 🥤 자판기 비유로 차이점 쉽게 알기

### 1. `function` (함수) - "동전을 넣으면 음료수가 나오는 자판기"
* **특징**: 내가 무슨 명령(재료)을 주면, 계산을 싹 마친 후 **결과물(값)을 반환**해 줍니다.
* **예시**: `ShowMessage(IntToStr(100));` ➡️ 숫자 100을 넣으면 글자 `'100'`을 반환함!

### 2. `procedure` (프로시저) - "버튼 누르면 청소를 실행하는 로봇청소기"
* **특징**: 명령을 받아 열심히 일(청소, 폼 닫기, 파일 저장 등)을 하지만, **반환되는 결과값은 없습니다.**

---

## 💻 델파이 프로시저(`procedure`) 작성법

```pascal
// 프로시저 선언: 이름은 SayHello, 매개변수 UserName
procedure SayHello(UserName: String);
begin
  ShowMessage('안녕하세요, ' + UserName + '님!');
end;

// 사용할 때 (호출):
SayHello('홍길동'); // 결과창: "안녕하세요, 홍길동님!"
```

---

## 💻 델파이 함수(`function`) 작성법 & 마법의 변수 `Result`

델파이 함수 안에는 결과를 담아 돌려주는 마법의 예약어 **`Result`**가 있습니다!

```pascal
// 두 숫자를 더해서 결과를 주는 함수
function Multiply(A, B: Integer): Integer;
begin
  Result := A * B; // Result에 넣은 값이 최종적으로 반환됩니다!
end;

// 사용할 때 (호출):
var
  Answer: Integer;
begin
  Answer := Multiply(5, 4); // Answer 상자에 20이 들어감!
end;
```

---

## ❓ 매개변수 전달 방식: `var` 매개변수 (참조 전달)

기본적으로 함수에 변수를 주면 '복사본'이 전달됩니다. 하지만 매개변수 앞에 **`var`**를 붙이면 **진짜 변수의 주소**가 전달되어 함수 내부에서 변수 값을 바꿀 수 있습니다!

```pascal
procedure Swap(var A, B: Integer);
var
  Temp: Integer;
begin
  Temp := A;
  A := B;
  B := Temp; // A와 B의 진짜 값을 교환함!
end;
```

---

## 🎯 초초보자를 위한 실무 3줄 요약

1. 결과를 리턴해야 하면 ➡️ `function` 쓰기!
2. 그냥 단순히 어떤 작업을 수행만 하면 ➡️ `procedure` 쓰기!
3. 함수(`function`) 안에서는 반환할 값에 **`Result := ...;`** 라고 쓰면 끝!

---

* **이전 단계**: [01-3. 제어문 (if, case, for, while)](03-control-statements.md)
* **다음 단계**: [02-1. 클래스(Class) 선언과 객체 생성](../02-oop/01-class-and-object.md)
