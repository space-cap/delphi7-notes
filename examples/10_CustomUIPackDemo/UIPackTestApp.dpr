program UIPackTestApp;

uses
  Forms,
  TestForm in 'TestForm.pas' {FormTest};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '커스텀 VCL UI Pack 버튼 테스트';
  Application.CreateForm(TFormTest, FormTest);
  Application.Run;
end.
