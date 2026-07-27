# 02. 윈도우 컨트롤, 시스템, 대화상자 가이드 (Win32, System, Dialogs 등) 🖥️

> 💡 **초초보자를 위한 한 줄 요약**  
> 윈도우 탐색기 스타일의 고급 컨트롤(탭, 트리, 리스트), 시계 타이머, 윈도우 표준 대화상자(파일 열기/저장 창) 모음입니다!

---

## 🟡 1. Win32 탭 컴포넌트 전수 정리

윈도우 운영체제의 고유 고급 컨트롤을 본떠 만든 18가지 탭 컴포넌트입니다.

| 컴포넌트명 | 아이콘 비유 | 역할 및 설명 | 주요 프로퍼티(Property) / 팁 |
| :--- | :---: | :--- | :--- |
| **`TTabControl`** | 🗂️ | 단일 영역 바탕에 탭(Tab) 날개만 여러 개 만들어 탭 변경 이벤트를 처리합니다. | `Tabs` (TStrings), `TabIndex` |
| **`TPageControl`**| 📑 | **(실무 자주 씀!)** 탭 페이지마다 서로 다른 화면 컴포넌트들을배치할 수 있는 탭 상자입니다. | `ActivePage`, `Pages` (TTabSheet) |
| **`TImageList`** | 🖼️📦 | 16x16 등의 소형 아이콘 이미지를 모아 두고 메뉴나 트리에 번호로 공급해 줍니다. | `Images` (TBitmap 아이콘 리스트) |
| **`TTreeView`** | 🌲 | 폴더 구조처럼 나무 가지(Node) 형태의 계층형 데이터를 보여줍니다. | `Items` (TTreeNodes), `Selected` |
| **`TListView`** | 📑📂 | 윈도우 탐색기 파일 목록처럼 큰아이콘/자세히/리스트 모드로 출력합니다. | `ViewStyle` (vsReport, vsIcon 등), `Items` |
| **`THeaderControl`**| 📏 | 열 헤더 구분선 표시줄을 만듭니다. (보통 리스트 헤더로 사용) | `Sections` |
| **`TStatusBar`** | 🛈 | 창 맨 아래에 텍스트나 준비 상태를 여러 칸으로 나누어 안내하는 상태바입니다. | `Panels`, `SimpleText` |
| **`TToolBar`** | 🎛️ | 아이콘 버튼들이 줄지어 배치되는 표준 툴바를 생성합니다. | `Images` (TImageList 연결) |
| **`TCoolBar`** | 🧊 | 마우스로 끌어서 이동할 수 있는 신축성 있는 인터랙티브 툴바입니다. | `Bands` |
| **`TProgressBar`** | 🟩 | 작업 진행률(0%~100%)을 채워지는 초록색 막대로 보여줍니다. | `Position`, `Min`, `Max`, `StepIt` |
| **`TTrackBar`** | 🎚️ | 볼륨 조절 슬라이더처럼 단추를 마우스로 끌어서 수치를 조절합니다. | `Position`, `Min`, `Max` |
| **`TUpDown`** | 🔼🔽 | 숫자를 올리거나 내리는 미니 화살표 버튼 세트입니다. | `Associate` (TEdit 컨트롤과 연결) |
| **`THotKey`** | ⌨️ | 사용자가 키보드 단축키(예: `Ctrl + Shift + A`)를 누르면 해당 단축키를 입력받습니다. | `HotKey` |
| **`TDateTimePicker`**| 📅 | **(실무 필수!)** 날짜(`2026-07-27`)와 시간을 달력 드롭다운으로 선택합니다. | `Date`, `Time`, `Kind` (dtkDate, dtkTime) |
| **`TMonthCalendar`**| 🗓️ | 한 달 치 달력 전체를 화면에 펼쳐놓고 날짜를 선택하게 합니다. | `Date` |
| **`TAnimate`** | 🎞️ | 윈도우 기본 애니메이션(파일 복사 중, 검색 중 등의 AVI 영상)을 띄웁니다. | `CommonAVI` (aviCopyFiles 등), `Active` |
| **`TRichEdit`** | 📝 | 서식 있는 글자(글자 색상, 폰트, 서식 등)를 지원하는 워드패드형 입력상자입니다. | `SelAttributes`, `Lines` |
| **`TPageScroller`**| 📜 | 툴바나 패널이 좁을 때 좌/우 화살표를 눌러 내부를 스크롤하게 해줍니다. | `Control` |

---

## 🟢 2. System 탭 컴포넌트 전수 정리

비하인드 타이머 조작 및 멀티미디어, DDE 통신 제어를 위한 6가지 부품들입니다.

