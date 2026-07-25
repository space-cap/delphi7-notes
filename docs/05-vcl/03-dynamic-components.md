# 05-3. 동적 컴포넌트 생성 및 이벤트 연결 🪄

> 💡 **초초보자를 위한 한 줄 요약**  
> 마우스로 버튼을 안 올려놓고, 프로그램이 실행되는 도중에 소스 코드로 **버튼을 짠! 하고 즉석 생성**하는 마법 같은 테크닉입니다!

---

## 🪄 소스 코드로 버튼(TButton) 즉석 생성하기

동적 생성(Dynamic Creation)은 화면 디자인 폼(`.dfm`)에 없는 컴포넌트를 코드로 즉석 조립해 띄우는 것입니다.

```pascal
procedure TForm1.CreateButtonDynamically;
var
  NewBtn: TButton;
begin
  // 1. 버튼 생성 (Self는 이 버튼의 주인이 Form1 이라는 뜻!)
  NewBtn := TButton.Create(Self);
  
  // 2. ★ 중요: 이 버튼이 얹혀서 살 '부모 방(Parent)' 지정!
  NewBtn.Parent := Form1; 
  
  // 3. 모양 및 위치 설정
  NewBtn.Left := 50;
  NewBtn.Top := 50;
  NewBtn.Width := 120;
  NewBtn.Caption := '코드로 만든 버튼';
  
  // 4. 이벤트 연결 (클릭했을 때 일어날 프로시저 연결!)
  NewBtn.OnClick := DynamicBtnClick;
end;

// 동적 버튼을 눌렀을 때 실행될 프로시저
procedure TForm1.DynamicBtnClick(Sender: TObject);
begin
  ShowMessage('동적으로 생성된 버튼이 클릭되었습니다! 🎉');
end;
```

---

## ⚠️ 동적 생성 시 절대 잊으면 안 되는 필수 2가지!

1. **`Parent` 지정**: `NewBtn.Parent := Form1;` (안 적으면 화면에 안 보이고 `Has no parent window` 에러 발생!)
2. **`OnClick` 이벤트 연결**: `NewBtn.OnClick := 프로시저이름;` (괄호`()` 빼고 프로시저 이름만 작성!)

---

## 🎯 초초보자를 위한 실무 유용성

* DB에 저장된 항목 개수(5개, 10개)에 따라 화면에 버튼이나 체크박스를 가변적으로 늘려가며 생성해야 할 때 동적 생성을 아주 유용하게 사용합니다!

---

* **이전 단계**: [05-2. 기본 VCL 컴포넌트 제어 (Button, Edit, Memo 등)](02-basic-components.md)
* **다음 단계**: [06-1. Windows 10/11 환경에서 Delphi 7 IDE 설정](../06-tips/01-win10-setup.md)
