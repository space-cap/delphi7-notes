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
    ModernButton1: TModernButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnNewOrderClick(Sender: TObject);
  private
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
  MemoLog.Lines.Add('=== TModernButton 커스텀 UI 버튼 준비 완료 ===');

  // 1. 디자이너 모드 폼에 배치된 ModernButton1 클릭 이벤트 연결
  if ModernButton1 <> nil then
  begin
    ModernButton1.OnClick := BtnNewOrderClick;
  end;
end;

procedure TFormTest.BtnNewOrderClick(Sender: TObject);
begin
  MemoLog.Lines.Add('[' + TimeToStr(Now) + '] "+ 신규 수주 등록" 버튼이 클릭되었습니다!');
  ShowMessage('신규 수주 등록 화면 창이 호출되었습니다!');
end;

end.
