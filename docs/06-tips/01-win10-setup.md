# 06-1. Windows 10/11 환경에서 Delphi 7 IDE 설정 💻

> 💡 **초초보자를 위한 한 줄 요약**  
> Delphi 7은 2002년(Windows XP 시절)에 나왔습니다. 최신 **Windows 10/11**에서 쾌적하게 렉 없이 쓰려면 **권한 및 호환성 세팅**이 필수입니다!

---

## 🛠️ Windows 10/11 필수 호환성 세팅 3단계

Delphi 7 설치 폴더의 `delphi32.exe` 실행 파일 또는 바탕화면 아이콘에서 설정합니다.

1. `delphi32.exe` 마우스 오른쪽 클릭 ➡️ **`속성(Properties)`** 선택
2. **`호환성(Compatibility)`** 탭 클릭
3. 아래 2개 항목에 체크(v) 하기:
   - **`이 프로그램을 관리자 권한으로 실행`** (권한 부족으로 프로젝트 저장 안 되는 문제 방지!)
   - **`Windows XP (Service Pack 3)`** 호환 모드로 실행

---

## 🛑 'Cannot write to C:\Program Files...' 저장 에러 해결법

Windows 10 이후부터는 `Program Files` 폴더 수정을 윈도우가 엄격히 막습니다.

* **해결법**: 델파이 7 프로젝트 저장 위치를 `C:\Program Files\...` 안으로 잡지 말고, **`C:\workdir\...` 나 `C:\Projects\...` 처럼 루트 별도 폴더**를 만들어 작업하세요!

---

* **이전 단계**: [05-3. 동적 컴포넌트 생성 및 이벤트 연결](../05-vcl/03-dynamic-components.md)
* **다음 단계**: [06-2. 자주 쓰는 IDE 단축키 및 디버깅 팁](02-shortcuts.md)
