unit TestForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ModernButton;

type
  TFormTest = class(TForm)
    LabelTitle: TLabel;
    LabelGuide: TLabel;
    MemoLog: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    BtnNewOrder: TModernButton;
    procedure BtnNewOrderClick(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FormTest: TFormTest;

implementation

{$R *.dfm}

procedure TFormTest.FormCreate(Sender: TObject);
begin
  MemoLog.Lines.Clear;
  MemoLog.Lines.Add('=== 커스텀 TModernButton 컴포넌트가 동적 생성되었습니다. ===');

  // 이미지 속 알약 형태 보라색 커스텀 버튼을 동적으로 폼에 생성!
  BtnNewOrder := TModernButton.Create(Self);
  BtnNewOrder.Parent := Self;
  BtnNewOrder.Left := 24;
  BtnNewOrder.Top := 80;
  BtnNewOrder.Width := 180;
  BtnNewOrder.Height := 45;
  BtnNewOrder.Caption := '+ 신규 수주 등록';
  BtnNewOrder.Font.Name := '굴림';
  BtnNewOrder.Font.Style := [fsBold];
  BtnNewOrder.Font.Size := 10;
  BtnNewOrder.CornerRadius := 35; // 알약 모양 동글동글 라운딩
  BtnNewOrder.OnClick := BtnNewOrderClick;
end;

procedure TFormTest.BtnNewOrderClick(Sender: TObject);
begin
  MemoLog.Lines.Add('[' + TimeToStr(Now) + '] "+ 신규 수주 등록" 버튼이 클릭되었습니다!');
  ShowMessage('신규 수주 등록 화면 창이 호출되었습니다!');
end;

end.
