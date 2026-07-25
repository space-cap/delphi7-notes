# 08-2. Indy 컴포넌트를 이용한 HTTP 및 소켓 통신 🌐

> 💡 **초초보자를 위한 한 줄 요약**  
> 델파이 표준 통신 라이브러리인 **Indy(인디) 컴포넌트**를 이용해 **웹 API 요청(HTTP GET/POST)**이나 **TCP/UDP 서버-클라이언트 통신**을 쉽게 수행합니다!

---

## 🌐 1. 웹 API 요청 전송: `TIdHTTP`

웹 서버(REST API 등)에 데이터를 요청하고 응답 결과(JSON, HTML)를 받아올 때 씁니다.

```pascal
uses
  IdHTTP;

var
  HTTP: TIdHTTP;
  ResponseText: String;
begin
  HTTP := TIdHTTP.Create(nil);
  try
    // GET 요청으로 데이터 가져오기!
    ResponseText := HTTP.Get('https://api.example.com/data');
    ShowMessage('응답 결과: ' + ResponseText);
  finally
    HTTP.Free;
  end;
end;
```

---

## 🔌 2. 1대1 소켓 통신: `TIdTCPClient` & `TIdTCPServer`

실시간 채팅이나 공장 장비(PLC)와 데이터 패킷을 패킷 단위로 주고받는 소켓 통신 부품입니다.

---

* **이전 단계**: [08-1. TIniFile 및 TFileStream 활용법](01-inifile-and-stream.md)
* **다음 단계**: [08-3. 외부 프로세스 실행 및 연동 (ShellExecute & CreateProcess)](03-external-process.md)
