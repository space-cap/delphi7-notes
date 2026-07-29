# 델파이 7 Win32 리소스(Resource) 및 메모리 자원 관리 가이드

본 문서는 **델파이 7(Delphi 7)** 환경에서 이미지, 아이콘, 사운드, 버전 정보, 바이너리 데이터 등을 **실행 파일(.exe) 내에 내장(Embedding)하여 관리하는 Win32 리소스 기술과 메모리/GDI 자원 해제 기법**을 다루는 상세 가이드입니다.

---

## 📌 1. 리소스(Resource)의 개념 및 장점

윈도우 리소스(Resource)는 실행 파일(`.exe`) 또는 DLL 파일 내부에 포함되어 저장되는 이진 데이터 구역입니다.

### 💡 리소스 내장(Embedding) 사용 시 이점
1. **단일 EXE 배포 (Single Executable)**: 이미지, 사운드, 설정 파일 등이 EXE 내부에 포함되므로 별도 셋업 파일 없이 깔끔하게 1개의 실행 파일로 배포 가능
2. **자산 보안 및 분실 방지**: 사용자가 외부 미디어 파일을 무단으로 수정/삭제하거나 유출하는 것을 방지
3. **빠른 접근 속도**: 디스크 I/O 대신 메모리 상에서 리소스를 즉시 불러올 수 있어 처리 속도가 향상됨

---

## ⚙️ 2. 리소스 스크립트(`.rc`) 작성 가이드

리소스 스크립트(`.rc`)는 텍스트 파일 형식으로 내장할 파일 목록과 자원 명칭을 정의합니다.

### 1) 자원 정의 기본 구문

```rc
// [자원 식별자 이름] [자원 타입] "[파일 경로]"
COMPANY_LOGO   BITMAP   "logo.bmp"        // 비트맵 이미지
APP_ICON       ICON     "app.ico"         // 아이콘
BG_SOUND       WAVE     "click.wav"       // WAV 사운드
CUSTOM_CONFIG  RCDATA   "config_data.dat" // 임의의 바이너리/텍스트 데이터
```

### 2) 프로그램 버전 정보 (`VERSIONINFO`) 스크립트 예시

```rc
LANGUAGE 0x09, 0x01 // 영어/한국어 로케일 설정

1 VERSIONINFO
FILEVERSION 1,0,0,0
PRODUCTVERSION 1,0,0,0
FILEFLAGSMASK 0x3fL
FILEFLAGS 0x0L
FILEOS 0x4L
FILETYPE 0x1L
FILESUBTYPE 0x0L
BEGIN
    BLOCK "StringFileInfo"
    BEGIN
        BLOCK "040904b0"
        BEGIN
            VALUE "CompanyName", "내 회사 이름"
            VALUE "FileDescription", "ERP 시스템 메인 앱"
            VALUE "FileVersion", "1.0.0.0"
            VALUE "InternalName", "MyApp"
            VALUE "LegalCopyright", "Copyright (C) 2026 MyCompany All rights reserved."
            VALUE "OriginalFilename", "MyApp.exe"
            VALUE "ProductName", "ERP Enterprise Application"
            VALUE "ProductVersion", "1.0.0.0"
        END
    END
    BLOCK "VarFileInfo"
    BEGIN
        VALUE "Translation", 0x409, 1200
    END
END
```

> **⚠️ 인코딩 주의사항**: `brcc32.exe` 리소스 컴파일러는 ANSI(CP949/EUC-KR) 인코딩 파일만 올바르게 파싱합니다. `.rc` 파일에 한글 설명이 들어갈 경우 반드시 **EUC-KR(CP949)** 인코딩으로 저장해야 컴파일 에러나 글자 깨짐이 없습니다.

---

## 🛠️ 3. `brcc32` 컴파일 및 델파이 프로젝트 연동

### 1) `brcc32.exe` 커맨드라인 컴파일
델파이가 제공하는 리소스 컴파일러를 통해 `.rc` 파일의 바이트코드를 바이너리 리소스(`.res`)로 변환합니다.

```bash
brcc32 MyResources.rc
```
컴파일이 완료되면 동일 디렉토리에 **`MyResources.res`** 파일이 만들어집니다.

### 2) 델파이 소스 파일(`*.pas` / `*.dpr`)에 연결
소스 코드의 `implementation` 구역 하단에 컴파일 지시어 `{$R 파일명.res}`를 지정합니다.

```delphi
unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs;

type
  TFormMain = class(TForm)
  ...
  end;

implementation

{$R *.dfm}
{$R MyResources.res} // 👈 컴파일된 바이너리 리소스 연결!
```

---

## 💻 4. 델파이 7 소스 코드에서의 리소스 활용 기법

### 1) 이미지(비트맵) 불러오기

```delphi
procedure TFormMain.LoadLogoImage;
begin
  // EXE 내부의 'COMPANY_LOGO' 리소스를 TImage에 표출
  Image1.Picture.Bitmap.LoadFromResourceName(HInstance, 'COMPANY_LOGO');
end;
```

