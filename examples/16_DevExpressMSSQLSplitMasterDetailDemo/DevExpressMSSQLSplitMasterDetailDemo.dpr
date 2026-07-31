program DevExpressMSSQLSplitMasterDetailDemo;

uses
  Forms,
  MainForm in 'MainForm.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'DevExpress TcxGrid 상하 분할 (Split-Panel) 마스터-디테일 데모';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
