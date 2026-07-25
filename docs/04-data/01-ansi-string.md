# 04-1. AnsiString 특성과 한글 문자열 처리 🔤

> 💡 **초초보자를 위한 한 줄 요약**  
> Delphi 7의 문자열(`String`)은 **AnsiString**입니다. 영문/숫자는 **1글자당 1Byte**, 한글/한자는 **1글자당 2Byte**를 차지하는 특징을 꼭 기억해야 합니다!

---

## 🔤 Delphi 7 의 `String` = `AnsiString`

최신 언어(C#, Java, 최신 델파이)는 기본 문자가 유니코드(Unicode, 1글자=2Byte 통일)지만, **Delphi 7은 AnsiString 시대**에 태어났습니다.

* **영어, 숫자, 공백**: `1 Byte`
* **한글, 한자, 특수문자**: `2 Byte`

---

## 📏 `Length()` 함수 사용 시 초초보자 주의사항!

`Length('글자')` 함수는 "글자 수"를 세는 것이 아니라 **"Byte(바이트) 크기"**를 센다는 점을 꼭 기억하세요!

```pascal
var
  S1, S2: String;
begin
  S1 := 'ABC';  // 영문 3글자
  S2 := '홍길동'; // 한글 3글자
  
  ShowMessage(IntToStr(Length(S1))); // 출력: 3 (3 Byte)
  ShowMessage(IntToStr(Length(S2))); // 출력: 6 (6 Byte! 3글자 * 2Byte)
end;
```

---

## ✂️ 문자열 자르기: `Copy()` 함수

문자열의 특정 위치부터 잘라낼 때 `Copy(문자열, 시작위치, 바이트수)` 함수를 씁니다.

```pascal
var
  S, Sub: String;
begin
  S := 'Delphi7';
  
  // 1번째 글자부터 6바이트 잘라내기
  Sub := Copy(S, 1, 6); // Sub = 'Delphi'
end;
```

---

## 🎯 초초보자를 위한 핵심 요약

1. Delphi 7에서 한글 1글자는 **2바이트(2Byte)**이다!
2. `Length('한글')`의 결과는 2가 아니라 **4**가 나온다!

---

* **이전 단계**: [03-4. 대표 런타임 에러 분석 (Access Violation, Index Out of Bounds 등)](../03-memory/04-common-runtime-errors.md)
* **다음 단계**: [04-2. TStringList 및 TList 활용법](02-lists.md)
