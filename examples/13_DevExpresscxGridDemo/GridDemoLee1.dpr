program GridDemoLee1;

uses
  Forms,
  MainFormLee1 in 'MainFormLee1.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
