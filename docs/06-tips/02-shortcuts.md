# 06-2. 자주 쓰는 IDE 단축키 및 디버깅 팁 ⚡

> 💡 **초초보자를 위한 한 줄 요약**  
> 칼퇴를 부르는 델파이 7 마법의 단축키 모음집! 손에 익히면 코딩 속도가 3배 빨라집니다.

---

## ⚡ 델파이 7 황금 단축키 Top 10!

| 단축키 | 기능 이름 | 설명 |
| :--- | :--- | :--- |
| **`F9`** | **Run (실행)** | 프로젝트를 컴파일하고 즉시 실행 |
| **`F12`** | **Toggle Code / Form** | 소스 코드 창(`.pas`) ↔ 화면 디자인 폼(`Form`)을 왔다 갔다 전환! |
| **`Alt + F12`** | **View Form Text** | 화면 디자인 창 ↔ 텍스트 DFM 코드로 전환 |
| **`Ctrl + F9`** | **Compile** | 실행은 안 하고 코드에 문법 에러가 있는지 미리 컴파일 검사! |
| **`Ctrl + Shift + C`** | **Code Completion** | interface에 프로시저 선언 후 누르면 implementation에 **자동으로 틀 완성!** (★필수) |
| **`Ctrl + Space`** | **Auto Complete** | 변수나 함수 이름 자동 완성 팝업 띄우기 |
| **`F8`** | **Step Over** | 디버깅 시 한 줄씩 실행 |
| **`F7`** | **Step Into** | 디버깅 시 함수 안으로 점프해서 들어가기 |
| **`Ctrl + Shift + Up/Down`** | **Jump to Pair** | interface 선언부 ↔ implementation 구현부 사이를 한 번에 점프! |
| **`Ctrl + F7`** | **Evaluate/Watch** | 변수 실시간 값 확인창 띄우기 |

---

## 🧙‍♂️ 사수도 감탄하는 마법 단축키: `Ctrl + Shift + C`

`interface`에 `procedure DoSomething;` 이라고 타자 친 다음 **`Ctrl + Shift + C`** 키를 누르면:

델파이가 알아서 `implementation` 구역으로 가서 아래 코드를 1초 만에 자동으로 만들어 줍니다!

```pascal
procedure TForm1.DoSomething;
begin

end;
```

---

* **이전 단계**: [06-1. Windows 10/11 환경에서 Delphi 7 IDE 설정](01-win10-setup.md)
* **다음 단계**: [06-3. 필수 `.gitignore` 설정 및 파일 관리](03-gitignore.md)
