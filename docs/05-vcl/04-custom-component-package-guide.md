# 05-4. 나만의 커스텀 VCL UI Pack 패키지 제작 가이드 🛠️

> 💡 **초초보자 & 신입 개발자를 위한 한 줄 요약**  
> 델파이 상단 컴포넌트 팔레트에 나만의 아이콘 탭(예: `MyCustomPack`)을 새로 만들어서, 폼 위에 맘껏 끌어다 놓을 수 있는 **나만의 커스텀 VCL 컴포넌트 패키지(UI Pack)** 제작법을 배웁니다!

---

## ❓ 커스텀 VCL UI Pack이란 무엇인가요?

TMS Software, DevExpress 같은 델파이 대형 컴포넌트 회사처럼 **원하는 디자인과 동작을 가진 델파이용 부품(Component)**을 직접 개발하여 팔레트에 등록해 두고 쓰는 것을 말합니다.

---

## 🧱 1단계: 상속할 조상 클래스 선택하기

| 조상 클래스 | 특징 및 쓰임새 |
| :--- | :--- |
| **`TCustomPanel`** | 사이드바, 카드 레이아웃 등 내부에 다른 부품을 얹을 수 있는 둥근 패널 만들 때 |
| **`TCustomControl`** | 마우스 클릭/포커스를 받으며 완전히 새로운 자유 커스텀 버튼/스위치 UI 만들 때 |
| **`TGraphicControl`** | 포커스 없이 가볍게 화면에 도형/라벨 그림만 그리는 가벼운 시각 컴포넌트 만들 때 |

---

## 🎨 2단계: 나만의 컴포넌트 소스 코드 작성 (`MyModernPanel.pas`)

```pascal
unit MyModernPanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Types;

type
  // 1. TCustomPanel을 상속받아 나만의 커스텀 둥근 패널 제작!
  TMyModernPanel = class(TCustomPanel)
  private
    FBorderColor: TColor;
    FCornerRadius: Integer;
    procedure SetBorderColor(const Value: TColor);
    procedure SetCornerRadius(const Value: Integer);
  protected
    procedure Paint; override; // 화면에 예쁜 디자인 직접 그리기!
  public
    constructor Create(AOwner: TComponent); override;
  published
    // 2. 델파이 속성 창(Object Inspector)에 노출될 프로퍼티들!
    property BorderColor: TColor read FBorderColor write SetBorderColor default clBlue;
    property CornerRadius: Integer read FCornerRadius write SetCornerRadius default 15;
    property Align;
    property Caption;
    property Color;
    property Font;
    property OnClick;
  end;

// 3. 델파이 컴포넌트 팔레트에 등록하는 핵심 함수!
procedure Register;

implementation

constructor TMyModernPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBorderColor := clBlue;
  FCornerRadius := 15;
  Width := 160;
  Height := 100;
end;

procedure TMyModernPanel.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    Invalidate; // 속성이 변경되면 화면 새로고침!
  end;
end;

procedure TMyModernPanel.SetCornerRadius(const Value: Integer);
begin
  if FCornerRadius <> Value then
  begin
    FCornerRadius := Value;
    Invalidate;
  end;
end;

procedure TMyModernPanel.Paint;
begin
  // Canvas에 모서리가 둥근 그라데이션 테두리와 텍스트를 직접 다듬어 그립니다!
  Canvas.Brush.Color := Color;
  Canvas.Pen.Color := FBorderColor;
  Canvas.Pen.Width := 2;
  Canvas.RoundRect(0, 0, Width, Height, FCornerRadius, FCornerRadius);
  
  // 중앙 캡션 그리기
  Canvas.Font := Font;
  Canvas.TextOut((Width - Canvas.TextWidth(Caption)) div 2, 
                 (Height - Canvas.TextHeight(Caption)) div 2, Caption);
end;

// 컴포넌트 팔레트에 등록!
procedure Register;
begin
  // 'MyCustomPack' 탭에 TMyModernPanel 아이콘 추가
  RegisterComponents('MyCustomPack', [TMyModernPanel]);
end;

end.
```

---

## 📦 3단계: 델파이 패키지 프로젝트(`.dpk`) 생성 및 빌드

1. 델파이 7 IDE 상단 메뉴 ➔ **`File` ➔ `New` ➔ `Package - Delphi`** 선택
2. 패키지 프로젝트 파일(**`MyUIComponents.dpk`**)이 새로 떠오릅니다.
3. 패키지 창의 **`Contains`** 항목을 오른쪽 클릭 ➔ `Add...` 를 눌러 작성한 `MyModernPanel.pas` 파일 추가!

---

## 🚀 4단계: IDE 컴포넌트 팔레트에 설치 (`Install`)

