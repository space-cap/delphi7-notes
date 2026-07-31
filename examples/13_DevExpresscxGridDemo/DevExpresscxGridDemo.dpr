program DevExpresscxGridDemo;

uses
  Forms,
  MainForm in 'MainForm.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'DevExpress TcxGrid 실습 데모';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
