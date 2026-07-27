# 07-4. config.dat 암호화 파일을 이용한 실무 DB 접속 관리 🛡️

> 💡 **초초보자 & 신입/인턴 개발자를 위한 한 줄 요약**  
> 일반 텍스트 `.ini` 파일에 DB 비밀번호를 적어두면 누구나 메모장으로 열어 훔쳐볼 수 있습니다! **`config.dat` 암호화 바이너리 파일**로 접속 정보를 안전하게 관리하는 실무 방식을 배웁니다.

---

## ❓ 왜 평문 `.ini` 파일 대신 `config.dat`을 사용하나요?

1. **보안 문제**: `Password=1234`라고 텍스트 파일에 쓰면 사용자가 메모장으로 열어 사내 DB 비밀번호를 그대로 보게 됩니다.
2. **하드코딩 방지**: 소스 코드 안에 `Password := '1234'` 라고 넣으면 DB 비밀번호가 바뀔 때마다 프로그램을 재컴파일하여 새로 배포해야 합니다.
3. **최선의 실무 해답**: **`config.dat` 암호화 파일**을 만들어 비밀번호를 외계어로 암호화해 두고, 프로그램 실행 시 델파이가 읽어서 메모리 안에서만 살짝 풀어서 사용합니다!

---

## 🛠️ 1. 델파이 7 XOR 암호화 / 복호화 유틸리티 함수

별도의 거창한 외부 라이브러리 없이 델파이 기본 문법인 **XOR 연산자**만으로도 강력하게 문자열을 암호화/복호화할 수 있습니다!

```pascal
// XOR 연산을 이용한 암호화 & 복호화 겸용 함수
// (동일한 Key로 두 번 연산하면 원본으로 되돌아옵니다!)
function EncryptDecrypt(const InputStr: String; Key: Byte = $5A): String;
var
  I: Integer;
begin
  SetLength(Result, Length(InputStr));
  for I := 1 to Length(InputStr) do
  begin
    Result[I] := Char(Byte(InputStr[I]) xor Key);
  end;
end;
```

---

## 📄 2. `config.dat` 파일에 암호화하여 저장하기 (설정 도구)

```pascal
procedure SaveConfigDat;
var
  SL: TStringList;
  PlainText, EncryptedText: String;
begin
  SL := TStringList.Create;
  try
    // 1. 저장할 DB 접속 정보 구성
    SL.Values['Server']   := '192.168.0.100';
    SL.Values['DBName']   := 'ProductionDB';
    SL.Values['UserID']   := 'app_user';
    SL.Values['Password'] := 'secret_pms1234';

    // 2. 전체 텍스트를 암호화!
    PlainText := SL.Text;
    EncryptedText := EncryptDecrypt(PlainText);

    // 3. config.dat 파일로 파일 저장!
    SL.Text := EncryptedText;
    SL.SaveToFile(ExtractFilePath(ParamStr(0)) + 'config.dat');
    
    ShowMessage('config.dat 파일이 안전하게 암호화 생성되었습니다!');
  finally
    SL.Free;
  end;
end;
```

---

## 📖 3. `config.dat` 암호화 파일 읽어와서 DB 연결하기 (`TADOConnection`)

```pascal
procedure TFormMain.LoadConfigAndConnect;
var
  SL: TStringList;
  ConfigPath, EncryptedText, DecryptedText: String;
  ServerIP, DBName, UserID, PasswordStr: String;
begin
  ConfigPath := ExtractFilePath(ParamStr(0)) + 'config.dat';

  if not FileExists(ConfigPath) then
  begin
    ShowMessage('설정 파일(config.dat)을 찾을 수 없습니다!');
    Exit;
  end;

  SL := TStringList.Create;
  try
    // 1. 암호화된 파일 내용 읽기
    SL.LoadFromFile(ConfigPath);
    EncryptedText := SL.Text;

    // 2. 복호화 수행!
    DecryptedText := EncryptDecrypt(EncryptedText);

    // 3. 복호화된 내용 파싱
    SL.Text := DecryptedText;
    ServerIP    := SL.Values['Server'];
    DBName      := SL.Values['DBName'];
    UserID      := SL.Values['UserID'];
    PasswordStr := SL.Values['Password'];

    // 4. ADOConnection에 커넥션 스트링 설정 후 연결!
    ADOConnection1.Close;
    ADOConnection1.ConnectionString := 
      'Provider=SQLOLEDB.1;' +
      'Data Source=' + ServerIP + ';' +
      'Initial Catalog=' + DBName + ';' +
      'User ID=' + UserID + ';' +
      'Password=' + PasswordStr + ';';
      
    ADOConnection1.Connected := True;
    ShowMessage('DB 연결 성공!');
  except
    on E: Exception do
      ShowMessage('DB 연결 실패: ' + E.Message);
  finally
    SL.Free;
  end;
end;
```

---

## 🔍 메모장으로 열어본 `config.dat` 비교

| 파일 형태 | 메모장으로 열었을 때 모습 | 평가 |
| :--- | :--- | :---: |
| **일반 `dbconfig.ini`** | `Password=secret_pms1234` | ❌ **위험! 누구나 읽음** |
| **암호화된 `config.dat`** | `!@#$%-+^&*~?><:|}{128937` | ⭕ **안전! 해독 불가능** |

---

* **이전 단계**: [07-3. TDBGrid 및 데이터 바인딩 컴포넌트 활용](03-dbgrid-binding.md)
* **다음 단계**: [08-1. TIniFile 및 TFileStream 활용법](../08-file-network/01-inifile-and-stream.md)
