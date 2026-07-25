# 10-2. FastMM4를 이용한 메모리 누수(Memory Leak) 추적 🕵️‍♂️

> 💡 **초초보자를 위한 한 줄 요약**  
> **FastMM4**는 델파이 프로그램이 종료될 때 **"해제 안 하고 깜빡 잊은 메모리가 몇 번째 줄에 있는지 정확히 범인을 찾아주는 최고의 탐정 도구"**입니다!

---

## 🕵️‍♂️ FastMM4 란 무엇인가요?

델파이 7 기본 메모리 매니저보다 훨씬 빠르고 강력한 제3자 메모리 관리자입니다. (너무 성능이 뛰어나서 최신 델파이 버전에는 기본 메모리 매니저로 채택되었습니다!)

* **최대 장점**: 개발자가 `Create` 해놓고 `Free` 안 한 객체가 있으면, 앱 종료 시 **에러 메시지 창이나 텍스트 파일 보고서로 누수 위치(파일명, 줄 번호)를 명확히 팝업**으로 알려줍니다!

---

## 🛠️ FastMM4 적용법 (단 1줄 추가!)

프로젝트 파일(`.dpr`) 맨 위 `uses` 절의 **가장 첫 번째**로 `FastMM4` 를 추가하면 끝납니다!

```pascal
program MyProject;

uses
  FastMM4, // ★ 반드시 맨 첫 번째 줄에 있어야 탐정 기능이 발동됩니다!
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
```

---

* **이전 단계**: [10-1. 커스텀 VCL 컴포넌트 제작 기초](01-custom-component.md)
* **다음 단계**: [10-3. 멀티스레딩(TThread)과 UI 동기화(Synchronize)](03-multithreading.md)
