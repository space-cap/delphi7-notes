# 09_TabbedMDIERP 모던 ERP - 웹 스타일 접이식 사이드바 + 상단 MDI 탭 시스템 실습 🏢

> 💡 **초초보자 & 신입/인턴 개발자를 위한 한 줄 요약**  
> 최신 모던 웹/앱(Notion, VS Code 등)처럼 **좌측 사이드바를 토글 버튼(`[<]` / `[>]`) 하나로 접었다 폈다(Collapsible Sidebar)** 할 수 있고, **상단 MDI 탭바(`TTabControl`)**와 동기화되는 100% 모던 ERP 구축 예제입니다!

---

## 🎯 이 예제에서 배우는 모던 ERP 실무 테크닉

1. **웹 스타일 접이식 사이드바 (`Collapsible Sidebar`)**: 토글 버튼 클릭 시 사이드바 패널 너비를 210px ↔ 38px로 접기/펼치기
2. **좌측 메뉴 트리 (`TSplitter` + `TTreeView`)**: 사이드바가 펼쳐졌을 때 메뉴를 클릭하면 해당 ERP 자식 화면 생성
3. **상단 MDI 탭바 연동 (`TTabControl`)**: 자식 폼이 생성/활성화/닫힐 때 상단 탭을 동적으로 추가/선택/삭제하는 동기화 로직
4. **탭 클릭 폼 전환 (`BringToFront`)**: 상단 탭을 누르면 연동된 MDI Child 폼이 맨 앞으로 짠! 하고 전환됨

---

## 📄 파스칼 주요 소스 코드 해설 (`TabbedMDIMainForm.pas`)

### 1) 좌측 사이드바 토글 접기/펼치기 코드

```pascal
procedure TFormTabbedMDIMain.SetSidebarCollapsed(const Collapse: Boolean);
begin
  FIsSidebarCollapsed := Collapse;

  if Collapse then
  begin
    // 사이드바 접기 (Collapse Mode: 38px)
    LabelSidebarTitle.Visible := False;
    TreeViewSidebar.Visible := False;
    SplitterLeft.Visible := False;
    
    PanelSidebar.Width := 38;
    BtnToggleSidebar.Left := 4;
    BtnToggleSidebar.Caption := '>'; // 펼치기 아이콘으로 변경!
  end
  else
  begin
    // 사이드바 펼치기 (Expand Mode: 210px)
    PanelSidebar.Width := 210;
    BtnToggleSidebar.Left := 172;
    BtnToggleSidebar.Caption := '<'; // 접기 아이콘으로 변경!
    LabelSidebarTitle.Visible := True;
    TreeViewSidebar.Visible := True;
    SplitterLeft.Visible := True;
  end;
end;

// 토글 버튼 클릭 이벤트
procedure TFormTabbedMDIMain.BtnToggleSidebarClick(Sender: TObject);
begin
  SetSidebarCollapsed(not FIsSidebarCollapsed);
end;
```

---

## 💻 델파이 7 IDE에서 실습하는 방법

1. `examples/09_TabbedMDIERP/` 폴더로 이동합니다.
2. **`TabbedMDIERP.dpr`** 프로젝트 파일을 더블클릭하여 델파이 7 IDE를 엽니다.
3. 키보드의 **`F9`** 키를 눌러 실행합니다.
4. 좌측 사이드바 상단의 **`[<]` 버튼을 클릭해 보세요** ➔ 사이드바가 쏙! 접히면서 메인 화면 영역이 아주 넓어집니다!
5. 다시 **`[>]` 버튼을 클릭해 보세요** ➔ 사이드바가 짠! 하고 펼쳐집니다!
6. 좌측 사이드바 메뉴를 더블클릭하면 상단 탭바에 `[사용자 목록 조회] [영업 주문 등록]` 탭이 실시간으로 추가되며 탭 간 자유로운 화면 전환이 가능합니다!

---

* **이전 단계**: [08_ERPMDIChildDemo MDI 자식 창 관리 실습](../08_ERPMDIChildDemo/README.md)
