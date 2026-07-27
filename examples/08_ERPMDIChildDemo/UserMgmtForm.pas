unit UserMgmtForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormUserMgmt = class(TForm)
    LabelTitle: TLabel;
    Label1: TLabel;
    EditID: TEdit;
    Label2: TLabel;
    EditName: TEdit;
    BtnSave: TButton;
    MemoLog: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUserMgmt: TFormUserMgmt;

implementation

uses MDIMainForm;

{$R *.dfm}

procedure TFormUserMgmt.FormCreate(Sender: TObject);
begin
  MemoLog.Lines.Clear;
  MemoLog.Lines.Add('=== 사용자 관리 MDI Child 창이 생성되었습니다. ===');
end;

// ★ 실무 MDI Child 창 필수 코드!
// X버튼으로 닫힐 때 메모리에서 깔끔하게 해제(caFree)합니다!
procedure TFormUserMgmt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree; // 창을 닫음과 동시에 메모리 해제!
  if FormMDIMain <> nil then
    FormMDIMain.ChildFormClosed;
end;

procedure TFormUserMgmt.BtnSaveClick(Sender: TObject);
begin
  MemoLog.Lines.Add('[' + TimeToStr(Now) + '] 사용자 저장 완료: ' + EditID.Text + ' (' + EditName.Text + ')');
  ShowMessage('사용자 정보가 저장되었습니다.');
end;

end.
