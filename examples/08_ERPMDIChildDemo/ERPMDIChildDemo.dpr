program ERPMDIChildDemo;

uses
  Forms,
  MDIMainForm in 'MDIMainForm.pas' {FormMDIMain},
  UserMgmtForm in 'UserMgmtForm.pas' {FormUserMgmt},
  OrderRegForm in 'OrderRegForm.pas' {FormOrderReg};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Delphi 7 ERP MDI 자식 창(Form) 연동 실습';
  Application.CreateForm(TFormMDIMain, FormMDIMain);
  Application.Run;
end.
