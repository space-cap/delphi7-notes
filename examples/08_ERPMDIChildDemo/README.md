# 08_ERPMDIChildDemo ERP MDI 자식 창(Child Form) 관리 실습 가이드 🏢

> 💡 **초초보자 & 신입/인턴 개발자를 위한 한 줄 요약**  
> 메뉴를 클릭할 때마다 진짜 ERP 시스템처럼 **독립된 서브 폼(Form) 창들이 화면 안에 뿅! 하고 뜨고**, 이미 열린 창은 중복 생성 없이 앞으로 튀어나오게 관리하는 MDI 구조 실습 예제입니다!

---

## 🎯 이 예제에서 배우는 핵심 ERP 실무 패턴

1. **`FormStyle := fsMDIForm`**: 메인 화면을 MDI 부모 창으로 설정
2. **`FormStyle := fsMDIChild`**: 사용자 관리, 주문 등록 화면을 MDI 자식 창으로 설정
3. **MDI 중복 생성 방지 헬퍼 함수 (`OpenChildForm`)**: 이미 창이 켜져 있으면 `BringToFront`로 앞으로 가져오고, 없으면 `Create`로 새로 띄우기!
4. **`Action := caFree;`**: MDI 자식 창이 닫힐 때(`FormClose`) 메모리에서 깔끔하게 해제하기
5. **창 관리 기능 (`Cascade`, `Tile`, `CloseAll`)**: 열려있는 MDI 창들을 계단식, 바둑판으로 정렬하거나 일괄 닫기

---

## 📄 파스칼 주요 소스 코드 해설 (`MDIMainForm.pas`)

### 1) 중복 생성 방지 & 자식 창 열기 헬퍼 함수 (★ 실무 핵심 100점 코드!)

```pascal
function TFormMDIMain.OpenChildForm(FormClass: TFormClass): TForm;
var
  I: Integer;
begin
  // 1. 이미 열려있는 MDI Child 창 중에서 동일한 클래스가 있는지 검사
  for I := 0 to MDIChildCount - 1 do
  begin
    if MDIChildren[I] is FormClass then
    begin
      Result := MDIChildren[I];
      Result.BringToFront; // 이미 열려있으면 맨 앞으로 포커스!
      Exit;
    end;
  end;

  // 2. 열려있는 창이 없으면 새로 띄우기 (MDI Child)
  Result := FormClass.Create(Application);
end;
```

### 2) MDI 자식 창이 닫힐 때 메모리 해제 (`UserMgmtForm.pas`)

```pascal
procedure TFormUserMgmt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // ★ MDI Child 창은 X버튼을 누를 때 반드시 caFree를 지정해야 메모리가 해제됩니다!
  Action := caFree; 
end;
```

---

## 💻 델파이 7 IDE에서 실습하는 방법

1. `examples/08_ERPMDIChildDemo/` 폴더로 이동합니다.
2. **`ERPMDIChildDemo.dpr`** 프로젝트 파일을 더블클릭하여 델파이 7 IDE를 엽니다.
3. 키보드의 **`F9`** 키를 눌러 실행합니다.
4. **`[시스템 관리 ➔ 사용자 관리 창 열기]`** 메뉴를 클릭합니다.
5. 사용자 관리 화면 창이 메인 화면 안에 자식 창으로 짠! 하고 뜹니다.
6. 다시 똑같은 메뉴를 클릭해 봅니다 ➔ 창이 중복 생성되지 않고 기존 창이 앞으로 튀어나옵니다!
7. **`[영업 관리 ➔ 주문 등록 창 열기]`**를 클릭하여 여러 창을 띄운 뒤, **`[창 관리 ➔ 계단식/바둑판 정렬]`**을 해봅니다!

---

* **이전 단계**: [07_ERPMenuDemo 메인 메뉴 구성 실습](../07_ERPMenuDemo/README.md)
