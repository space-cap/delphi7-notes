unit OrderRegForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormOrderReg = class(TForm)
    LabelTitle: TLabel;
    Label1: TLabel;
    EditProduct: TEdit;
    Label2: TLabel;
    EditQty: TEdit;
    BtnOrder: TButton;
    MemoLog: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnOrderClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormOrderReg: TFormOrderReg;

implementation

uses MDIMainForm;

{$R *.dfm}

procedure TFormOrderReg.FormCreate(Sender: TObject);
begin
  MemoLog.Lines.Clear;
  MemoLog.Lines.Add('=== 주문 등록 MDI Child 창이 생성되었습니다. ===');
end;

procedure TFormOrderReg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree; // 창을 닫음과 동시에 메모리 해제!
  if FormMDIMain <> nil then
    FormMDIMain.ChildFormClosed;
end;

procedure TFormOrderReg.BtnOrderClick(Sender: TObject);
begin
  MemoLog.Lines.Add('[' + TimeToStr(Now) + '] 주문 접수 완료: ' + EditProduct.Text + ' ' + EditQty.Text + '개');
  ShowMessage('주문 접수가 성공적으로 등록되었습니다.');
end;

end.
