program MSSQLADODemo;

uses
  Forms,
  MSSQLForm in 'MSSQLForm.pas' {FormMSSQL};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Delphi 7 MS-SQL ADO DB Connection Demo';
  Application.CreateForm(TFormMSSQL, FormMSSQL);
  Application.Run;
end.
