program ADODemo;

uses
  Forms,
  DBForm in 'DBForm.pas' {FormDB};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormDB, FormDB);
  Application.Run;
end.
