program TabbedMDIERP;

uses
  Forms,
  TabbedMDIMainForm in 'TabbedMDIMainForm.pas' {FormTabbedMDIMain},
  UserListForm in 'UserListForm.pas' {FormUserList},
  SalesOrderForm in 'SalesOrderForm.pas' {FormSalesOrder},
  StockItemForm in 'StockItemForm.pas' {FormStockItem};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Delphi 7 모던 접이식 사이드바 + MDI 탭 ERP 실습';
  Application.CreateForm(TFormTabbedMDIMain, FormTabbedMDIMain);
  Application.Run;
end.
