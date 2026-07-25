# 02-2. 생성자(Constructor)와 소멸자(Destructor) 🐣☠️

> 💡 **초초보자를 위한 한 줄 요약**  
> * **생성자 (`constructor Create`)**: 객체가 태어날 때 시동을 걸고 기본 세팅을 해주는 **"탄생 의식"**  
> * **소멸자 (`destructor Destroy`)**: 다 쓴 객체를 메모리에서 완전히 지우는 **"장례식"**

---

## 🐣 1. 생성자 (`constructor Create`)

객체가 메모리에 만들어지는 그 순간 **자동으로 실행되는 특별한 함수**입니다.

* **하는 일**: 변수의 초기값 설정하기, 내부 필요한 메모리 미리 확보하기.

```pascal
type
  TUser = class
  public
    Name: String;
    Score: Integer;
    
    // 생성자 선언
    constructor Create; 
  end;

// 생성자 구체적 내용
constructor TUser.Create;
begin
  inherited Create; // 부모 클래스의 생성자 먼저 호출!
  Name := '손님';    // 기본 이름 초기화
  Score := 100;     // 기본 점수 100점 세팅
end;
```

---

## ☠️ 2. 소멸자 (`destructor Destroy`)

객체가 일 다 마치고 사라질 때 **자동으로 실행되는 마무리 청소 함수**입니다.

* **하는 일**: 객체 내부에서 따로 썼던 메모리나 임시 파일 깔끔하게 정리하기.

```pascal
destructor TUser.Destroy;
begin
  // 내부 정리 작업 수행...
  inherited Destroy; // 부모 소멸자 호출 (맨 마지막에!)
end;
```

---

## 🧹 3. 객체를 안전하게 해제하는 공식: `Free` vs `Destroy`

실제로 우리가 작성하는 코드에서 객체를 해제할 때는 `Destroy`를 직접 부르지 않고 **`Free`** 메서드를 호출합니다!

### ❓ 왜 Destroy 대신 `Free`를 쓰나요?
* 만약 객체가 아예 만들어지지 않은 상태(Nil)에서 `Destroy`를 부르면 **프로그램이 뻗습니다(Access Violation)!**
* 하지만 `Free`를 부르면 내부에서 **"객체가 진짜 존재하는지 확인하고 안전하게 Destroy를 불러주기"** 때문에 훨씬 안전합니다!

```pascal
var
  User: TUser;
begin
  User := TUser.Create;
  try
    ShowMessage(User.Name + '님의 점수: ' + IntToStr(User.Score));
  finally
    User.Free; // ★ 객체를 다 썼으면 반드시 Free로 메모리 해제!
  end;
end;
```

---

## 🎯 초초보자를 위한 메모리 관리 황금 법칙

> **"내가 `Create` 로 태어난 객체는, 반드시 내가 `Free` 로 지워준다!"**

이 원칙만 지키면 델파이 프로그램에서 메모리가 줄줄 새는 현상(Memory Leak)을 100% 방지할 수 있습니다!

---

* **이전 단계**: [02-1. 클래스(Class) 선언과 객체 생성](01-class-and-object.md)
* **다음 단계**: [02-3. 상속, 캡슐화, 다형성](03-inheritance.md)
