program DevExpressMSSQLOrderMasterDetailDemo;

uses
  Forms,
  MainForm in 'MainForm.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'DevExpress TcxGrid 수주 마스터-디테일 (Master-Detail) 실습 데모';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