1. 패키지 창 상단의 **`Compile`** 버튼을 클릭하여 소스 코드 오류가 없는지 확인합니다.
2. 이어서 **`Install`** 버튼을 클릭합니다.
3. 짠! `"Package MyUIComponents.bpl has been installed."` 알림창이 뜨고, 델파이 팔레트 탭 맨 끝에 **`MyCustomPack`** 이라는 나만의 탭이 추가됩니다!

---

## 👥 5단계: 제작한 커스텀 UI Pack을 사내 다른 프로젝트 및 팀원과 공유하는 3가지 실무 가이드

내가 만든 커스텀 VCL 패키지(`MyCustomPack.dpk` / `ModernButton.pas`)를 사내 다른 프로젝트나 팀원 컴퓨터에서도 똑같이 델파이 팔레트에 띄워 사용할 수 있게 배포하는 3가지 방법입니다.

---

### 🌟 방법 1: Git 사내 공유 + 델파이 `Library Path` 등록 (★ 팀 정석 표준 방법!)

팀원 각자의 컴퓨터 델파이 팔레트에 아이콘을 띄우고, 어느 프로젝트에서든 컴파일 오류 없이 사용하도록 만드는 가장 깔끔하고 완벽한 배포 방식입니다.

#### [Step 1] 팀 공용 Git 저장소 / 사내 네트워크 공유 폴더에 등록
* 사내 공유 경로(예: `D:\SharedVCL\MyCustomPack\`)에 아래 파일들을 올립니다:
  - `ModernButton.pas` (커스텀 버튼 소스)
  - `MyCustomPack.dpk` (패키지 프로젝트 파일)

#### [Step 2] 팀원 PC에서 델파이 IDE 패키지 설치 (`Install`)
* 팀원은 각자 자기 컴퓨터 델파이 7 IDE에서 `D:\SharedVCL\MyCustomPack\MyCustomPack.dpk` 파일 열기 ➔ **`Compile`** 클릭 ➔ **`Install`** 클릭!
* 팔레트 상단에 `MyCustomPack` 탭과 `TModernButton` 아이콘이 짠! 떠오릅니다.

#### [Step 3] 델파이 IDE `Library Path` 등록 (★ 가장 중요한 단계!)
* 델파이가 어느 프로젝트에서든 소스 위치를 자동으로 찾도록 경로를 등록합니다:
  1. 델파이 상단 메뉴: **`Tools` ➡️ `Environment Options`** 선택
  2. **`Library`** 탭 클릭
  3. **`Library path`** 항목 오른쪽의 `...` 버튼 클릭
  4. 공유 폴더 경로(`D:\SharedVCL\MyCustomPack\`)를 추가(`Add`)하고 `OK` 클릭!

> ⭕ **효과**: 이렇게 설정해두면 팀원이 사내의 어떤 델파이 프로젝트(`*.dpr`)를 열더라도 팔레트에서 내 보라색 모던 버튼을 폼 위에 맘껏 끌어다 쓸 수 있으며, 컴파일 시 `ModernButton.pas` 위치를 묻지 않고 척척 빌드됩니다!

---

### 📄 방법 2: 프로젝트 폴더에 `ModernButton.pas` 소스 직접 복사 (간편 사용)

패키지 설치 없이 빠른 테스트나 소규모 단독 프로젝트에 바로 사용하고 싶을 때 씁니다.

1. 다른 프로젝트 폴더 안으로 `ModernButton.pas` 파일만 복사해 옵니다.
2. 폼 소스 상단 `uses` 절에 `uses ModernButton;` 추가
3. `FormCreate` 시점에 동적으로 생성하여 사용:
   ```pascal
   Btn := TModernButton.Create(Self);
   Btn.Parent := Self;
   Btn.Caption := '+ 신규 수주 등록';
   ```

---

### 🛡️ 방법 3: 소스 코드 없이 `.bpl` 및 `.dcu` 컴파일 파일만 배포 (기업형 보안 배포)

외주업체나 외부 개발자에게 소스 코드(`.pas`)를 보여주지 않고 UI 기능만 배포하고 싶을 때 씁니다.

1. 내가 빌드하여 생성된 **`ModernButton.dcu`** 파일과 **`MyCustomPack.bpl`** 바이너리 파일만 전달합니다.
2. 상대방은 `Component ➡️ Install Packages` 메뉴에서 `.bpl` 파일만 등록하면 소스 코드 노출 없이 델파이 IDE 팔레트에서 컴포넌트를 사용할 수 있습니다.

---

* **이전 단계**: [05-3. 동적 컴포넌트 생성 및 이벤트 연결](03-dynamic-components.md)
* **다음 단계**: [06-1. 클래스와 객체의 구조와 생성자](../06-oop/01-classes-and-objects.md)
