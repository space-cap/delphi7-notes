# 🧵 델파이 7 멀티스레드(TThread) 완벽 가이드

> 💡 **초초보자를 위한 한 줄 요약**  
> 대용량 엑셀을 저장하거나 인쇄할 때 **화면이 "응답 없음"으로 먹통(렉)**이 되나요? **스레드(Thread)**를 쓰면 백그라운드 일꾼이 비하인드에서 일을 처리해서 **화면이 멈추지 않고 씽씽 쾌적하게** 돌아갑니다!

---

## 🏬 1. 스레드(Thread)란 무엇인가요? (가게 비유)

* **싱글 스레드 (스레드 미사용)**:
  - 요리사 **1명(메인 스레드)**이 요리도 하고, 주문도 받고, 카운터 계산도 혼자 다 하는 상태입니다.
  - 대용량 요리(5분 걸리는 작업)를 시작하면 카운터 손님은 5분 동안 멍하니 기다려야 하며, 가게 창문에 **"응답 없음(렉)"**이 뜹니다!
* **멀티 스레드 (TThread 사용)**:
  - 메인 요리사는 **손님 응대 및 화면 띄우기(메인 UI 스레드)**만 전담하고,
  - 대용량 요리나 다운로드는 **서브 보조 요리사(일꾼 스레드)**를 따로 고용해서 비하인드 주방에서 처리합니다.
  - 덕분에 손님은 언제나 쾌적하게 응대를 받습니다!

---

## ⚙️ 2. 델파이 7 `TThread` 클래스 기본 작성법

델파이 7에서는 `TThread` 클래스를 상속받아 파스칼 클래스를 만드는 방식으로 스레드를 만듭니다.

```pascal
type
  // 1. TThread를 상속받는 서브 스레드 클래스 선언
  TDownloadThread = class(TThread)
  private
    FProgress: Integer;
    procedure UpdateUI;          // 화면 UI를 안전하게 고치는 메소드
  protected
    procedure Execute; override; // ★ 백그라운드 일꾼이 실제 일하는 실행부!
  end;
```

---

## 🚀 3. 백그라운드 일터 `Execute` 구현법

`Execute` 메소드 안에 백그라운드에서 실행될 실제 코드(다운로드, 루프 연산, DB 대용량 조회 등)를 작성합니다.

```pascal
procedure TDownloadThread.Execute;
var
  I: Integer;
begin
  for I := 1 to 100 do
  begin
    // 사용자가 스레드를 중간에 강제 종료했는지 확인
    if Terminated then Break;

    FProgress := I;

    // ★ [매우 중요] 메인 UI(화면)를 고칠 때는 반드시 Synchronize 호출!
    Synchronize(UpdateUI);

    Sleep(50); // 0.05초 대기 (시간이 걸리는 작업 시뮬레이션)
  end;
end;
```

---

## ⭐ 4. 스레드 개발 2대 골든 룰 (필독!)

### 1) `Synchronize` (동기화) 필수! 🔒
* **이유**: 델파이의 화면 컴포넌트(`TProgressBar`, `TLabel`, `TMemo`, `TEdit` 등)는 오직 **메인 스레드만 안전하게 접근**할 수 있습니다.
* 서브 일꾼 스레드가 직접 `Label1.Caption := '100%'` 라고 화면을 건드리면 **프로그램이 튕기거나(Access Violation) 멈추는 대형 버그**가 일어납니다.
* **해결책**: 메인 UI를 건드릴 메소드(`UpdateUI`)를 만들고 `Synchronize(UpdateUI);`를 호출하면, 델파이가 메인 스레드에게 **"이 메소드 좀 안전하게 실행해줘!"** 하고 대기열에 부탁해서 안전하게 화면을 업데이트합니다.

```pascal
procedure TDownloadThread.UpdateUI;
begin
  // Synchronize 내부에서 실행되므로 메인 UI를 안전하게 수정 가능!
  FormThread.ProgressBar1.Position := FProgress;
  FormThread.LabelStatus.Caption := '진행률: ' + IntToStr(FProgress) + '%';
end;
```

### 2) `FreeOnTerminate := True` (메모리 누수 방지) 🧹
* 스레드 작업이 종료(`Execute` 끝)되었을 때 **메모리에서 스스로 깔끔하게 자동 해제**되도록 설정합니다.

---

## 💻 5. 버튼을 눌러 스레드 실행하는 방법

```pascal
procedure TFormThread.BtnStartThreadClick(Sender: TObject);
var
  WorkerThread: TDownloadThread;
begin
  BtnStartThread.Enabled := False;

  // 1. Create(False) : 생성과 동시에 즉시 실행!
  //    (Create(True)로 만들면 WorkerThread.Resume; 을 불러줘야 시작됨)
  WorkerThread := TDownloadThread.Create(False);

  // 2. 스레드가 끝나면 메모리에서 자동 삭제!
  WorkerThread.FreeOnTerminate := True; 
end;
```

---

## 🎯 실무 핵심 요약 3줄 체크리스트!

1. 5초 이상 오래 걸리는 대용량 루프/통신은 ➡️ **`TThread` 백그라운드 스레드로 처리하기!**
2. 백그라운드 스레드 안에서 화면 UI(프로그레스바, 라벨)를 고칠 땐 ➡️ **반드시 `Synchronize(메소드명)` 사용하기!**
3. 스레드가 끝나고 메모리가 새지 않게 하려면 ➡️ **`FreeOnTerminate := True;` 설정하기!**
