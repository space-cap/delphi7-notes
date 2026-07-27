# 01. 기본 UI 컴포넌트 가이드 (Standard & Additional) 🖼️

> 💡 **초초보자를 위한 한 줄 요약**  
> 화면을 구성하는 가장 기본적인 글자, 버튼, 입력 상자, 그리드, 이미지 부품들이 들어있는 핵심 탭입니다!

---

## 🔴 1. Standard 탭 컴포넌트 전수 정리

프로그램 UI를 만들 때 하루도 빠짐없이 사용하는 15가지 표준 부품들입니다.

| 컴포넌트명 | 아이콘 비유 | 역할 및 설명 | 주요 프로퍼티(Property) / 팁 |
| :--- | :---: | :--- | :--- |
| **`TMainMenu`** | 📋 | 창 최상단에 주 메뉴바(`파일`, `편집`, `도움말`)를 생성합니다. | `Items` (메뉴 항목 편집) |
| **`TPopupMenu`** | 🖱️ | 마우스 우클릭 시 나타나는 미니 맥락 메뉴입니다. | `Items` (다른 컴포넌트의 `PopupMenu` 속성에 연결) |
| **`TLabel`** | 🏷️ | 화면에 수정 불가능한 안내 텍스트를 출력합니다. | `Caption` (표시 글자), `Font` |
| **`TEdit`** | ✏️ | 한 줄 텍스트를 입력받는 기본 입력 상자입니다. | `Text` (입력값), `MaxLength`, `ReadOnly` |
| **`TMemo`** | 📜 | 여러 줄 장문 텍스트를 입력받거나 로그를 기록합니다. | `Lines` (TStringList), `ScrollBars` |
| **`TButton`** | 🔘 | 사용자가 클릭하여 동작을 수행하는 표준 버튼입니다. | `Caption`, `OnClick` (클릭 이벤트) |
| **`TCheckBox`** | ☑️ | 체크 표시(V)로 예/아니오 옵션을 선택합니다. | `Checked` (True/False) |
| **`TRadioButton`**| 🔘 | 그룹 내에서 단 하나만 선택 가능한 원형 버튼입니다. | `Checked` (True/False) |
| **`TListBox`** | 📜 | 여러 개의 아이템 목록을 나열하여 선택하게 합니다. | `Items` (목록), `ItemIndex` (선택된 번호) |
| **`TComboBox`** | 🔽 | 펼침 단추를 누르면 아래로 목록이 드르륵 열리는 상자입니다. | `Items`, `Text`, `Style` (csDropDownList 등) |
| **`TScrollBar`** | ↕️ | 수동으로 스크롤바 이동 조작을 구현할 때 씁니다. | `Position`, `Min`, `Max` |
| **`TGroupBox`** | 🔲 | 연관된 컴포넌트들을 테두리로 묶어 시각적으로 그룹화합니다. | `Caption` (그룹 제목) |
| **`TRadioGroup`** | 📻 | RadioButton 목록을 내장하여 그룹 선택을 쉽게 만듭니다. | `Items` (라디오 항목), `ItemIndex` |
| **`TPanel`** | 🟧 | 화면 구역을 분할하거나 컴포넌트들을 담는 바탕 패널입니다. | `Align` (alTop, alClient 등), `BevelOuter` |
| **`TActionList`** | ⚡ | 여러 버튼이나 메뉴의 클릭 동작(Action)을 한 곳에서 중앙 관리합니다. | `Actions` (공통 동작 관리) |

---

## 🟠 2. Additional 탭 컴포넌트 전수 정리

Standard 탭보다 디자인과 기능이 확장된 15가지 고급 UI 부품들입니다.

| 컴포넌트명 | 아이콘 비유 | 역할 및 설명 | 주요 프로퍼티(Property) / 팁 |
| :--- | :---: | :--- | :--- |
| **`TBitBtn`** | 🖼️🔘 | 버튼에 예쁜 비트맵 아이콘(OK, Cancel, Help 등)을 포함시킵니다. | `Kind` (bkOK, bkCancel 등), `Glyph` |
| **`TSpeedButton`** | ⚡🔘 | 툴바(ToolBar)에 들어가는 평면형 경량 버튼입니다. | `Flat` (True/False), `GroupIndex` |
| **`TMaskEdit`** | 😷✏️ | 주민번호, 전화번호, 날짜 등 지정한 형식으로만 입력받습니다. | `EditMask` (예: `999999-9999999;1;_`) |
| **`TStringGrid`** | 📊 | 엑셀처럼 행과 열 셀(Cell) 단위로 텍스트 데이터를 보여줍니다. | `Cells[Col, Row]`, `RowCount`, `ColCount` |
| **`TDrawGrid`** | 🎨📊 | 셀 안에 글자뿐만 아니라 직접 그림/색상을 커스텀하게 그립니다. | `OnDrawCell` 이벤트 |
| **`TImage`** | 🖼️ | BMP, ICO, WMF 등의 이미지 파일을 화면에 띄웁니다. | `Picture`, `Stretch` (이미지 크기 자동 맞춤) |
| **`TShape`** | 🔺🔵 | 사각형, 정사각형, 원, 타원 등 단순 도형을 그립니다. | `Shape` (stRectangle, stCircle 등), `Brush` |
| **`TBevel`** | 📐 | 입체적 선이나 경계선 구분선을 그려 화면 레이아웃을 구분합니다. | `Shape` (bsFrame, bsTopLine 등), `Style` |
| **`TScrollBox`** | 📜📦 | 내부 컴포넌트가 작아진 화면을 벗어나면 스크롤바가 자동 생성되는 상자입니다. | `AutoScroll` (True/False) |
| **`TCheckListBox`**| ☑️📜 | ListBox의 각 아이템 왼쪽에 체크박스(V)가 붙어있는 형태입니다. | `Checked[Index]` |
| **`TSplitter`** | ↔️ | 좌/우 또는 상/하 패널 사이의 크기를 마우스 드래그로 조절하게 해줍니다. | `Align` (패널 옆 붙임) |
| **`TStaticText`** | 🏷️ | Label과 유사하나 윈도우 핸들(HWND)을 가지는 텍스트 박스입니다. | `BorderStyle` |
| **`TControlBar`** | 🎛️ | 툴바를 마우스로 자유롭게 떼어내고 붙일 수 있는 도킹바입니다. | `AutoDrag` |
| **`TApplicationEvents`**| 🔔 | 프로그램 전체에서 일어나는 글로벌 이벤트(예: 폼 활성화, 예외)를 감지합니다. | `OnException`, `OnIdle` |
| **`TChart`** | 📈 | 멋진 2D/3D 차트(막대, 꺾은선, 파이 차트)를 생성하여 통계를 시각화합니다. | `Series` (차트 데이터 시리즈) |

---

* **목차로 돌아가기**: [README.md](README.md)
* **다음 단계**: [02. 윈도우 컨트롤, 시스템, 대화상자 가이드](02-win32-system-dialogs.md)
