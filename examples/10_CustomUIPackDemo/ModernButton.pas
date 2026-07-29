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
    procedure SetBGColor(const Value: TColor);
    procedure SetHoverColor(const Value: TColor);
    procedure SetTextColor(const Value: TColor);
    procedure SetCornerRadius(const Value: Integer);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure Paint; override;
    procedure Click; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property BGColor: TColor read FBGColor write SetBGColor default $00E14B5C; // 보라색
    property HoverColor: TColor read FHoverColor write SetHoverColor default $00F06675; // 호버 시 밝은 보라
    property TextColor: TColor read FTextColor write SetTextColor default clWhite;
    property CornerRadius: Integer read FCornerRadius write SetCornerRadius default 22;
    property Caption;
    property Font;
    property Enabled;
    property Visible;
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
  FBGColor := $00E14B5C;     // 보라색 ($5CB4E1 -> BGR)
  FHoverColor := $00F06675;  // 밝은 보라색
  FTextColor := clWhite;
  FCornerRadius := 22;       // 동글동글 모서리
  FIsMouseHover := False;
  Width := 160;
  Height := 40;
  Cursor := crHandPoint;     // 마우스 손모양 커서
  DoubleBuffered := True;
end;

procedure TModernButton.SetBGColor(const Value: TColor);
begin
  if FBGColor <> Value then
  begin
    FBGColor := Value;
    Invalidate;
  end;
end;

procedure TModernButton.SetHoverColor(const Value: TColor);
begin
  if FHoverColor <> Value then
  begin
    FHoverColor := Value;
    Invalidate;
  end;
end;

procedure TModernButton.SetTextColor(const Value: TColor);
begin
  if FTextColor <> Value then
  begin
    FTextColor := Value;
    Invalidate;
  end;
end;

procedure TModernButton.SetCornerRadius(const Value: Integer);
begin
  if FCornerRadius <> Value then
  begin
    FCornerRadius := Value;
    Invalidate;
  end;
end;

// 마우스 진입 메세지 처리 (호버 효과)
procedure TModernButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FIsMouseHover := True;
  Invalidate;
end;

// 마우스 이탈 메세지 처리
procedure TModernButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FIsMouseHover := False;
  Invalidate;
end;

procedure TModernButton.Click;
begin
  inherited Click;
end;

// 화면 그리기 (Paint 메서드 오버라이드)
procedure TModernButton.Paint;
var
  CurrentBG: TColor;
  R: TRect;
begin
  Canvas.Brush.Style := bsSolid;

  // 마우스 호버 여부에 따른 배경색 결정
  if FIsMouseHover then
    CurrentBG := FHoverColor
  else
    CurrentBG := FBGColor;

  // 1. 투명 영역 칠하기 (부모 배경색)
  if Parent <> nil then
  begin
    Canvas.Brush.Color := TForm(Parent).Color;
    Canvas.FillRect(ClientRect);
  end;

  // 2. 동글동글 모서리 배경 칠하기
  Canvas.Brush.Color := CurrentBG;
  Canvas.Pen.Color := CurrentBG;
  Canvas.Pen.Width := 1;
  Canvas.RoundRect(0, 0, Width, Height, FCornerRadius, FCornerRadius);

  // 3. 중앙 텍스트(Caption) 그리기
  Canvas.Font := Font;
  Canvas.Font.Color := FTextColor;
  Canvas.Brush.Style := bsClear; // 글자 배경 투명

  R := ClientRect;
  DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_SINGLELINE or DT_CENTER or DT_VCENTER);
end;

end.
