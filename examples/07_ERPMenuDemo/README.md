# 07_ERPMenuDemo ERP 메뉴 구조 실습 가이드 🏢

> 💡 **초초보자 & 신입/인턴 개발자를 위한 한 줄 요약**  
> 수십~수백 개의 메뉴가 들어가는 대규모 ERP 시스템의 핵심인 **메인 메뉴바(`TMainMenu`)**, **좌측 트리 메뉴(`TTreeView`)**, **우클릭 팝업 메뉴(`TPopupMenu`)** 구축 및 연결 실습 예제입니다!

---

## 🎯 이 예제에서 배우는 내용

1. **`TMainMenu`**: 상단 메뉴바 구성 (`시스템 관리`, `영업 관리`, `재고 관리` 등)
2. **`TTreeView`**: 좌측 카테고리별 트리 메뉴 동적 생성 및 더블클릭 이벤트 처리
3. **`TPopupMenu`**: 화면 우클릭 시 `새로고침`, `로그 비우기` 팝업 메뉴 연동
4. **`TStatusBar`**: 화면 최하단 접속자 정보 및 메뉴 동작 상태 표시

---

## 📄 파스칼 주요 소스 코드 해설 (`ERPMenuForm.pas`)

### 1) 좌측 트리뷰 메뉴 동적 생성

```pascal
procedure TFormERPMenu.InitTreeMenu;
var
  NodeSystem, NodeSales, NodeStock: TTreeNode;
begin
  TreeViewMenu.Items.Clear;

  // 1. 대분류 노드 추가
  NodeSystem := TreeViewMenu.Items.Add(nil, '1. 시스템 관리');
  TreeViewMenu.Items.AddChild(NodeSystem, '사용자 관리');
  TreeViewMenu.Items.AddChild(NodeSystem, '권한 설정');

  NodeSales := TreeViewMenu.Items.Add(nil, '2. 영업 관리');
  TreeViewMenu.Items.AddChild(NodeSales, '주문 등록');
  TreeViewMenu.Items.AddChild(NodeSales, '매출 현황');

  // 트리 모두 펼치기
  TreeViewMenu.FullExpand;
end;
```

### 2) 트리 메뉴 더블클릭 시 메뉴 실행 처리

```pascal
procedure TFormERPMenu.TreeViewMenuDblClick(Sender: TObject);
var
  SelectedNode: TTreeNode;
begin
  SelectedNode := TreeViewMenu.Selected;
  // 부모 노드가 있는 소분류 메뉴만 실행!
  if (SelectedNode <> nil) and (SelectedNode.Parent <> nil) then
  begin
    OpenMenu(SelectedNode.Parent.Text + ' > ' + SelectedNode.Text);
  end;
end;
```

---

## 💻 델파이 7 IDE에서 실습하는 방법

1. `examples/07_ERPMenuDemo/` 폴더로 이동합니다.
2. **`ERPMenuDemo.dpr`** 프로젝트 파일을 더블클릭하여 델파이 7 IDE를 엽니다.
3. 키보드의 **`F9`** 키를 눌러 실행합니다.
4. 상단 메뉴바의 메뉴를 클릭하거나, 좌측 트리뷰 메뉴를 더블클릭해 봅니다.
5. 오른쪽 화면에 로그가 찍히며 상태바가 실시간으로 변경되는 것을 확인합니다!

---

* **이전 단계**: [06_ConfigMakerDemo DB config.dat 암호화 생성기](../06_ConfigMakerDemo/README.md)
