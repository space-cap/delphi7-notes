unit DataModule;

interface

uses
  Windows, SysUtils, Classes, DB, ADODB, Forms, Dialogs, IniFiles;

type
  TDataModuleMain = class(TDataModule)
    ADOConnection1: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    FIniFilePath: string;
  public
    function ConnectDB: Boolean;
    procedure LoadConfigFromIni;
    procedure SaveConfigToIni(const AConnStr: string);
  end;

var
  DataModuleMain: TDataModuleMain;

implementation

{$R *.dfm}

procedure TDataModuleMain.DataModuleCreate(Sender: TObject);
begin
  FIniFilePath := ExtractFilePath(Application.ExeName) + 'dbconfig.ini';
  LoadConfigFromIni;
end;

procedure TDataModuleMain.LoadConfigFromIni;
var
  Ini: TIniFile;
  TemplatePath, Provider, Server, Database, UserID, Password, ConnStr: string;
begin
  ADOConnection1.LoginPrompt := False;

  // dbconfig.ini 파일이 없으면 템플릿 복사
  if not FileExists(FIniFilePath) then
  begin
    TemplatePath := ExtractFilePath(Application.ExeName) + 'dbconfig.ini.template';
    if FileExists(TemplatePath) then
      CopyFile(PChar(TemplatePath), PChar(FIniFilePath), True);
  end;

  if FileExists(FIniFilePath) then
  begin
    Ini := TIniFile.Create(FIniFilePath);
    try
      Provider := Ini.ReadString('DATABASE', 'Provider', 'SQLOLEDB.1');
      Server   := Ini.ReadString('DATABASE', 'Server', '127.0.0.1');
      Database := Ini.ReadString('DATABASE', 'Database', 'TestDB');
      UserID   := Ini.ReadString('DATABASE', 'UserID', 'sa');
      Password := Ini.ReadString('DATABASE', 'Password', '');

      ConnStr := Format('Provider=%s;Data Source=%s;Initial Catalog=%s;User ID=%s;Password=%s;',
        [Provider, Server, Database, UserID, Password]);

      ADOConnection1.ConnectionString := ConnStr;
    finally
      Ini.Free;
    end;
  end;
end;

procedure TDataModuleMain.SaveConfigToIni(const AConnStr: string);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(FIniFilePath);
  try
    Ini.WriteString('DATABASE', 'ConnectionString', AConnStr);
  finally
    Ini.Free;
  end;
end;

function TDataModuleMain.ConnectDB: Boolean;
begin
  Result := False;
  try
    if not ADOConnection1.Connected then
    begin
      if Trim(ADOConnection1.ConnectionString) = '' then
      begin
        ShowMessage('DB 연결 설정이 비어있습니다. dbconfig.ini 파일을 확인하세요.');
        Exit;
      end;
      ADOConnection1.Connected := True;
    end;
    Result := ADOConnection1.Connected;
  except
    on E: Exception do
    begin
      MessageDlg('데이터베이스 연결 실패:' + #13#10 +
        'dbconfig.ini 설정 및 DB 서버 상태를 확인하세요.' + #13#10 + #13#10 + E.Message,
        mtError, [mbOK], 0);
    end;
  end;
end;

end.
