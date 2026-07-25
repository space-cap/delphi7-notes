program ThreadDemo;

uses
  Forms,
  ThreadForm in 'ThreadForm.pas' {FormThread};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormThread, FormThread);
  Application.Run;
end.
