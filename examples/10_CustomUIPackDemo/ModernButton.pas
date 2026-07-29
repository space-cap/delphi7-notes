unit ModernButton;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Types;

type
  // 둥근 모서리와 호버링 효과를 가진 모던 버튼 컴포넌트
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
    property BGColor: TColor read FBGColor write SetBGColor default $00E14B5C;
    property HoverColor: TColor read FHoverColor write SetHoverColor default $00F06675;
    property TextColor: TColor read FTextColor write SetTextColor default clWhite;
    property CornerRadius: Integer read FCornerRadius write SetCornerRadius default 22;
    property Caption;
    property Font;
    property ParentFont; // DFM 읽기 시 ParentFont 프로퍼티 지원
    property Enabled;
    property Visible;
    property OnClick;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('MyCustomPack', [TModernButton]);
end;

constructor TModernButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBGColor := $00E14B5C;     // 기본 배경색
  FHoverColor := $00F06675;  // 마우스 호버 색상
  FTextColor := clWhite;
  FCornerRadius := 22;       // 둥근 모서리 반지름
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

procedure TModernButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FIsMouseHover := True;
  Invalidate;
end;

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

procedure TModernButton.Paint;
var
  CurrentBG: TColor;
  R: TRect;
begin
  Canvas.Brush.Style := bsSolid;

  if FIsMouseHover then
    CurrentBG := FHoverColor
  else
    CurrentBG := FBGColor;

  if Parent <> nil then
  begin
    Canvas.Brush.Color := TForm(Parent).Color;
    Canvas.FillRect(ClientRect);
  end;

  Canvas.Brush.Color := CurrentBG;
  Canvas.Pen.Color := CurrentBG;
  Canvas.Pen.Width := 1;
  Canvas.RoundRect(0, 0, Width, Height, FCornerRadius, FCornerRadius);

  Canvas.Font := Font;
  Canvas.Font.Color := FTextColor;
  Canvas.Brush.Style := bsClear;

  R := ClientRect;
  DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_SINGLELINE or DT_CENTER or DT_VCENTER);
end;

initialization
  RegisterClass(TModernButton);

end.
