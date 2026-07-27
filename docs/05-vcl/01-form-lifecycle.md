# 05-1. 폼(Form) 생명주기와 주요 이벤트 🔄

> 💡 **초초보자를 위한 한 줄 요약**  
> 윈도우 창(Form)도 **"탄생 ➡️ 화면에 나타남 ➡️ 닫힘 ➡️ 소멸"**의 일생이 있습니다. 이벤트 순서를 알아야 원하는 타이밍에 코드를 넣을 수 있습니다!

---

## 🔄 폼(Form)이 태어나서 죽을 때까지의 5대 순서!

화면 창이 켜지고 꺼질 때 아래 순서대로 이벤트가 자동 발생합니다!

```text
[ 켜질 때 ]  1. OnCreate ➡️ 2. OnShow ➡️ 3. OnActivate
[ 켜진 후 ]  사용자가 버튼 누르고 폼과 대화...
[ 꺼질 때 ]  4. OnClose ➡️ 5. OnDestroy
```

---

## 📌 주요 이벤트별 쓰임새 정리

### 1. `OnCreate` (탄생 직후) 🐣
* **시점**: 폼 메모리가 만들어지는 그 극초반 순간!
* **쓰임새**: 변수 초기화, DB 연결 준비, 화면 켜지기 전 비하인드 세팅할 때 씁니다.
* **💡 IDE 팁 (자동 코드 생성)**:
  - 델파이 화면 디자인 모드에서 **폼 바탕화면 빈 곳을 마우스로 더블클릭**하면 델파이가 알아서 파스칼 소스 코드에 `procedure FormCreate(Sender: TObject);` 함수를 자동으로 작성해 줍니다!
  - 또는 왼쪽 **Object Inspector ➔ `Events` 탭 ➔ `OnCreate`** 항목을 더블클릭하셔도 됩니다.

### 2. `OnShow` (화면에 그려지기 직전) 👁️
* **시점**: 화면에 폼 창이 뿅! 하고 눈에 보이기 바로 직전!
* **쓰임새**: DB에서 최신 글 목록 가져와서 그리드에 띄우기, 첫 번째 입력칸에 포커스 줄 때 씁니다.

### 3. `OnClose` (창 닫기 엑스표 누를 때) 🚪
* **시점**: 사용자가 오른쪽 위 X 버튼을 누를 때!
* **쓰임새**: "정말 종료하시겠습니까?" 물어보거나, 폼을 닫을지 숨길지 결정할 때 씁니다.
  ```pascal
  procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
    Action := caFree; // 폼을 닫음과 동시에 메모리에서도 깔끔히 해제!
  end;
  ```

### 4. `OnDestroy` (메모리에서 소멸될 때) ☠️
* **시점**: 폼이 완전히 파괴되어 사라질 때!
* **쓰임새**: `OnCreate`에서 만들었던 객체나 포인터를 `Free` 할 때 씁니다.

---

## 🪟 폼의 종류를 결정하는 `FormStyle` 4가지 옵션!

델파이 폼의 **`FormStyle`** 프로퍼티(속성)는 이 창이 어떤 유형의 창으로 동작할지 결정합니다.

| FormStyle 옵션 | 의미 및 비유 | 실무 쓰임새 |
| :--- | :--- | :--- |
| **`fsNormal`** | **기본 일반 창** | 보통 다루는 가장 흔한 표준 독립 윈도우 창입니다. (기본값) |
| **`fsMDIForm`** | **MDI 부모 액자 창** | **ERP 메인 화면!** 여러 개의 자식 창(`fsMDIChild`)을 내부에 다 담아서 관리하는 메인 큰 액자 창입니다. |
| **`fsMDIChild`** | **MDI 자식 부속 창** | **ERP 메뉴 창!** 반드시 부모 창(`fsMDIForm`) 내부 영역 안에서만 생성되고 움직이는 서브 창입니다. |
| **`fsStayOnTop`**| **항상 최상단 핀 창** | 다른 어떤 윈도우 창들보다 **무조건 맨 위에 항상 떠있는 창**입니다. (미니 툴바, 계산기, 시계, 팝업 알림창 등) |

---

## 🧩 MDI 폼 관리를 위한 델파이 내장 프로퍼티 (`MDIChildCount`, `MDIChildren`)

폼을 **`FormStyle := fsMDIForm;` (MDI 부모 창)**으로 만드는 순간, 델파이 VCL 엔진이 내부에 열려 있는 자식 창들을 실시간 자동 추적해 주는 **2대 내장 프로퍼티**를 제공합니다.

1. **`MDIChildCount`** (`Integer`): 현재 MDI 부모 창 내부에 열려 있는 자식 창(`fsMDIChild`)의 총 개수입니다.
2. **`MDIChildren[Index]`** (`TForm` 배열): 0번부터 `MDIChildCount - 1`번까지 열려 있는 자식 창 객체들을 차례대로 담고 있는 **내장 폼 배열**입니다.

### 💡 실무 ERP 중복 창 생성 방지 100점 코드:
```pascal
// 이미 열린 창이 있으면 새로 안 띄우고 앞으로(BringToFront) 가져오는 패턴
for I := 0 to MDIChildCount - 1 do
begin
  if MDIChildren[I] is TFormUserMgmt then
  begin
    MDIChildren[I].BringToFront; // 이미 열려 있으므로 앞으로 포커스!
    Exit;
  end;
end;
```

---

## 🏠 폼 동적 생성 시 `Application`과 Owner(소유자)의 개념 (`Create(Application)`)

코드에서 폼을 새로 띄울 때 `TForm.Create(AOwner)` 형태로 생성자를 호출합니다.

```pascal
// MDI 자식 폼 동적 생성 예시
FormUserMgmt := TFormUserMgmt.Create(Application);
```

### 1) `Application` 변수는 어디에서 온 건가요?
* **출처**: 델파이 기본 라이브러리인 **`Forms` 유닛**(`uses Forms;`)에 내장된 **전역 응용 프로그램 객체**입니다.
* `uses Forms;` 절이 작성되어 있기 때문에 사용자가 선언할 필요 없이 프로그램 어디서나 즉시 사용할 수 있습니다.

### 2) `Create(Application)` vs `Create(Self)` 소유자(Owner) 차이점!

| 구 분 | 의미 및 작동 특징 |
| :--- | :--- |
| **`Create(Application)`** | 새로 띄우는 폼의 **주인(Owner)**을 **프로그램 전체(`Application`)**로 지정합니다. 프로그램이 완전히 종료될 때 델파이가 책임지고 이 폼을 메모리에서 해제(자동 청소)합니다. |
| **`Create(Self)`** | 새로 띄우는 폼의 **주인(Owner)**을 **현재 폼(자기 자신)**으로 지정합니다. 현재 메인 폼이 파괴될 때 자식 폼도 함께 메모리에서 해제됩니다. |

---

## 🎯 초초보자를 위한 실무 핵심 요약

* 화면에 데이터를 처음 갱신해서 보여주고 싶다면 ➡️ **`OnShow`** 이벤트에 코드를 적으세요!
* 폼이 켜질 때 딱 한 번 초기화 세팅을 하고 싶다면 ➡️ **`OnCreate`** 이벤트에 코드를 적으세요!

---

* **이전 단계**: [05-0. 델파이 7 컴포넌트 팔레트(Component Palette) 탭별 완벽 가이드](00-component-palette-guide.md)
* **다음 단계**: [05-2. 기본 VCL 컴포넌트 제어 (Button, Edit, Memo 등)](02-basic-components.md)
