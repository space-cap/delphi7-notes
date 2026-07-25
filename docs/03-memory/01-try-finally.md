# 03-1. try...finally 기반 안전한 객체 해제 패턴 🛡️

> 💡 **초초보자를 위한 한 줄 요약**  
> **`try...finally`**는 중간에 무슨 에러가 터져서 코드가 멈추더라도, 맨 아래 **`finally` 구역 코드는 무조건(무슨 일이 있어도) 실행**해 주는 안전 구명밧줄입니다!

---

## 😱 왜 try...finally 가 필수인가요?

만약 메모리에 객체를 만들고 일을 하다가 중간에 에러(예외)가 나면, 뒤쪽 코드가 무시되고 바로 튕겨 나갑니다.

```pascal
// ❌ 위험한 코드!
var
  List: TStringList;
begin
  List := TStringList.Create;
  List.LoadFromFile('없는파일.txt'); // 🔥 여기서 에러 발생! 아래 줄 실행 안 됨!
  List.Free; // 😭 메모리 해제 안 되고 평생 갇힘 (메모리 누수!)
end;
```

---

## 🛡️ 안전 구명밧줄: `try ... finally` 패턴

`finally` 키워드 아래에 적은 코드는 **중간에 에러가 나건 안 나건 100% 무조건 실행**됩니다.

```pascal
// ✅ 델파이 실무 표준 정석 코드!
var
  List: TStringList;
begin
  List := TStringList.Create; // 1. 먼저 객체 생성!
  try
    // 2. 위험할 수 있는 작업 수행
    List.LoadFromFile('data.txt');
    ShowMessage('총 줄 수: ' + IntToStr(List.Count));
  finally
    // 3. 에러가 터지든 말든 100% 실행되어 정리함!
    List.Free;
  end;
end;
```

---

## 👑 더 안전한 해제 팁: `FreeAndNil`

`List.Free;` 대신 **`FreeAndNil(List);`** 를 쓰면 객체를 해제함과 동시에 `List` 변수를 빈 상태(`nil`)로 초기화해 줍니다. 

이미 해제된 메모리를 실수로 또 접근해서 터지는 버그를 완벽하게 방지해 줍니다!

```pascal
finally
  FreeAndNil(List); // 강추!
end;
```

---

## 🎯 초초보자를 위한 실무 3단계 공식

1. `객체 := T클래스.Create;`
2. **`try`**
3. **`finally`** `FreeAndNil(객체);` **`end;`**

이 3단계 틀을 먼저 타자 치고 시작하는 습관을 들이면 사수분께 칭찬받습니다! 👏

---

* **이전 단계**: [02-4. 프로퍼티(Property)와 이벤트 핸들링](../02-oop/04-properties.md)
* **다음 단계**: [03-2. try...except 예외 처리](02-try-except.md)
