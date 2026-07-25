# Delphi 7 Notes & Reference 🚀

델파이 7(Delphi 7) 핵심 문법, OOP 개념, VCL 컴포넌트 활용 및 개발 팁을 정리하는 저장소입니다.

---

## 📌 목차 (Table of Contents)

### 0. 인턴 온보딩 & 실무 환경 가이드 (Onboarding) 🐣
- [x] [00-0. 델파이(Delphi)의 역사와 Delphi 7이 전설이 된 이유](docs/00-onboarding/00-delphi-history.md)
- [x] [00-1. 델파이 7 주요 파일 확장자 구조 (.dpr, .pas, .dfm, .dcu)](docs/00-onboarding/01-file-extensions.md)
- [x] [00-2. 실무 써드파티 컴포넌트 파악 (DevExpress, FastReport 등)](docs/00-onboarding/02-third-party-components.md)
- [x] [00-3. Delphi 7 IDE 디버깅 완벽 가이드 (F7, F8, F9, Watch)](docs/00-onboarding/03-ide-debugging.md)
- [x] [00-4. DFM 파일 관리 및 Git 형상관리 주의사항 (Text DFM 설정)](docs/00-onboarding/04-dfm-and-git.md)
- [x] [00-5. 로컬 빌드 환경 구축 노트 (Search Path & Library Path 설정)](docs/00-onboarding/05-build-environment.md)

### 1. 기본 문법 & 소스 구조 (Basics)
- [x] [01-1. 유닛 구조 (interface & implementation)](docs/01-basics/01-unit-structure.md)
- [x] [01-2. 변수 선언, 자료형 및 연산자](docs/01-basics/02-variables-and-types.md)
- [x] [01-3. 제어문 (if, case, for, while)](docs/01-basics/03-control-statements.md)
- [x] [01-4. 프로시저와 함수 (procedure & function)](docs/01-basics/04-procedures-and-functions.md)

### 2. 객체지향 프로그래밍 (OOP)
- [x] [02-1. 클래스(Class) 선언과 객체 생성](docs/02-oop/01-class-and-object.md)
- [x] [02-2. 생성자(Constructor)와 소멸자(Destructor)](docs/02-oop/02-constructor-destructor.md)
- [x] [02-3. 상속, 캡슐화, 다형성](docs/02-oop/03-inheritance.md)
- [x] [02-4. 프로퍼티(Property)와 이벤트 핸들링](docs/02-oop/04-properties.md)

### 3. 메모리 관리 & 예외 처리 (Memory & Exceptions)
- [x] [03-1. try...finally 기반 안전한 객체 해제 패턴](docs/03-memory/01-try-finally.md)
- [x] [03-2. try...except 예외 처리](docs/03-memory/02-try-except.md)
- [x] [03-3. 포인터와 동적 메모리 할당](docs/03-memory/03-pointers.md)
- [x] [03-4. 대표 런타임 에러 분석 (Access Violation, Index Out of Bounds 등)](docs/03-memory/04-common-runtime-errors.md)

### 4. 문자열 & 데이터 구조 (Data Handling)
- [x] [04-1. AnsiString 특성과 한글 문자열 처리](docs/04-data/01-ansi-string.md)
- [x] [04-2. TStringList 및 TList 활용법](docs/04-data/02-lists.md)
- [x] [04-3. 레코드(Record)와 동적 배열](docs/04-data/03-record-and-array.md)
- [x] [04-4. 한글 2Byte(CP949) 처리 및 문자열 잘림(자소 파괴) 방지](docs/04-data/04-korean-bytes.md)

### 5. VCL & GUI 프로그래밍 (UI)
- [x] [05-1. 폼(Form) 생명주기와 주요 이벤트](docs/05-vcl/01-form-lifecycle.md)
- [x] [05-2. 기본 VCL 컴포넌트 제어 (Button, Edit, Memo 등)](docs/05-vcl/02-basic-components.md)
- [x] [05-3. 동적 컴포넌트 생성 및 이벤트 연결](docs/05-vcl/03-dynamic-components.md)

### 6. 델파이 7 팁 & 환경 설정 (Tips & Setup)
- [x] [06-1. Windows 10/11 환경에서 Delphi 7 IDE 설정](docs/06-tips/01-win10-setup.md)
- [x] [06-2. 자주 쓰는 IDE 단축키 및 디버깅 팁](docs/06-tips/02-shortcuts.md)
- [x] [06-3. 필수 `.gitignore` 설정 및 파일 관리](docs/06-tips/03-gitignore.md)

### 7. 데이터베이스 연동 (Database & ADO) 🗄️
- [x] [07-1. TADOConnection 및 TADOQuery 기초](docs/07-database/01-ado-basics.md)
- [x] [07-2. TDataSet 조작 (First, Next, Edit, Post, FieldByName)](docs/07-database/02-dataset-operations.md)
- [x] [07-3. TDBGrid 및 데이터 바인딩 컴포넌트 활용](docs/07-database/03-dbgrid-binding.md)

### 8. 파일 처리 & 네트워크 (File I/O & Network) 📁
- [x] [08-1. TIniFile 및 TFileStream 활용법](docs/08-file-network/01-inifile-and-stream.md)
- [x] [08-2. Indy 컴포넌트를 이용한 HTTP 및 소켓 통신](docs/08-file-network/02-indy-sockets.md)
- [x] [08-3. 외부 프로세스 실행 및 연동 (ShellExecute & CreateProcess)](docs/08-file-network/03-external-process.md)

### 9. Win32 API & DLL 연동 (DLL & Windows API) ⚙️
- [x] [09-1. C/C++ DLL 연동 (정적 & 동적 로딩)](docs/09-dll-api/01-dll-loading.md)
- [x] [09-2. Windows 메시지 핸들링 및 커스텀 메시지](docs/09-dll-api/02-win32-messages.md)

### 10. 고급 주제 & 레거시 디버깅 (Advanced & Debugging) 🛠️
- [x] [10-1. 커스텀 VCL 컴포넌트 제작 기초](docs/10-advanced/01-custom-component.md)
- [x] [10-2. FastMM4를 이용한 메모리 누수(Memory Leak) 추적](docs/10-advanced/01-fastmm4-debugging.md)
- [x] [10-3. 멀티스레딩(TThread)과 UI 동기화(Synchronize)](docs/10-advanced/03-multithreading.md)

---

## 📂 저장소 구조 (Repository Layout)

```text
delphi7-notes/
├── README.md             # 메인 목차 문서
├── .gitignore            # Delphi 7 임시 파일 제외 설정
├── docs/                 # 개념 정리 마크다운 문서 (.md)
│   ├── 00-onboarding/
│   ├── 01-basics/
│   ├── 02-oop/
│   ├── 03-memory/
│   ├── 04-data/
│   ├── 05-vcl/
│   ├── 06-tips/
│   ├── 07-database/
│   ├── 08-file-network/
│   ├── 09-dll-api/
│   └── 10-advanced/
└── examples/             # 실습용 델파이 예제 코드 (.pas, .dpr)
    ├── 01_BasicSyntax/
    ├── 02_VCLEvents/
    ├── 03_ADODatabase/
    └── 04_DLLCall/
```