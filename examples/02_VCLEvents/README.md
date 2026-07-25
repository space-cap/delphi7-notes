# 02. Delphi 7 VCL 폼 및 이벤트(Event) 실습 가이드

이 예제는 델파이 7의 핵심 특징인 **VCL(Visual Component Library) 폼 디자인**과 **이벤트 기반 프로그래밍(Event-Driven Programming)**을 학습하기 위한 실습입니다.

---

## 🎯 실습 목표
1. **VCL 컴포넌트 배치**: `TLabel`, `TEdit`, `TButton`, `TMemo` 사용법 익히기
2. **이벤트 핸들러 작성**: `OnClick`, `OnCreate` 이벤트 처리 방법 습득
3. **코드 & 디자인 폼 전환**: `F12` 키를 이용한 폼 디자인과 코드 윈도우 교체 익히기

---

## 🚀 델파이 7에서 실습하는 2가지 방법

### 1️⃣ [방법 A] 완성된 프로젝트 열어 실행하기 (빠른 확인)

1. **프로젝트 열기**:
   - 델파이 7 IDE 실행 후 `File` -> `Open Project...` (단축키 `Ctrl + O`) 클릭
   - `examples/02_VCLEvents/VCLEventsDemo.dpr` 프로젝트 파일 선택

2. **실행 및 테스트**:
   - `F9` 키 (또는 상단 메뉴 `Run` -> `Run`)를 눌러 프로그램을 컴파일 및 실행합니다.
   - 이름 입력창에 이름을 입력하고 **[인사하기]** 버튼 클릭 ➔ 메시지 창 및 메모장 로그 확인!
   - **[로그 지우기]** 버튼 클릭 ➔ 메모장 초기화 확인!

3. **코드 & 디자인 살펴보기**:
   - **`F12` 키**: 디자인 화면(Form Designer)과 코드 편집기(Code Editor)를 서로 전환합니다.
   - **`F11` 키 (Object Inspector)**:
     - 버튼(`BtnGreet`)을 선택한 후 `Events` 탭에서 `OnClick` 항목을 보면 `BtnGreetClick` 함수가 연결되어 있는 것을 확인할 수 있습니다.

---

### 2️⃣ [방법 B] 처음부터 직접 폼을 만들어 실습하기 (추천 ⭐)

VCL 컴포넌트와 이벤트를 제대로 익히려면 델파이 7 IDE에서 직접 만들어보시는 것을 강력히 추천합니다!

#### STEP 1: 새 VCL 애플리케이션 생성
* 델파이 7 메뉴: `File` -> `New` -> `Application` 클릭 (새 폼 생성)

#### STEP 2: 컴포넌트 배치 (Component Palette -> Standard 탭)
폼 위에 팔레트에서 아래 컴포넌트를 드래그 & 드롭으로 배치하고 `Object Inspector (F11)`에서 속성(`Properties`)을 변경합니다.

| 컴포넌트 | Name (속성) | 주요 속성 설정 | 역할 |
| :--- | :--- | :--- | :--- |
| `TLabel` | `LabelName` | `Caption`: `이름:` | 안내 문구 표시 |
| `TEdit` | `EditName` | `Text`: `홍길동` | 사용자 이름 입력창 |
| `TButton` | `BtnGreet` | `Caption`: `인사하기` | 인사 메시지 실행 버튼 |
| `TButton` | `BtnClear` | `Caption`: `로그 지우기` | 메모장 초기화 버튼 |
| `TMemo` | `MemoLog` | `Lines`: (내용 모두 삭제) | 인사 기록 로그 표시 창 |

#### STEP 3: 이벤트 핸들러 만들기 (더블클릭 마법🪄)
델파이 7은 디자인 화면에서 컴포넌트를 **더블클릭**하면 기본 이벤트 핸들러 코드가 자동으로 생성됩니다.

1. **폼 바탕 빈 곳 더블클릭** ➔ `FormCreate` 이벤트 자동 생성:
   ```pascal
   procedure TFormMain.FormCreate(Sender: TObject);
   begin
     Caption := 'Delphi 7 VCL 이벤트 실습';
     EditName.Text := '홍길동';
     MemoLog.Lines.Add('=== 프로그램이 성공적으로 실행되었습니다. ===');
   end;
   ```

2. **[인사하기] 버튼 더블클릭** ➔ `BtnGreetClick` 이벤트 자동 생성:
   ```pascal
   procedure TFormMain.BtnGreetClick(Sender: TObject);
   var
     UserName: String;
   begin
     UserName := Trim(EditName.Text);
     if UserName = '' then
     begin
       ShowMessage('이름을 입력해 주세요!');
       EditName.SetFocus;
       Exit;
     end;

     ShowMessage('안녕하세요, ' + UserName + '님!');
     MemoLog.Lines.Add('[' + TimeToStr(Now) + '] 인사 완료: ' + UserName + '님');
   end;
   ```

3. **[로그 지우기] 버튼 더블클릭** ➔ `BtnClearClick` 이벤트 자동 생성:
   ```pascal
   procedure TFormMain.BtnClearClick(Sender: TObject);
   begin
     MemoLog.Clear;
     MemoLog.Lines.Add('=== 로그가 초기화되었습니다. ===');
   end;
   ```

#### STEP 4: 실행 및 저장
* `F9` 키를 눌러 실행하여 작동을 확인합니다!
* 프로젝트 저장(`Ctrl + S` / `Shift + Ctrl + S`):
  - 폼 단위: `MainForm.pas`로 저장
  - 프로젝트 단위: `VCLEventsDemo.dpr`로 저장

---

## 🔑 핵심 델파이 7 숏컷 (단축키 모음)
* **`F9`**: 프로그램 실행 (Run)
* **`F12`**: 폼 디자인 ↔ 코드 편집기 전환
* **`F11`**: Object Inspector 창 열기/닫기 (컴포넌트 속성 및 이벤트 설정)
* **`Ctrl + F9`**: 실행 없이 구문 컴파일만 수행 (Compile)
