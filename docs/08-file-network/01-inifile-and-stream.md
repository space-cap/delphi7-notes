# 08-1. TIniFile 및 TFileStream 활용법 ⚙️🌊

> 💡 **초초보자를 위한 한 줄 요약**  
> * **`TIniFile`**: 사용자 아이디, 최신 접속 IP 같은 **환경설정 텍스트를 저장하는 장부**  
> * **`TFileStream`**: 대용량 이진(Binary) 파일이나 이미지/동영상을 **바이트 흐름으로 주고받는 통로**

---

## ⚙️ 1. 환경 설정 파일의 왕: `TIniFile`

프로그램을 껐다 켜도 아이디 저장이나 환경설정 값을 유지하고 싶을 때 씁니다. `.ini` 파일은 사람 눈으로 읽기 아주 편한 텍스트 구조입니다.

```ini
[SERVER_CONFIG]
IP=192.168.0.1
PORT=8080
AUTO_LOGIN=1
```

### 💻 델파이에서 INI 파일 읽고 쓰기

```pascal
uses
  IniFiles; // IniFiles 유닛 추가 필수!

var
  Ini: TIniFile;
begin
  // 1. INI 파일 열기
  Ini := TIniFile.Create('C:\AppConfig.ini');
  try
    // 2. 값 저장하기: WriteString('섹션', '키', '값')
    Ini.WriteString('SERVER_CONFIG', 'IP', '192.168.0.1');
    Ini.WriteInteger('SERVER_CONFIG', 'PORT', 8080);
    
    // 3. 값 읽어오기: ReadString('섹션', '키', '기본값')
    ServerIP := Ini.ReadString('SERVER_CONFIG', 'IP', '127.0.0.1');
  finally
    Ini.Free;
  end;
end;
```

---

## 🌊 2. 대용량 이진 파일 다루기: `TFileStream`

이미지, 압축파일, 대용량 데이터를 메모리 낭비 없이 파일로 빠르게 쓰고 읽는 표준 스트림 클래스입니다.

---

* **이전 단계**: [07-3. TDBGrid 및 데이터 바인딩 컴포넌트 활용](../07-database/03-dbgrid-binding.md)
* **다음 단계**: [08-2. Indy 컴포넌트를 이용한 HTTP 및 소켓 통신](02-indy-sockets.md)