| 컴포넌트명 | 아이콘 비유 | 역할 및 설명 | 주요 프로퍼티(Property) / 팁 |
| :--- | :---: | :--- | :--- |
| **`TTimer`** | ⏱️ | **(실무 필수!)** 설정한 주주(예: 1000ms = 1초)마다 `OnTimer` 이벤트를 무한 실행합니다. | `Interval` (밀리초), `Enabled` (True/False) |
| **`TPaintBox`** | 🎨 | 자유롭게 그래픽 코딩(선 draw, 비트맵 출력)을 할 수 있는 캔버스 판입니다. | `Canvas`, `OnPaint` |
| **`TMediaPlayer`** | 🎬 | 동영상(AVI, MPG)이나 음원(WAV, MP3)을 재생하는 윈도우 미디어 플레이어입니다. | `FileName`, `Open`, `Play`, `Stop` |
| **`TOLEContainer`** | 📦 | 엑셀 문서나 워드 문서를 델파이 폼 안에 내장시켜 편집하게 해줍니다. | `CreateObjectFromFile` |
| **`TDDEClientConv`**| 🔄 | 프로세스 간 동적 데이터 교환(DDE)을 위해 데이터를 요청하는 클라이언트입니다. | `SetLink`, `RequestData` |
| **`TDDEServerConv`**| 🔄 | DDE 클라이언트의 데이터 요청에 응답하는 서버 인터페이스입니다. | `OnRequestData` |

---

## 🔵 3. Dialogs 탭 컴포넌트 전수 정리

프로그램에서 팝업으로 뜨는 윈도우 표준 대화상자 10가지 전수 모음입니다.  
*(※ 비시각적 컴포넌트이므로 코드에서 `.Execute` 메소드를 호출하여 화면에 띄웁니다!)*

| 컴포넌트명 | 아이콘 비유 | 역할 및 설명 | 실행 예시 코드 / 팁 |
| :--- | :---: | :--- | :--- |
| **`TOpenDialog`** | 📂 | "파일 열기" 대화상자를 띄워 파일 경로를 선택받습니다. | `if OpenDialog1.Execute then ShowMessage(OpenDialog1.FileName);` |
| **`TSaveDialog`** | 💾 | "다른 이름으로 저장" 대화상자를 띄워 저장할 파일 경로를 정합니다. | `SaveDialog1.FileName`, `Filter` |
| **`TOpenPictureDialog`**| 🖼️📂 | 이미지 파일 전용 미리보기가 지원되는 "그림 열기" 창입니다. | `Filter` (기본적으로 BMP, JPG 등 이미지에 맞춤) |
| **`TSavePictureDialog`**| 🖼️💾 | 이미지 파일 전용 미리보기가 지원되는 "그림 저장" 창입니다. | 그림 전용 필터 적용 |
| **`TFontDialog`** | 🅰️ | 글꼴, 글자 크기, 글자 색상 선택 대화상자를 띄웁니다. | `FontDialog1.Font` |
| **`TColorDialog`** | 🎨 | 팔레트 색상 선택 창을 띄워 색상값(TColor)을 가져옵니다. | `ColorDialog1.Color` |
| **`TPrintDialog`** | 🖨️ | 프린터 인쇄 범위, 인쇄 매수 설정 대화상자를 띄웁니다. | `Copies`, `FromPage`, `ToPage` |
| **`TPrinterSetupDialog`**| ⚙️🖨️ | 프린터 용지 방향(가로/세로) 및 용지 크기를 설정하는 창입니다. | 프린터 환경설정 |
| **`TFindDialog`** | 🔍 | 장문에서 단어를 찾는 "찾기" 팝업 대화상자입니다. | `OnFind` 이벤트 |
| **`TReplaceDialog`**| 🔄 | 단어를 찾아 다른 글자로 바꾸는 "바꾸기" 팝업 대화상자입니다. | `OnReplace` 이벤트 |

---

## ⚪ 4. Win 3.1 & Samples 탭 컴포넌트 정리

* **Win 3.1 탭**: 레거시 Windows 3.1 시대의 파일 목록 상자(`TFileListBox`, `TDirectoryListBox`, `TDriveComboBox`) 모음입니다. (최근에는 잘 쓰이지 않으며 대신 `TOpenDialog`나 `TShellTreeView`를 선호함)
* **Samples 탭**: 델파이 예제 샘플 컴포넌트로 다이얼Gauge(`TGauge`), 파이 차트(`TPie`), 캘린더(`TCalendar`), 스핀버튼(`TSpinButton`) 등이 수록되어 있습니다.

---

* **목차로 돌아가기**: [README.md](README.md)
* **다음 단계**: [03. 데이터베이스 컴포넌트 가이드](03-database-components.md)
