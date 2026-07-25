# 01-3. 제어문 (if, case, for, while) 🚦

> 💡 **초초보자를 위한 한 줄 요약**  
> 제어문은 **"신호등과 갈림길"**입니다. 상황에 따라 이 길로 갈지(`if`), 10번 반복할지(`for`) 컴퓨터에게 방향을 지시합니다!

---

## 🌲 1. 조건문: `if ... then ... else` ("만약 ~라면")

상황에 따라 다른 코드를 실행하고 싶을 때 씁니다.

```pascal
if Score >= 90 then
begin
  ShowMessage('A 학점입니다! 축하합니다 🎉');
end
else
begin
  ShowMessage('더 힘내보세요! 💪');
end;
```

> ⚠️ **초초보자 통곡의 주의사항!**  
> `else` **바로 직전 문장 끝에는 세미콜론(`;`)을 찍으면 안 됩니다!**  
> `ShowMessage('...')` 뒤에 `;`를 빼야 델파이가 에러를 안 냅니다!

---

## 🔀 2. 다중 선택문: `case ... of` ("선택지 중 하나 고르기")

`if`문이 너무 많아지면 보기 복잡해집니다. 이럴 때 깔끔하게 조건 분기를 만드는 도구입니다.

```pascal
case UserRole of
  1: ShowMessage('관리자님 환영합니다!');
  2: ShowMessage('일반 회원님 환영합니다!');
  3: ShowMessage('손님 환영합니다!');
else
  ShowMessage('알 수 없는 사용자입니다.');
end;
```

---

## 🔄 3. 횟수 반복문: `for ... to ... do` ("N번 반복해라!")

정해진 횟수만큼 똑같은 일을 반복할 때 씁니다.

```pascal
var
  i: Integer;
begin
  // 1부터 5까지 총 5번 반복!
  for i := 1 to 5 do
  begin
    ShowMessage(IntToStr(i) + '번째 카운트!');
  end;
end;
```

---

## 🔁 4. 조건 반복문: `while ... do` ("조건이 참인 동안 계속 반복해라!")

언제 끝날지 모르지만, 특정 조건이 만족할 때까지 계속 지켜보며 반복할 때 씁니다.

```pascal
var
  Money: Integer;
begin
  Money := 1000;
  
  // 돈이 0보다 큰 동안 계속 지출!
  while Money > 0 do
  begin
    Money := Money - 200; // 200원씩 차감
  end;
end;
```

---

## 🧱 델파이에서 괄호 역할: `begin`과 `end`

C 언어나 자바에서 중괄호(`{ }`)를 쓰는 것처럼, 델파이에서는 **여러 줄의 코드를 한 묶음으로 묶을 때 `begin`과 `end;`**를 사용합니다!

```pascal
if IsRainy then
begin // <- 묶음 시작
  TakeUmbrella;
  WearRaincoats;
end;  // <- 묶음 끝
```

---

* **이전 단계**: [01-2. 변수 선언, 자료형 및 연산자](02-variables-and-types.md)
* **다음 단계**: [01-4. 프로시저와 함수 (procedure & function)](04-procedures-and-functions.md)
