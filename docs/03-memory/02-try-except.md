# 03-2. try...except 예외 처리 🚑

> 💡 **초초보자를 위한 한 줄 요약**  
> **`try...except`**는 에러가 터졌을 때 프로그램이 꺼지지 않게 푹신한 **"에어백"**을 터뜨려 짱짱하게 수습하는 도구입니다!

---

## 🚑 `try...finally` 와 `try...except` 의 차이가 뭔가요?

* **`try...finally`**: "에러가 나든 말든 내 할 일(청소/해제)은 꿋꿋이 하고 튕겨 나가겠다!"
* **`try...except`**: "에러가 나면 **내가 에러를 낚아채서 수습하고 프로그램이 꺼지는 걸 막겠다!**"

---

## 💻 `try ... except` 기본 사용법

```pascal
var
  A, B, Answer: Integer;
begin
  A := 10;
  B := 0; // 0으로 나누기는 수학적으로 불가능!
  
  try
    Answer := A div B; // 🔥 0으로 나누기 에러(Exception) 발생!
  except
    // 에러가 났을 때 실행되는 에어백 구역!
    ShowMessage('0으로 나눌 수 없습니다! 다시 입력하세요.');
  end;
  
  // 에러가 수습되었으므로 프로그램이 꺼지지 않고 다음 줄로 안전하게 진행됩니다!
  ShowMessage('프로그램 계속 진행 중...');
end;
```

---

## 🔍 에러 메시지 내용 구체적으로 확인하기 (`on E: Exception do`)

어떤 에러가 났는지 구체적인 이유를 메시지로 띄우고 싶을 때 씁니다.

```pascal
try
  // 위험한 작업
except
  on E: Exception do
  begin
    // E.Message에 에러 원인 글자가 들어있습니다!
    ShowMessage('에러 발생 원인: ' + E.Message);
  end;
end;
```

---

## 🎯 초초보자를 위한 실무 요약

1. 사용자에게 이상한 입력이 들어오거나 파일이 없을 때 앱이 튕기지 않게 하려면 **`try...except`** 사용!
2. 객체 메모리를 다 쓰고 정리할 때는 **`try...finally`** 사용!

---

* **이전 단계**: [03-1. try...finally 기반 안전한 객체 해제 패턴](01-try-finally.md)
* **다음 단계**: [03-3. 포인터와 동적 메모리 할당](03-pointers.md)
