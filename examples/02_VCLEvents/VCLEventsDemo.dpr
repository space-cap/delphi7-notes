program VCLEventsDemo;

uses
  Forms,
  MainForm in 'MainForm.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
