# 10-3. 멀티스레딩(TThread)과 UI 동기화(Synchronize) 🧵

> 💡 **초초보자를 위한 한 줄 요약**  
> 복잡하고 오래 걸리는 작업(파일 1만 개 다운로드 등)을 할 때 화면이 하얗게 **"응답 없음"**으로 굳는 것을 막기 위해, **비하인드 조수 일꾼(`TThread`)**을 뽑아 일시키는 기술입니다!

---

## 🧵 1. 왜 스레드(Thread)가 필요한가요?

* **메인 스레드 (Main UI Thread)**: 마우스 클릭, 화면 그림 그리기, 버튼 반응 등을 혼자서 처리하는 메인 일꾼입니다.
* 만약 메인 일꾼에게 30초짜리 대용량 파일 다운로드를 시키면 다운로드가 끝날 때까지 **화면 클릭이 안 되고 응답 없음 상태**가 됩니다.
* **해결책**: 백그라운드 조수 일꾼(`TThread`)을 하나 새로 만들어서 다운로드를 떠넘기면 됩니다!

---

## 💻 2. 델파이 스레드 기본 모양 (`TThread`)

```pascal
type
  TMyWorkerThread = class(TThread)
  protected
    procedure Execute; override; // 백그라운드 일꾼이 일할 진짜 내용!
    procedure UpdateUI; // 메인 화면을 고칠 안전 프로시저
  end;

procedure TMyWorkerThread.Execute;
begin
  // 백그라운드 서브 일꾼이 무거운 작업 수행 중...
  
  // ★ 중요: 메인 UI(화면)를 건드릴 때는 반드시 Synchronize 사용!
  Synchronize(UpdateUI);
end;

procedure TMyWorkerThread.UpdateUI;
begin
  // 메인 UI 컴포넌트 안전하게 수정!
  Form1.Label1.Caption := '작업 완료!';
end;
```

---

## ⚠️ 멀티스레드 절대 황금 법칙: `Synchronize`

* **경고**: 서브 일꾼 스레드가 메인 화면 창(`Label1.Caption`, `ProgressBar1.Position` 등)을 직접 건드리면 **프로그램이 100% 뻗거나 에러가 터집니다!**
* **해결책**: 메인 화면 UI를 수정할 때는 무조건 **`Synchronize(내프로시저);`** 를 거쳐서 메인 일꾼에게 부탁하여 안전하게 수정하게 해야 합니다!

---

## 🎯 초초보자를 위한 실무 3줄 요약

1. 오래 걸리는 일 시킬 때는 **`TThread` 백그라운드 일꾼**을 쓴다!
2. 백그라운드 일꾼 안에서 화면(UI)을 고칠 때는 무조건 **`Synchronize`** 를 부른다!
3. 이렇게 하면 30초 동안 일해도 앱 화면이 전혀 안 굳고 부드럽게 작동한다!

---

* **이전 단계**: [10-2. FastMM4를 이용한 메모리 누수(Memory Leak) 추적](01-fastmm4-debugging.md)
* **다음 단계**: -(전체 학습 문서 작성을 완료했습니다! 🎉)-
