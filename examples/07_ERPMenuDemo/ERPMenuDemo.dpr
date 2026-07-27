program ERPMenuDemo;

uses
  Forms,
  ERPMenuForm in 'ERPMenuForm.pas' {FormERPMenu};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Delphi 7 ERP 메인 메뉴 구성 실습';
  Application.CreateForm(TFormERPMenu, FormERPMenu);
  Application.Run;
end.
