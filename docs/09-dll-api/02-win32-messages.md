# 09-2. Windows 메시지 핸들링 및 커스텀 메시지 ✉️

> 💡 **초초보자를 위한 한 줄 요약**  
> 윈도우 운영체제(OS)와 프로그램, 혹은 **A 델파이 프로그램과 B 델파이 프로그램이 서로 "편지(Message)"를 보내 대화**하는 기법입니다!

---

## ✉️ 윈도우 메시지(Win32 Message)란?

마우스를 움직이거나, 키보드를 누르거나, 창 크기를 줄일 때 윈도우 OS는 해당 프로그램에게 **"WM_MOUSEMOVE"**, **"WM_SIZE"** 같은 메시지 편지를 발송합니다.

델파이에서는 이 편지를 낚아채서 내 입맛대로 처리할 수 있습니다!

---

## 📩 델파이에서 윈도우 메시지 낚아채는 법 (`message` 키워드)

```pascal
type
  TForm1 = class(TForm)
  private
    // 윈도우가 창 크기 변경(WM_SIZE) 편지를 보낼 때 작동할 프로시저 선언!
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
  end;

procedure TForm1.WMSize(var Msg: TWMSize);
begin
  inherited; // 기본 윈도우 동작 수행
  
  // 창 크기가 변경될 때 내 원하는 동작 실행!
  ShowMessage('창 크기가 변경되었습니다!');
end;
```

---

## 📨 2개 프로그램 간 대화: `WM_COPYDATA` (커스텀 메시지)

프로그램 A에서 프로그램 B로 글자나 데이터를 보내고 싶을 때 Win32 API 메시지인 **`WM_COPYDATA`** 를 자주 활용합니다!

---

* **이전 단계**: [09-1. C/C++ DLL 연동 (정적 & 동적 로딩)](01-dll-loading.md)
* **다음 단계**: [10-1. 커스텀 VCL 컴포넌트 제작 기초](../10-advanced/01-custom-component.md)
