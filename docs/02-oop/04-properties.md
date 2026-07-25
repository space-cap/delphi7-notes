# 02-4. 프로퍼티(Property)와 이벤트 핸들링 🎁⚡

> 💡 **초초보자를 위한 한 줄 요약**  
> * **프로퍼티 (`property`)**: 변수인 척하고 마스크를 썼지만, 읽고 쓸 때 뒤에서 검사 로직(함수)이 몰래 돌아가는 **"스마트 변수"**  
> * **이벤트 (`OnClick` 등)**: "버튼을 누르면 실행해라!" 하고 미리 등록해 두는 **"콜백 센서"**

---

## 🎁 1. 프로퍼티 (`property`) 란 무엇인가요?

변수에 값을 직접 넣으면 음수 나이(`Age := -5`) 같은 이상한 값이 들어갈 수 있습니다. 

프로퍼티를 쓰면 밖에서는 일반 변수처럼 보이지만, 값을 넣거나 읽을 때 **안전 검사 함수**가 동작하게 만들 수 있습니다!

```pascal
type
  TPerson = class
  private
    FAge: Integer; // 실제 나이 기록 상자 (보통 F를 앞에 붙임)
    procedure SetAge(const Value: Integer); // 나이 검사 함수
  public
    // ★ 프로퍼티 선언: 읽을 땐 FAge를 읽고, 쓸 땐 SetAge 함수를 거친다!
    property Age: Integer read FAge write SetAge;
  end;

procedure TPerson.SetAge(const Value: Integer);
begin
  if Value < 0 then
    ShowMessage('나이는 0보다 작을 수 없습니다!')
  else
    FAge := Value; // 안전할 때만 값 집어넣기!
end;
```

---

## ⚡ 2. 이벤트 핸들링 (Event Handling)

델파이 VCL에서 가장 멋진 부분입니다! 

사용자가 버튼을 클릭(`OnClick`)하거나 키보드를 누를 때, 내가 만든 특정 프로시저가 작동하도록 **이벤트와 내 코드를 연결**해 주는 기술입니다.

```pascal
// 델파이 IDE에서 버튼을 더블클릭하면 자동으로 생기는 이벤트 핸들러 코드
procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage('버튼이 눌렸습니다! 🚀');
end;
```

### 🙋‍♂️ `Sender: TObject` 가 뭔가요?
이벤트 프로시저 괄호 안에 있는 `Sender`는 **"누가 나를 눌렀는지 알려주는 정보"**입니다!

```pascal
procedure TForm1.AnyButtonClick(Sender: TObject);
begin
  // 클릭된 컴포넌트의 이름 표시
  ShowMessage((Sender as TButton).Caption + ' 버튼이 눌렸네요!');
end;
```

---

## 🎯 초초보자를 위한 핵심 요약

1. 프로퍼티는 `property 이름 read 읽기변수 write 쓰기함수;` 형태로 작성한다!
2. 이벤트 핸들러는 사용자의 마우스/키보드 동작 반응 센서이다!
3. `Sender`는 이 이벤트를 일으킨 범인(버튼, 에디트박스 등)을 가리킨다!

---

* **이전 단계**: [02-3. 상속, 캡슐화, 다형성](03-inheritance.md)
* **다음 단계**: [03-1. try...finally 기반 안전한 객체 해제 패턴](../03-memory/01-try-finally.md)
