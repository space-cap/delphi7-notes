# 05-2. 기본 VCL 컴포넌트 제어 (Button, Edit, Memo 등) 🎛️

> 💡 **초초보자를 위한 한 줄 요약**  
> 델파이 상단 팔레트에 있는 **레고 부품들(VCL 컴포넌트)**의 값(Property)을 바꾸고 조작하는 기본 테크닉을 익힙니다!

---

## 🎛️ 실무 필수 기본 VCL 컴포넌트 Top 4!

### 1. `TEdit` (한 줄 글자 입력 상자) ✏️
* **핵심 프로퍼티**: `Text`
* **사용법**:
  ```pascal
  // 사용자가 입력한 글자 가져오기
  ShowMessage('입력한 이름: ' + Edit1.Text);
  
  // 에디트 상자 내용 비우기
  Edit1.Text := '';
  ```

### 2. `TMemo` (여러 줄 장문 입력 상자) 📜
* **핵심 프로퍼티**: `Lines` (TStringList와 동일하게 작동!)
* **사용법**:
  ```pascal
  // 메모 상자에 한 줄 추가
  Memo1.Lines.Add('첫 번째 로그 기록');
  Memo1.Lines.Add('두 번째 로그 기록');
  ```

### 3. `TButton` (누르는 버튼) 🔘
* **핵심 프로퍼티**: `Caption` (버튼 위에 찍히는 글자), `Enabled` (버튼 활성화 여부)
* **사용법**:
  ```pascal
  Button1.Caption := '저장하기';
  Button1.Enabled := False; // 버튼을 비활성화해서 못 누르게 막음!
  ```

### 4. `TLabel` (화면 안내 문구 글자) 🏷️
* **핵심 프로퍼티**: `Caption`
* **사용법**:
  ```pascal
  Label1.Caption := '비밀번호를 입력하세요:';
  ```

---

## 💡 숫자를 글자로, 글자를 숫자로 바꾸는 2대 변환 함수!

VCL 컴포넌트의 `.Text`나 `.Caption`은 **무조건 `String`(글자)**입니다. 숫자를 넣거나 가져올 때는 변환 함수가 필수입니다!

1. **`IntToStr(숫자)`**: 숫자를 글자로 변환!
   - `Edit1.Text := IntToStr(100);`
2. **`StrToInt(글자)`**: 글자를 숫자로 변환!
   - `Age := StrToInt(Edit1.Text);`

---

## 🎯 초초보자를 위한 실무 요약

* 글자 상자(`TEdit`) 값을 읽거나 바꿀 땐 ➡️ **`Edit1.Text`**
* 버튼이나 라벨 글자를 바꿀 땐 ➡️ **`Button1.Caption`**
* 메모 상자 여러 줄 다룰 땐 ➡️ **`Memo1.Lines.Add('...')`**

---

* **이전 단계**: [05-1. 폼(Form) 생명주기와 주요 이벤트](01-form-lifecycle.md)
* **다음 단계**: [05-3. 동적 컴포넌트 생성 및 이벤트 연결](03-dynamic-components.md)
