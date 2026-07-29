unit SalesOrderForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormSalesOrder = class(TForm)
    LabelTitle: TLabel;
    LabelCustomer: TLabel;
    EditCustomer: TEdit;
    BtnAddOrder: TButton;
    MemoLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure BtnAddOrderClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSalesOrder: TFormSalesOrder;

implementation

uses TabbedMDIMainForm;

{$R *.dfm}

procedure TFormSalesOrder.FormCreate(Sender: TObject);
begin
  MemoLog.Lines.Clear;
  MemoLog.Lines.Add('=== 영업 주문 작성 준비 완료 ===');
end;

procedure TFormSalesOrder.FormActivate(Sender: TObject);
begin
  if FormTabbedMDIMain <> nil then
    FormTabbedMDIMain.SetActiveTabForChild(Self);
end;

procedure TFormSalesOrder.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  if FormTabbedMDIMain <> nil then
    FormTabbedMDIMain.ChildClosedNotification;
end;

procedure TFormSalesOrder.BtnAddOrderClick(Sender: TObject);
begin
  MemoLog.Lines.Add('[' + TimeToStr(Now) + '] ' + EditCustomer.Text + ' 신규 주문 접수 완료');
  ShowMessage('영업 주문이 정상 접수되었습니다.');
end;

end.
