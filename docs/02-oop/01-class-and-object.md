# 02-1. 클래스(Class) 선언과 객체 생성 🚗

> 💡 **초초보자를 위한 한 줄 요약**  
> **클래스(Class)**는 자동차를 찍어내는 **"설계도"**이고,  
> **객체(Object / Instance)**는 설계도를 보고 실제로 만든 **"진짜 자동차"**입니다!

---

## 🚘 클래스와 객체의 쉬운 비유

* **클래스 (Class)**: 붕어빵 틀 / 자동차 설계도 (실체가 없음, 개념만 존재)
* **객체 (Object / Instance)**: 슈크림 붕어빵 / 도로를 달리는 내 소나타 (실제로 메모리에 만들어진 것)

---

## 💻 델파이에서 클래스(설계도) 정의하는 모양

```pascal
type
  // TCar라는 자동차 클래스(설계도)를 만든다!
  TCar = class
  public
    ModelName: String; // 속성: 자동차 모델명
    Speed: Integer;    // 속성: 현재 속도
    
    procedure Accelerate; // 동작: 엑셀 밟기
  end;
```

> 💡 **델파이 이름 규칙 팁!**  
> 델파이에서는 클래스 이름 맨 앞에 Type의 약자인 **`T`**를 붙이는 것이 관례입니다! (`TForm`, `TButton`, `TCar`)

---

## 🏭 객체(진짜 자동차) 생성하고 사용하기: `Create`

설계도(`TCar`)를 바탕으로 메모리에 진짜 자동차(`MyCar`)를 조립할 때는 **`.Create`** 라는 명령을 씁니다!

```pascal
var
  MyCar: TCar; // 변수 선언 (아직은 차가 없고 이름표만 준비됨)
begin
  // 1. 진짜 자동차 조립 (메모리에 객체 생성!)
  MyCar := TCar.Create;
  
  // 2. 자동차 속성 설정 및 조작
  MyCar.ModelName := '소나타';
  MyCar.Speed := 80;
  MyCar.Accelerate; // 엑셀 밟기 실행!
end;
```

---

## 🔒 접근 제어자: `private` vs `public`

클래스 안의 내용물을 외부에 공개할지 말지 정하는 문지기입니다!

* **`private` (비밀 구역)**: 이 유닛 내부에서만 접근 가능 (외부에서 함부로 못 고치게 숨김!)
* **`public` (공개 구역)**: 누구나 이 객체를 가져다가 읽고 고칠 수 있음!

```pascal
type
  TPerson = class
  private
    SSN: String; // 주민번호는 비밀! (private)
  public
    Name: String; // 이름은 공개! (public)
  end;
```

---

## 🎯 초초보자를 위한 실무 핵심 요약

1. 클래스는 **`class`** 키워드로 선언한다!
2. 객체를 쓰려면 무조건 **`변수 := T클래스.Create;`** 명령으로 메모리에 먼저 만들어야 한다!
3. 다 쓴 객체는 메모리에서 지워줘야 하는데, 그 방법은 **다음 02-2 장**에서 배웁니다!

---

* **이전 단계**: [01-4. 프로시저와 함수 (procedure & function)](../01-basics/04-procedures-and-functions.md)
* **다음 단계**: [02-2. 생성자(Constructor)와 소멸자(Destructor)](02-constructor-destructor.md)
