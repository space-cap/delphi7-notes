program VCLEventsDemo;

uses
  Forms,
  MainForm in 'MainForm.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Delphi 7 VCL Events Demo';
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
