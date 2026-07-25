# 10-1. 커스텀 VCL 컴포넌트 제작 기초 🛠️

> 💡 **초초보자를 위한 한 줄 요약**  
> 델파이 기본 버튼이나 레고 부품이 마음에 안 들 때, 기존 컴포넌트를 상속받아 **"나만의 전용 맞춤 부품(Custom Component)"**을 직접 깎아 만드는 기초 과정입니다!

---

## 🛠️ 커스텀 컴포넌트 제작 3단계

1. **상속받을 부모 결정**: `TButton`, `TEdit`, `TComponent` 중 하나를 상속받기
2. **새로운 기능/속성 추가**: `published` 구역에 새로운 프로퍼티나 이벤트 만들기
3. **컴포넌트 팔레트에 등록**: `Register` 프로시저 작성 후 델파이 IDE 팔레트에 탭 등록하기!

```pascal
type
  // 기존 TEdit를 상속받아 숫자만 입력받는 에디트 상자 만들기!
  TNumberOnlyEdit = class(TEdit)
  protected
    procedure KeyPress(var Key: Char); override; // 키보드 입력 덮어쓰기
  end;

procedure TNumberOnlyEdit.KeyPress(var Key: Char);
begin
  // 숫자가 아니거나 백스페이스가 아니면 입력 차단!
  if not (Key in ['0'..'9', #8]) then
    Key := #0
  else
    inherited KeyPress(Key);
end;
```

---

* **이전 단계**: [09-2. Windows 메시지 핸들링 및 커스텀 메시지](../09-dll-api/02-win32-messages.md)
* **다음 단계**: [10-2. FastMM4를 이용한 메모리 누수(Memory Leak) 추적](01-fastmm4-debugging.md)
