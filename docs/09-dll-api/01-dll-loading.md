# 09-1. C/C++ DLL 연동 (정적 & 동적 로딩) ⚙️

> 💡 **초초보자를 위한 한 줄 요약**  
> 다른 사람(또는 C/C++ 개발자)이 미리 만들어놓은 **기능 부품 상자(`.dll` 파일)** 안에 든 함수를 불러와서 델파이에서 사용하는 방법입니다!

---

## 📌 DLL 불러오기 2가지 방식 비교

### 1. 정적 로딩 (Static Loading - `external` 키워드) 🔒
* **특징**: 프로그램이 **켜지자마자 DLL을 바로 로딩**합니다.
* **장점**: 코드 작성이 매우 쉽습니다.
* **단점**: `.dll` 파일이 폴더에 없으면 프로그램 실행 자체가 거부되며 튕깁니다!

```pascal
// C/C++ DLL 안의 AddNumbers 함수 정적 선언
function AddNumbers(A, B: Integer): Integer; stdcall; external 'MyPlugin.dll';

// 소스 코드에서 일반 함수처럼 그냥 부르면 끝!
Ans := AddNumbers(10, 20);
```

---

### 2. 동적 로딩 (Dynamic Loading - `LoadLibrary`) 🔓
* **특징**: 필요한 순간에만 `LoadLibrary` 로 DLL을 켜고 사용 후 반납합니다.
* **장점**: `.dll` 파일이 없어도 프로그램이 안 튕기고 에러 안내 메시지를 띄울 수 있어 안전합니다!

```pascal
var
  DLLHandle: THandle;
begin
  // 1. DLL 파일 열기
  DLLHandle := LoadLibrary('MyPlugin.dll');
  if DLLHandle <> 0 then
  begin
    try
      // DLL 내부 함수 주소 찾아서 호출...
    finally
      // 2. 사용 후 메모리 반납!
      FreeLibrary(DLLHandle);
    end;
  end
  else
    ShowMessage('DLL 파일을 찾을 수 없습니다!');
end;
```

---

* **이전 단계**: [08-3. 외부 프로세스 실행 및 연동 (ShellExecute & CreateProcess)](../08-file-network/03-external-process.md)
* **다음 단계**: [09-2. Windows 메시지 핸들링 및 커스텀 메시지](02-win32-messages.md)
