# 04-3. 레코드(Record)와 동적 배열 🍱

> 💡 **초초보자를 위한 한 줄 요약**  
> * **레코드 (`record`)**: 이름, 나이, 이메일을 선물 세트 상자 하나로 묶는 **"세트 메뉴 패키지"**  
> * **동적 배열 (`array of ...`)**: 크기를 내 마음대로 늘렸다 줄였다 하는 **"요술 고무줄 배열"**

---

## 🍱 1. 레코드 (Record) - "데이터 선물 세트"

클래스처럼 거창하게 생성(`Create`)이나 해제(`Free`)할 필요 없이, **여러 개의 변수를 하나로 묶어서 간편하게 쓸 수 있는 구조체**입니다.

```pascal
type
  // 학생 정보를 묶은 레코드 세트!
  TStudent = record
    Name: String;
    Age: Integer;
    Score: Double;
  end;

var
  Student1: TStudent; // Create 할 필요 없음! 바로 씀!
begin
  Student1.Name := '김철수';
  Student1.Age := 20;
  Student1.Score := 95.5;
  
  ShowMessage(Student1.Name + ' 학생의 점수: ' + FloatToStr(Student1.Score));
end;
```

---

## 📏 2. 동적 배열 (`array of ...`) - "요술 고무줄 배열"

처음부터 크기를 딱 고정하지 않고, 실행 중에 필요에 따라 **`SetLength`** 함수로 크기를 마음대로 늘리는 배열입니다.

```pascal
var
  Scores: array of Integer; // 크기를 안 정해둔 동적 배열
begin
  // 1. 배열 크기를 3개로 설정! (0번, 1번, 2번 칸 생김)
  SetLength(Scores, 3);
  
  Scores[0] := 90;
  Scores[1] := 85;
  Scores[2] := 100;
  
  // 2. 크기를 5개로 늘리고 싶을 때!
  SetLength(Scores, 5);
end;
```

---

## 🎯 초초보자를 위한 핵심 요약

1. 레코드는 간단한 데이터 묶음이며 `Create`/`Free`가 필요 없어서 가볍다!
2. 동적 배열은 **`SetLength(배열변수, 크기)`** 함수로 크기를 정해놓고 쓴다!

---

* **이전 단계**: [04-2. TStringList 및 TList 활용법](02-lists.md)
* **다음 단계**: [04-4. 한글 2Byte(CP949) 처리 및 문자열 잘림(자소 파괴) 방지](04-korean-bytes.md)
