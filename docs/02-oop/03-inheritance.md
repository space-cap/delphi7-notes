# 02-3. 상속, 캡슐화, 다형성 🧬

> 💡 **초초보자를 위한 한 줄 요약**  
> 객체지향 3대 마법!  
> 1. **상속**: 부모의 능력을 물려받아 재사용한다.  
> 2. **캡슐화**: 중요한 속 알맹이는 꽁꽁 숨긴다.  
> 3. **다형성**: 같은 명령을 내리되 동물마다 다르게 반응한다.

---

## 👪 1. 상속 (Inheritance) - "부모님 피 물려받기"

부모 클래스가 만들어둔 코드(변수, 프로시저)를 그대로 물려받고, 거기에 **나만의 새로운 기능을 덧붙이는 것**입니다.

```pascal
type
  // [부모 클래스] 일반 동물
  TAnimal = class
  public
    Name: String;
    procedure Move;
  end;

  // [자식 클래스] TAnimal을 상속받은 새(Bird)
  TBird = class(TAnimal) // (TAnimal)을 써서 상속받음!
  public
    procedure Fly; // 자식만 가진 새로운 기능 추가!
  end;
```

---

## 💊 2. 캡슐화 (Encapsulation) - "알약 껍질 속에 비밀 덮기"

객체 내부의 복잡한 작동 방식이나 중요한 데이터(주민번호, 계좌 잔액)를 외부에 함부로 노출하지 않고 **숨겨두는 것**입니다.

* `private` 구역에 변수를 숨기고, 오직 검증된 프로시저(함수)를 통해서만 안전하게 접근하게 만듭니다.

```pascal
type
  TBankAccount = class
  private
    FBalance: Integer; // 계좌 잔액은 비밀(private)!
  public
    // 안전하게 돈을 넣는 창구만 공개(public)
    procedure Deposit(Amount: Integer);
  end;
```

---

## 🎭 3. 다형성 (Polymorphism) & `override` - "같은 명령, 다른 동작"

부모가 "소리를 내라(`MakeSound`)"라고 했을 때, 개는 "멍멍!", 고양이는 "야옹~"하고 **자기 스타일에 맞춰 바꿔서 행동하는 능력**입니다.

델파이에서는 부모 쪽에 **`virtual`**(재정의 허용), 자식 쪽에 **`override`**(내가 덮어쓰기 함)라는 키워드를 붙입니다!

```pascal
type
  // [부모]
  TAnimal = class
  public
    procedure MakeSound; virtual; // 자식이 고쳐써도 된다고 허락(virtual)!
  end;

  // [자식 1] 개
  TDog = class(TAnimal)
  public
    procedure MakeSound; override; // 부모 명령을 덮어씀(override)!
  end;

procedure TDog.MakeSound;
begin
  ShowMessage('멍멍! 🐶');
end;
```

---

## 🎯 초초보자를 위한 실무 요약

* 상속받을 때는 `T자식 = class(T부모)`
* 부모 기능을 덮어써서 새로 만들 때는 부모에 `virtual;`, 자식에 `override;` 키워드를 쌍으로 붙인다!

---

* **이전 단계**: [02-2. 생성자(Constructor)와 소멸자(Destructor)](02-constructor-destructor.md)
* **다음 단계**: [02-4. 프로퍼티(Property)와 이벤트 핸들링](04-properties.md)
