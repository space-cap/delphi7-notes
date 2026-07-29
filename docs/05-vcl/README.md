# 05. 델파이 VCL (Visual Component Library) 완벽 개념 가이드 🎨

> 💡 **초초보자를 위한 한 줄 요약**  
> **VCL**이란 델파이가 윈도우 프로그램을 레고 블록처럼 손쉽게 만들 수 있도록 준비해 둔 **"시각적 부품 라이브러리 백화점"**입니다!

---

## ❓ VCL(Visual Component Library)이란 무엇인가요?

**VCL**은 **Visual Component Library(시각적 컴포넌트 라이브러리)**의 약자입니다.

1. **과거(C/C++ Win32 API 시절)**:
   - 윈도우에 버튼 하나, 창 하나를 띄우려면 복잡한 C언어 코드 수백 줄(`WinMain`, `WNDCLASS`, `CreateWindowEx`, `DispatchMessage` 등)을 직접 타이핑해야 했습니다.
2. **델파이 VCL의 혁명 (RAD 프로그래밍)**:
   - 델파이는 윈도우의 복잡한 C/C++ 내부 동작을 파스칼 클래스로 예쁘게 포장(캡슐화)하여 **마우스로 팔레트에서 버튼을 끌어다 놓기만 해도 복잡한 코드가 자동 생성되는 혁명(Rapid Application Development)**을 이루어냈습니다!

---

## 🧱 델파이 VCL 족보 (클래스 상속 계층도) 🌳

델파이의 모든 부품(버튼, 폼, 라벨 등)은 족보처럼 최상위 조상 클래스로부터 상속받아 태어났습니다!

```text
TObject (델파이 모든 객체의 최상위 할아버지)
  └── TPersistent (IDE 속성 창에 정보를 저장/복원할 수 있는 능력)
        └── TComponent (팔레트에 얹고 Owner 소유권 관리를 받는 부품)
              └── TControl (화면에 눈으로 그려지는 Visual 컨트롤)
                    └── TWinControl (윈도우 핸들 HWND를 갖고 포커스를 받는 조상)
                          ├── TCustomForm ➔ TForm (우리가 만드는 화면 창!)
                          ├── TButton / TEdit / TMemo (버튼 및 입력 상자)
                          └── TDBGrid (데이터베이스 표 그리드)
```

### 🧬 VCL 조상들의 역할 4단계!
1. **`TObject`**: 메모리에 할당되고 해제되는 모든 파스칼 객체의 으뜸 조상입니다.
2. **`TPersistent`**: 델파이 IDE 왼쪽의 **Object Inspector** 창에서 속성(Property)을 마우스로 바꿀 수 있게 해주는 조상입니다.
3. **`TComponent`**: 컴포넌트 팔레트 탭에 아이콘으로 등록되어 폼(`Form`)이 메모리를 관리해 주는 조상입니다.
4. **`TWinControl`**: 윈도우 OS의 진짜 핸들(`HWND`)을 가지고 있어서 마우스로 클릭하거나 키보드 포커스(`SetFocus`)를 받을 수 있는 실체적인 윈도우 조상입니다.

---

## 💎 VCL을 지탱하는 3대 핵심 요소 (속성, 이벤트, 메소드)

델파이의 모든 VCL 컴포넌트는 아래 3가지 요소로 작동합니다.

### 1) 속성 (Property) - 모양과 상태
- 컴포넌트의 글자, 색상, 너비, 높이 등 **상태값**을 나타냅니다.
- 예: `Button1.Caption := '저장';`, `Edit1.Text := '홍길동';`

### 2) 이벤트 (Event) - 일어난 사건과 대처 (Handler)
- 사용자가 마우스로 클릭하거나, 폼이 켜질 때 발생하는 **사건(신호)**입니다.
- 예: `OnClick` (버튼 클릭 시), `OnCreate` (폼 탄생 시)

### 3) 메소드 (Method) - 컴포넌트가 하는 행동 명령
- 컴포넌트가 직접 수행하는 **함수/프로시저 동작**입니다.
- 예: `Edit1.SetFocus;` (포커스 이동), `Form1.Close;` (창 닫기)

---

## 📚 05. VCL 단원 학습 목차

* **05-0. 컴포넌트 팔레트 전수 가이드**: [00-component-palette-guide.md](00-component-palette-guide.md)
* **05-0(상세). 25개 탭 전수 대백과사전**: [palette/README.md](palette/README.md)
* **05-1. 폼(Form) 생명주기와 주요 이벤트**: [01-form-lifecycle.md](01-form-lifecycle.md)
* **05-2. 기본 VCL 컴포넌트 제어 (Button, Edit, Memo 등)**: [02-basic-components.md](02-basic-components.md)
* **05-3. 동적 컴포넌트 생성 및 이벤트 연결**: [03-dynamic-components.md](03-dynamic-components.md)
* **05-4. 나만의 커스텀 VCL UI Pack 패키지 제작 가이드**: [04-custom-component-package-guide.md](04-custom-component-package-guide.md)
