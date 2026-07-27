unit ConfigMakerForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormConfigMaker = class(TForm)
    LabelServer: TLabel;
    EditServer: TEdit;
    LabelDB: TLabel;
    EditDB: TEdit;
    LabelUser: TLabel;
    EditUser: TEdit;
    LabelPass: TLabel;
    EditPass: TEdit;
    BtnSaveConfig: TButton;
    BtnTestRead: TButton;
    MemoLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure BtnSaveConfigClick(Sender: TObject);
    procedure BtnTestReadClick(Sender: TObject);
  private
    function EncryptDecrypt(const InputStr: String; Key: Byte = $5A): String;
    function GetConfigPath: String;
  public
    { Public declarations }
  end;

var
  FormConfigMaker: TFormConfigMaker;

implementation

{$R *.dfm}

procedure TFormConfigMaker.FormCreate(Sender: TObject);
begin
  Caption := 'DB config.dat 암호화 설정 파일 생성기';
  MemoLog.Lines.Clear;
  MemoLog.Lines.Add('=== DB 접속 정보 암호화 도구 준비 완료 ===');
  MemoLog.Lines.Add('DB 접속 정보를 입력하고 [config.dat 암호화 저장]을 클릭하세요.');
end;

// 설정 파일 경로 반환 (실행 EXE와 같은 폴더)
function TFormConfigMaker.GetConfigPath: String;
begin
  Result := ExtractFilePath(ParamStr(0)) + 'config.dat';
end;

// XOR 암호화 / 복호화 겸용 함수 ($5A 키 사용)
function TFormConfigMaker.EncryptDecrypt(const InputStr: String; Key: Byte = $5A): String;
var
  I: Integer;
begin
  SetLength(Result, Length(InputStr));
  for I := 1 to Length(InputStr) do
  begin
    Result[I] := Char(Byte(InputStr[I]) xor Key);
  end;
end;

// config.dat 암호화 저장 버튼
procedure TFormConfigMaker.BtnSaveConfigClick(Sender: TObject);
var
  SL: TStringList;
  PlainText, EncryptedText: String;
begin
  SL := TStringList.Create;
  try
    // 1. 입력받은 접속 정보를 Key=Value 형식으로 조립
    SL.Values['Server']   := Trim(EditServer.Text);
    SL.Values['DBName']   := Trim(EditDB.Text);
    SL.Values['UserID']   := Trim(EditUser.Text);
    SL.Values['Password'] := Trim(EditPass.Text);

    PlainText := SL.Text;

    // 2. 전체 텍스트를 XOR 암호화!
    EncryptedText := EncryptDecrypt(PlainText);

    // 3. config.dat 파일로 파일 쓰기
    SL.Text := EncryptedText;
    SL.SaveToFile(GetConfigPath);

    MemoLog.Lines.Add('----------------------------------------');
    MemoLog.Lines.Add('-> config.dat 생성 성공!');
    MemoLog.Lines.Add('저장 경로: ' + GetConfigPath);
    MemoLog.Lines.Add('[암호화되어 저장된 파일 내용 미리보기]:');
    MemoLog.Lines.Add(EncryptedText);

    ShowMessage('config.dat 파일이 안전하게 암호화되어 생성되었습니다!');
  finally
    SL.Free;
  end;
end;

// config.dat 복호화 테스트 검증 버튼
procedure TFormConfigMaker.BtnTestReadClick(Sender: TObject);
var
  SL: TStringList;
  EncryptedText, DecryptedText: String;
begin
  if not FileExists(GetConfigPath) then
  begin
    ShowMessage('config.dat 파일이 존재하지 않습니다! 먼저 저장을 진행해 주세요.');
    Exit;
  end;

  SL := TStringList.Create;
  try
    // 1. 암호화된 파일 내용 읽기
    SL.LoadFromFile(GetConfigPath);
    EncryptedText := SL.Text;

    // 2. 복호화 수행!
    DecryptedText := EncryptDecrypt(EncryptedText);

    MemoLog.Lines.Add('----------------------------------------');
    MemoLog.Lines.Add('-> config.dat 복호화 성공!');
    MemoLog.Lines.Add('[복호화된 원본 DB 접속 정보]:');
    MemoLog.Lines.Add(DecryptedText);

    ShowMessage('config.dat 복호화 검증 성공!');
  finally
    SL.Free;
  end;
end;

end.
