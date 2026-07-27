# 05. 고급 기능 및 기타 외부 컴포넌트 가이드 (Decision Cube, ActiveX, Rave 등) 🔬

> 💡 **초초보자를 위한 한 줄 요약**  
> 다차원 데이터 분석(OLAP), 외부 ActiveX/COM 객체 연동, 리포트 출력(Rave Report), 웹 앱을 파스칼로 만드는 IntraWeb 등 특수 목적 컴포넌트 모음입니다!

---

## 📊 1. Decision Cube 탭 (OLAP 다차원 데이터 분석)

대용량 데이터를 다차원(큐브) 구조로 요약하여 통계 대시보드나 피벗 테이블을 만드는 고전 데이터 분석 탭입니다.

| 컴포넌트명 | 역할 및 설명 |
| :--- | :--- |
| **`TDecisionCube`** | 다차원 데이터를 메모리에 큐브(Cube) 형태로 생성하고 수집하는 핵심 데이터 엔진입니다. |
| **`TDecisionQuery`** | Decision Cube에 공급할 SQL 데이터를 추출하는 특수 쿼리 컴포넌트입니다. |
| **`TDecisionSource`**| Decision Cube와 화면의 피벗 그리드 UI를 연결해 주는 중간 연결 소스입니다. |
| **`TDecisionGrid`** | 엑셀의 **피벗 테이블(Pivot Table)**처럼 다차원 데이터 범주를 드래그하여 교차 분석하는 표입니다. |
| **`TDecisionGraph`**| 피벗 분석 결과를 실시간 다차원 차트로 시각화하는 그래픽 컴포넌트입니다. |
| **`TDecisionPivot`**| 사용자가 차원(Dimension) 축을 클릭하여 바꿀 수 있게 해주는 컨트롤러 버튼바입니다. |

---

## 🔌 2. ActiveX & COM+ 탭 (외부 윈도우 컴포넌트 연동)

윈도우 운영체제에 등록된 외부 DLL/OCX ActiveX 컨트롤을 델파이 폼 위에 올려 쓸 때 사용합니다.

| 컴포넌트명 | 역할 및 설명 |
| :--- | :--- |
| **ActiveX 탭** | Flash Player, 외부 차트 모듈, 한글 HWPUC 등 외부 윈도우 컴포넌트(OCX)를 델파이 팔레트에 등록하면 이 탭에 꽂히게 됩니다. |
| **COM+ 탭** | 윈도우 엔터프라이즈 COM+ (MTS) 서비스 및 분산 객체 트랜잭션을 처리하는 컴포넌트 집합입니다. |

---

## 📄 3. Rave 탭 (리포트 인쇄 / 출력 전용 레포트)

델파이 7에 기본 탑재된 레포트 출력 엔진인 **Rave Reports** 연동 부품들입니다.

| 컴포넌트명 | 역할 및 설명 | 주요 사용법 팁 |
| :--- | :--- | :--- |
| **`TRvProject`** | **(실무 필수!)** Rave Report 디자이너로 작성한 레포트 파일(`.rav`)을 불러와 인쇄를 총괄합니다. | `ProjectFile`, `Execute` |
| **`TRvSystem`** | 인쇄 설정(프린터 선택, 페이지 번호, 미리보기 창 크기 등)을 제어합니다. | `EngineSetup`, `DefaultReport` |
| **`TRvDataSetConnection`**| 델파이 DB 데이터(DataSet)를 Rave Report 디자이너 쪽으로 넘겨주는 데이터 다리입니다. | `DataSet` |
| **`TRvCustomConnection`** | DB가 아닌 커스텀 메모리 데이터를 Rave Report로 전달할 때 씁니다. | `OnGetRow`, `OnGetCols` |

---

## 🌐 4. IntraWeb 탭 (IW Standard, IW Data, IW Client Side)

델파이 코딩 방식 그대로 웹 브라우저 애플리케이션(Web App)을 개발할 수 있게 해주는 **IntraWeb (Atozed Software)** 전용 탭 모음입니다.

| 탭 구분 | 포함 주요 컴포넌트 및 역할 |
| :--- | :--- |
| **`IW Standard` 탭** | `TIWButton`, `TIWEdit`, `TIWLabel`, `TIWComboBox` 등 웹 화면에 렌더링되는 HTML 컴포넌트들입니다. |
| **`IW Data` 탭** | `TIWDBGrid`, `TIWDBEdit`, `TIWDBLabel` 등 웹 화면과 DB 데이터를 동기화해 주는 IntraWeb 전용 DB UI입니다. |
| **`IW Client Side` 탭** | 웹 브라우저 클라이언트 측 JavaScript 이벤트를 수행하는 스크립트 기반 컴포넌트들입니다. |

---

## 📝 정리: 델파이 7 컴포넌트 팔레트 전체 학습을 마치며

이로써 델파이 7 컴포넌트 팔레트에 포함된 **25여 개 이상의 탭과 모든 컴포넌트 분류**를 완벽하게 정리했습니다!

* 특정 컴포넌트의 사용법이 궁금할 땐 언제든지 메인 목차([README.md](README.md))를 활용하여 빠르게 원하는 탭으로 이동하세요.

---

* **목차로 돌아가기**: [README.md](README.md)
* **이전 단계**: [04. 네트워크, 웹, 인디(Indy) 통신 가이드](04-network-web-indy.md)
