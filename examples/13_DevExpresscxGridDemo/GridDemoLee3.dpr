program GridDemoLee3;

uses
  Forms,
  MainFormLee2 in 'MainFormLee2.pas' {frmUserList};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmUserList, frmUserList);
  Application.Run;
end.