### 2) `TResourceStream`을 이용한 임의 데이터/파일 추출

`RCDATA` 타입의 자원은 **`TResourceStream`** 을 사용해 메모리로 직접 가져옵니다.

```delphi
procedure TFormMain.ExtractEmbeddedConfig;
var
  ResStream: TResourceStream;
  OutputPath: string;
begin
  OutputPath := ExtractFilePath(Application.ExeName) + 'config_data.dat';

  // 1. EXE 내부의 'CUSTOM_CONFIG' 자원을 메모리 스트림으로 여는 작업
  ResStream := TResourceStream.Create(HInstance, 'CUSTOM_CONFIG', RT_RCDATA);
  try
    // 2. 디스크 파일로 저장하거나 메모리 상에서 파싱 가능
    ResStream.SaveToFile(OutputPath);
  finally
    ResStream.Free; // ⭐️ 사용 후 반드시 스트림 메모리 해제!
  end;
end;
```

### 3) 내장된 사운드 파일(WAVE) 즉시 재생

```delphi
uses
  MMSystem; // PlaySound 함수를 위해 포함

procedure TFormMain.PlayEmbeddedSound;
begin
  // EXE 내부에 있는 'BG_SOUND' 자원을 메모리 상에서 즉시 플레이
  PlaySound('BG_SOUND', HInstance, SND_RESOURCE or SND_ASYNC);
end;
```

---

## ⚠️ 5. 메모리 및 GDI 자원 해제 황금 규칙 (Memory Leak 예방)

델파이 7에서 동적으로 생성된 객체나 Win32 GDI 핸들 자원은 자동으로 메모리가 해제되지 않습니다.

### 1) 기본 객체 및 스트림 해제 (`try ... finally`)

```delphi
var
  MyStream: TMemoryStream;
begin
  MyStream := TMemoryStream.Create;
  try
    // 스트림 관련 작업 수행
  finally
    MyStream.Free; // 👈 예외가 발생하더라도 100% 자원 해제 보장
  end;
end;
```

### 2) GDI 오브젝트 (Bitmap Handle, Canvas Pen 등) 해제

GDI 자원은 Windows GDI 테이블을 차지하므로 사용 후 반드시 핸들을 삭제해주어야 시스템 둔화(GDI Leak)가 발생하지 않습니다.

```delphi
var
  HBmp: HBITMAP;
begin
  HBmp := CreateBitmap(...);
  try
    // GDI 비트맵 핸들 작업
  finally
    DeleteObject(HBmp); // 👈 Win32 API GDI 핸들 삭제
  end;
end;
```

---

## 🚨 6. EXE 용량 비대화(Bloat) 문제 및 실무 선택 가이드

> **Q. 리소스가 많으면 EXE 파일 크기도 비례해서 커지나요?**
>
> **A. 네! 리소스에 내장된 파일 용량만큼 EXE 파일 크기가 커집니다.**

### 1) EXE 비대화 시 발생하는 문제점
1. **초기 실행 로딩(Startup) 지연**: OS가 큰 EXE 파일을 메모리로 매핑하는 데 시간이 오래 걸림
2. **RAM 메모리 낭비**: 사용하지 않는 이미지/자원까지 EXE 맵 영역 전체에 상주
3. **업데이트 패치 부담**: 오타 하나 수정해도 수십~수백 MB의 무거운 EXE를 다시 다운로드해야 함

### 2) 실무 내장 vs 분리 선택 가이드

```text
[EXE 내장 리소스 ({$R *.res})] ➔ 소형/필수 자원 (합계 2~5MB 이내 권장)
 ├── 메인 앱 아이콘 (app.ico)
 ├── UI 버튼/메뉴 툴바 소형 아이콘 (16x16, 24x24)
 └── 회사 메인 폼 고정 로고 1~2개

[외부 파일 / 서버 분리] ➔ 대용량/가변 자원
 ├── 수만 개의 상품 이미지 (외부 .dat / HTTP 파일 서버 사용)
 ├── 동영상 및 BGM 사운드
 └── 리소스 전용 DLL (Resource DLL: LoadLibrary로 동적 로드)
```

---

## 📋 7. 리소스 관리 체크리스트

| 항목 | 체크사항 | 권장 사항 |
| :--- | :--- | :--- |
| **파일 인코딩** | `.rc` 스크립트 한글 포함 여부 | **EUC-KR (CP949)** 인코딩 사용 (`brcc32` 호환) |
| **자원 식별자** | 자원 이름 중복 | 대문자 기반 영문 식별자 사용 (`COMPANY_LOGO` 등) |
| **용량 관리** | 리소스 전체 크기 | 5MB 이하로 관리하고 **대용량 파일은 외부 분리** |
| **메모리 해제** | `TResourceStream` 사용 후 | `try ... finally` 구문으로 `.Free` 보장 |
| **배포 단위** | 외부 미디어 파일 개수 | 보안/관리 필요 자원은 EXE 내부 내장(`{$R *.res}`) |
