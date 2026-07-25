# 08-3. 외부 프로세스 실행 및 연동 (ShellExecute & CreateProcess) 🚀

> 💡 **초초보자를 위한 한 줄 요약**  
> 델파이 프로그램 안에서 **"메모장(`notepad.exe`)"이나 "계산기", 다른 실행 파일(`.exe`)을 즉석 호출하여 띄우는 기법**입니다!

---

## 🚀 1. 제일 쉽고 간단한 방법: `ShellExecute`

웹 사이트 URL을 열거나 외부 실행 파일, 문서를 실행할 때 가장 널리 쓰이는 Win32 API입니다.

```pascal
uses
  ShellAPI; // ShellAPI 유닛 등록 필수!

begin
  // 1. 메모장 실행하기
  ShellExecute(0, 'open', 'notepad.exe', nil, nil, SW_SHOWNORMAL);
  
  // 2. 기본 브라우저로 웹 사이트 열기
  ShellExecute(0, 'open', 'https://www.google.com', nil, nil, SW_SHOWNORMAL);
end;
```

---

## ⏳ 2. 외부 프로그램이 끌 때까지 대기(Wait)하기: `CreateProcess`

외부 프로그램을 켜고, **그 프로그램이 완전히 종료될 때까지 내 델파이 앱이 멈춰서 기다리게** 만들고 싶을 땐 `CreateProcess` 와 `WaitForSingleObject` 를 함께 사용합니다!

---

* **이전 단계**: [08-2. Indy 컴포넌트를 이용한 HTTP 및 소켓 통신](02-indy-sockets.md)
* **다음 단계**: [09-1. C/C++ DLL 연동 (정적 & 동적 로딩)](../09-dll-api/01-dll-loading.md)
