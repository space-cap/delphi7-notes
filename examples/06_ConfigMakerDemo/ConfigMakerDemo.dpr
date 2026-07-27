program ConfigMakerDemo;

uses
  Forms,
  ConfigMakerForm in 'ConfigMakerForm.pas' {FormConfigMaker};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Delphi 7 DB config.dat 암호화 생성기';
  Application.CreateForm(TFormConfigMaker, FormConfigMaker);
  Application.Run;
end.
