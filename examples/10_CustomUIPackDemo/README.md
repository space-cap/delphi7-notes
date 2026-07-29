# 10_CustomUIPackDemo 나만의 커스텀 VCL UI Pack 제작 실습 🎨

> 💡 **초초보자 & 신입 개발자를 위한 한 줄 요약**  
> 보내주신 이미지 속 **알약 형태의 보라색 모던 버튼(`+ 신규 수주 등록`)**을 델파이 커스텀 VCL 컴포넌트로 직접 제작하고, 델파이 컴포넌트 패키지(`.dpk`)로 팔레트에 설치하는 전체 과정 예제 프로젝트입니다!

---

## 🎯 이 예제에서 배우는 핵심 테크닉

1. **`TCustomControl` 상속**: 마우스 손모양 커서와 클릭/호버 반응을 가진 커스텀 UI 컨트롤 제작
2. **`CM_MOUSEENTER` / `CM_MOUSELEAVE` 메시지**: 마우스를 갖다 대면 색상이 살짝 밝아지는 웹 스타일 호버 애니메이션 구현
3. **`Paint` 오버라이드 & `Canvas.RoundRect`**: 보라색 알약 모양 모서리 라운딩 및 중앙 텍스트 랜더링
4. **`RegisterComponents('MyCustomPack', [TModernButton])`**: 델파이 상단 팔레트 탭에 내 컴포넌트 아이콘 등록
5. **델파이 패키지 파일 (`MyCustomPack.dpk`)**: `.dpk` 파일로 빌드하여 델파이 IDE에 모던 UI 팩 설치하기

---

## 📄 커스텀 버튼 주요 소스 코드 해설 (`ModernButton.pas`)

```pascal
unit ModernButton;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Types;

type
  // 보라색 모서리가 둥근 모던 버튼 컴포넌트
  TModernButton = class(TCustomControl)
  private
    FBGColor: TColor;
    FHoverColor: TColor;
    FTextColor: TColor;
    FCornerRadius: Integer;
    FIsMouseHover: Boolean;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property BGColor: TColor read FBGColor write FBGColor default $00E14B5C; // 보라색
    property HoverColor: TColor read FHoverColor write FHoverColor default $00F06675; // 밝은 보라색
    property TextColor: TColor read FTextColor write FTextColor default clWhite;
    property CornerRadius: Integer read FCornerRadius write FCornerRadius default 22; // 알약 모양
    property Caption;
    property Font;
    property OnClick;
  end;

procedure Register;

implementation

procedure Register;
begin
  // 델파이 컴포넌트 팔레트 상단 'MyCustomPack' 탭에 등록!
  RegisterComponents('MyCustomPack', [TModernButton]);
end;

constructor TModernButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBGColor := $00E14B5C;     // 보라색
  FHoverColor := $00F06675;  // 호버 시 밝은 보라색
  FTextColor := clWhite;
  FCornerRadius := 22;       // 동글동글 라운딩
  Cursor := crHandPoint;     // 마우스 손모양 커서
end;

// 마우스 호버 처리
procedure TModernButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FIsMouseHover := True;
  Invalidate; // 색상 고침!
end;

procedure TModernButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FIsMouseHover := False;
  Invalidate;
end;

// 캔버스 그리기
procedure TModernButton.Paint;
var
  CurrentBG: TColor;
  R: TRect;
begin
  if FIsMouseHover then CurrentBG := FHoverColor else CurrentBG := FBGColor;

  // 알약 모양 둥근 라운딩 배경 칠하기
  Canvas.Brush.Color := CurrentBG;
  Canvas.Pen.Color := CurrentBG;
  Canvas.RoundRect(0, 0, Width, Height, FCornerRadius, FCornerRadius);

  // 흰색 글자 캡션 그리기
  Canvas.Font := Font;
  Canvas.Font.Color := FTextColor;
  Canvas.Brush.Style := bsClear;
  R := ClientRect;
  DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_SINGLELINE or DT_CENTER or DT_VCENTER);
end;

end.
```

---

## 💻 델파이 7 IDE에서 실습하는 방법

### 1단계: 패키지 파일 설치하여 팔레트에 등록하기 (`.dpk`)
1. `examples/10_CustomUIPackDemo/` 폴더로 이동합니다.
2. **`MyCustomPack.dpk`** 패키지 프로젝트 파일을 마우스로 더블클릭하여 델파이 7 IDE에서 엽니다.
3. 델파이 패키지 창 상단의 **`Compile`** ➔ **`Install`** 버튼을 순서대로 클릭합니다.
4. 짠! 델파이 컴포넌트 팔레트에 **`MyCustomPack`** 탭과 **`TModernButton`** 버튼 컴포넌트 아이콘이 등록됩니다!

### 2단계: 테스트 앱 실행하기 (`UIPackTestApp.dpr`)
1. **`UIPackTestApp.dpr`** 프로젝트 파일을 더블클릭하여 엽니다.
2. 키보드의 **`F9`** 키를 눌러 실행합니다.
3. 화면에 뜬 **`+ 신규 수주 등록`** 보라색 알약 버튼에 마우스를 올려보고 클릭해 봅니다!

---

* **이전 단계**: [09_TabbedMDIERP 모던 탭 MDI ERP 실습](../09_TabbedMDIERP/README.md)
