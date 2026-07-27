# 04. 네트워크, 웹, 인디(Indy) 통신 컴포넌트 가이드 🌐

> 💡 **초초보자를 위한 한 줄 요약**  
> 웹 브라우저 띄우기, 웹 서비스(SOAP/REST) 연동, TCP/IP 소켓 통신, FTP 파일 전송, 이메일(SMTP/POP3) 발송 등 인터넷 연동을 담당하는 컴포넌트 모음입니다!

---

## 🌐 1. Internet & WebServices 탭

프로그램 안에서 웹 페이지를 띄우거나 웹 서비스 표준 통신을 할 때 사용합니다.

| 컴포넌트명 | 역할 및 설명 | 주요 프로퍼티(Property) / 팁 |
| :--- | :--- | :--- |
| **`TWebBrowser`** | **(실무 자주 씀!)** 폼 안에 인터넷 익스플로러 웹 브라우저 창을 직접 띄워 웹 사이트를 렌더링합니다. | `Navigate('http://... ')`, `OleObject` |
| **`TClientSocket`**| (레거시) TCP/IP 소켓 통신을 수행하는 소켓 클라이언트입니다. | `Host`, `Port`, `Active`, `Socket.SendText` |
| **`TServerSocket`**| (레거시) 포트를 열고 클라이언트의 소켓 접속을 기다리는 소켓 서버입니다. | `Port`, `Active`, `OnClientRead` |
| **`THttpRIO`** | 웹 서비스(Web Services / WSDL / SOAP) 프로토콜을 호출하여 원격 웹 서버의 메서드를 실행합니다. | `WSDLLocation`, `Service`, `Port` |
| **`THTTPSoapPascalInvoker`**| SOAP XML 요청을 파스칼 클래스로 변환하여 호출을 처리합니다. | Web API 서버 구현용 |

---

## 🚀 2. Indy 탭 전수 정리 (Indy Clients / Indy Servers / Misc)

델파이에서 가장 강력하고 표준으로 사용되는 인터넷 통신 오픈소스 컴포넌트 집합인 **Indy (Internet Direct)** 모음입니다.

### 1) Indy Clients 탭 (클라이언트 소켓 통신)
| 컴포넌트명 | 역할 및 설명 | 주요 사용법 팁 |
| :--- | :--- | :--- |
| **`TIdHTTP`** | **(실무 최다 사용!)** HTTP `GET`, `POST` 요청을 보내 웹 API 결과를 받아오거나 파일을 다운로드합니다. | `IdHTTP1.Get('http://...')`, `IdHTTP1.Post(...)` |
| **`TIdTCPClient`**| 일반적인 원시(Raw) TCP/IP 소켓 클라이언트 통신을 수행합니다. | `Connect`, `IOHandler.Write`, `IOHandler.ReadLn` |
| **`TIdUDPClient`**| 빠르지만 비연결형인 UDP 소켓 통신 요청을 보냅니다. | `Send('데이터')` |
| **`TIdFTP`** | FTP 서버에 접속하여 파일을 업로드(`Put`)하거나 다운로드(`Get`)합니다. | `Host`, `Username`, `Password`, `Get`, `Put` |
| **`TIdSMTP`** | 이메일을 전송하는 메일 발송 클라이언트입니다. (TIdMessage와 함께 사용) | `Send(IdMessage)` |
| **`TIdPOP3`** | 메일 서버에서 도착한 이메일을 가져오는 메일 수신 클라이언트입니다. | `CheckMessages`, `Retrieve` |
| **`TIdTime` / `TIdSNTP`**| 타임 서버에 접속하여 정확한 표준 현재 시각을 맞춰오는 시계 동기화 모듈입니다. | `DateTime` |

### 2) Indy Servers 탭 (서버 소켓 데몬 구축)
| 컴포넌트명 | 역할 및 설명 | 주요 사용법 팁 |
| :--- | :--- | :--- |
| **`TIdTCPServer`**| 고성능 멀티스레드 기반의 TCP/IP 소켓 서버를 구축합니다. | `OnExecute` (클라이언트 연결별 개별 스레드 실행) |
| **`TIdUDPServer`**| UDP 데이터그램을 수신하는 UDP 서버를 구축합니다. | `OnUDPRead` |
| **`TIdHTTPServer`**| 자체적인 웹 서버(Web Server) 데몬을 델파이 프로그램 안에 구축합니다. | `OnCommandGet` |
| **`TIdFTPServer`**| 자신만의 FTP 파일 서버를 구축합니다. | `OnUserLogin` |

### 3) Indy Intercepts, I/O Handlers, Misc 탭 (보안 및 유틸리티)
| 컴포넌트명 | 역할 및 설명 |
| :--- | :--- |
| **`TIdServerIOHandlerSSLOpenSSL`** | HTTP 통신에 **SSL/TLS 암호화(HTTPS)** 보안을 적용할 때 연동하는 핸들러입니다. |
| **`TIdLogFile` / `TIdLogDebug`** | 소켓을 통해 주고받는 패킷 Raw 데이터를 텍스트 파일로 자동 암호화/기록하는 로그 모듈입니다. |
| **`TIdAntiFreeze`** | **(필수 팁!)** Indy의 동기식 통신 수행 중 메인 UI 화면(Form)이 멈추거나 렉 걸리는 현상을 방지해 주는 방빙 컴포넌트입니다. |
| **`TIdEncoderMIME` / `TIdDecoderMIME`**| Base64 인코딩/디코딩을 수행하는 유틸리티입니다. |

---

## 🕸️ 3. WebSnap & InternetExpress 탭

* **WebSnap 탭**: HTML 템플릿과 델파이 코드를 결합하여 동적 웹 사이트를 생성하는 웹 프레임워크 탭입니다. (`TWebAppComponents`, `TPageProducer` 등)
* **InternetExpress 탭**: XML 데이터와 JavaScript 기반의 브라우저 클라이언트 응용 프로그램을 델파이로 생성할 때 사용합니다. (`TMidasPageProducer` 등)

---

* **목차로 돌아가기**: [README.md](README.md)
* **다음 단계**: [05. 고급 기능 및 기타 외부 컴포넌트 가이드](05-advanced-other.md)
