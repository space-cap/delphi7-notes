unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormMain = class(TForm)
    LabelName: TLabel;
    EditName: TEdit;
    BtnGreet: TButton;
    MemoLog: TMemo;
    BtnClear: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnGreetClick(Sender: TObject);
    procedure BtnClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  // 폼 생성 시 초기화
  Caption := 'Delphi 7 VCL 이벤트 실습';
  EditName.Text := '홍길동';
  MemoLog.Lines.Add('=== 프로그램이 성공적으로 실행되었습니다. ===');
end;

procedure TFormMain.BtnGreetClick(Sender: TObject);
var
  UserName: String;
begin
  UserName := Trim(EditName.Text);
  if UserName = '' then
  begin
    ShowMessage('이름을 입력해 주세요!');
    EditName.SetFocus;
    Exit;
  end;

  // 메세지 띄우기 및 메모장에 로그 남기기
  ShowMessage('안녕하세요, ' + UserName + '님!');
  MemoLog.Lines.Add('[' + TimeToStr(Now) + '] 인사 완료: ' + UserName + '님');
end;

procedure TFormMain.BtnClearClick(Sender: TObject);
begin
  MemoLog.Clear;
  MemoLog.Lines.Add('=== 로그가 초기화되었습니다. ===');
end;

end.
