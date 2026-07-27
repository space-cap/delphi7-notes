# 06_ConfigMakerDemo config.dat 암호화 파일 생성 도구 예제 🔐

> 💡 **초초보자 & 신입/인턴 개발자를 위한 한 줄 요약**  
> 개발자/관리자가 사내 DB 서버 접속 정보를 입력하고 **`[config.dat 암호화 저장]`** 버튼을 누르면, 누구나 열어볼 수 없는 안전한 암호화 파일(`config.dat`)을 만들어내는 전용 미니 툴 예제입니다!

---

## 🎯 이 예제에서 배우는 내용

1. **`XOR 암호화/복호화`**: 델파이 표준 `xor` 연산자로 문자열 암호화 및 복호화 구현
2. **`TStringList` 파일 입출력**: DB 설정 정보를 `Key=Value` 형식으로 구성하여 파일 저장 및 읽기
3. **보안 실무 관리**: DB 접속 정보를 일반 텍스트 `.ini`가 아닌 **암호화 바이너리 `config.dat`**으로 안전하게 제작하는 방법

---

## 📄 파스칼 주요 소스 코드 해설 (`ConfigMakerForm.pas`)

### 1) XOR 암호화 / 복호화 겸용 함수

```pascal
// XOR 연산자($5A 키)를 이용한 암호화 & 복호화 겸용 함수
function TFormConfigMaker.EncryptDecrypt(const InputStr: String; Key: Byte = $5A): String;
var
  I: Integer;
begin
  SetLength(Result, Length(InputStr));
  for I := 1 to Length(InputStr) do
    Result[I] := Char(Byte(InputStr[I]) xor Key);
end;
```

### 2) config.dat 암호화 저장

```pascal
procedure TFormConfigMaker.BtnSaveConfigClick(Sender: TObject);
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL.Values['Server']   := EditServer.Text;
    SL.Values['DBName']   := EditDB.Text;
    SL.Values['UserID']   := EditUser.Text;
    SL.Values['Password'] := EditPass.Text;

    // 전체 텍스트를 XOR 암호화하여 config.dat 파일로 저장!
    SL.Text := EncryptDecrypt(SL.Text);
    SL.SaveToFile(ExtractFilePath(ParamStr(0)) + 'config.dat');

    ShowMessage('config.dat 파일이 안전하게 암호화 생성되었습니다!');
  finally
    SL.Free;
  end;
end;
```

---

## 💻 델파이 7 IDE에서 실습하는 방법

1. `examples/06_ConfigMakerDemo/` 폴더로 이동합니다.
2. **`ConfigMakerDemo.dpr`** 프로젝트 파일을 더블클릭하여 델파이 7 IDE를 엽니다.
3. 키보드의 **`F9`** 키를 눌러 실행합니다.
4. **서버 IP, DB 이름, 계정, 비밀번호**를 입력하고 **`[config.dat 암호화 저장]`** 버튼을 클릭합니다.
5. 실행 폴더에 생성된 `config.dat` 파일의 암호화된 모습을 메모장에서 확인해 봅니다!
6. **`[config.dat 복호화 검증]`** 버튼을 눌러 올바르게 원본 DB 정보가 되돌아오는지 검증합니다!

---

* **이전 단계**: [05_MSSQLADODemo MS-SQL ADO 연동 실습](../05_MSSQLADODemo/README.md)
