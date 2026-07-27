# 03. 데이터베이스 컴포넌트 가이드 (Data Access, Data Controls, BDE, ADO 등) 💾

> 💡 **초초보자를 위한 한 줄 요약**  
> 데이터베이스(Oracle, MS-SQL, MySQL 등)에 연결하고, SQL 쿼리를 실행하며, 결과를 화면의 DB 그리드 표에 자동으로 연결해 주는 DB 전용 부품들입니다!

---

## 🟣 1. Data Access & Data Controls 탭 (DB 연동 기본 콤비)

델파이에서 DB 데이터를 화면에 띄우는 구조는 항상 **`[DB 쿼리 컴포넌트]` ➔ `[TDataSource]` ➔ `[TDBGrid 등의 Data Control 컴포넌트]`** 삼각 편대로 동작합니다!

### 1) Data Access 탭 컴포넌트
| 컴포넌트명 | 역할 및 설명 | 주요 프로퍼티(Property) / 팁 |
| :--- | :--- | :--- |
| **`TDataSource`** | **(필수 다리!)** DB 데이터셋(ADOQuery, ClientDataSet 등)과 화면의 DB UI(TDBGrid 등)를 이어주는 중간 연결 고리입니다. | `DataSet` (연결할 Query/Table 객체 지정) |
| **`TClientDataSet`**| 인메모리(RAM) 데이터셋으로 데이터를 로컬에 보관하거나 필터링/정렬할 때 씁니다. (DataSnap이나 Midas 연결 시 필수) | `Data`, `FileName`, `Filter` |
| **`TDataSetProvider`**| 데이터베이스의 DataSet과 로컬 TClientDataSet 사이에서 데이터 패킷을 중계해 줍니다. | `DataSet` |

### 2) Data Controls 탭 컴포넌트 (DB 전용 UI 컨트롤)
| 컴포넌트명 | 역할 및 설명 | 주요 프로퍼티(Property) / 팁 |
| :--- | :--- | :--- |
| **`TDBGrid`** | **(실무 핵심!)** DB 테이블 데이터를 엑셀처럼 실시간으로 보여주고 편집하는 그리드입니다. | `DataSource`, `Columns` |
| **`TDBNavigator`**| DB 레코드를 맨앞, 이전, 다음, 맨끝으로 이동하거나 추가/삭제/저장하는 네비게이션 버튼바입니다. | `DataSource`, `VisibleButtons` |
| **`TDBText`** | DB 컬럼의 값을 화면에 단순 글자로 띄우는 라벨입니다. | `DataSource`, `DataField` (컬럼명) |
| **`TDBEdit`** | DB 컬럼 값과 실시간으로 연동되어 읽고 수정할 수 있는 한 줄 입력 상자입니다. | `DataSource`, `DataField` |
| **`TDBMemo`** | DB 장문(MEMO, CLOB) 컬럼 값을 여러 줄로 보여주고 수정합니다. | `DataSource`, `DataField` |
| **`TDBImage`** | DB에 바이너리(BLOB)로 저장된 이미지 데이터를 읽어서 화면에 그립니다. | `DataSource`, `DataField` |
| **`TDBListBox`** | DB 특정 컬럼 값을 리스트박스 형태로 보여줍니다. | `DataSource`, `DataField` |
| **`TDBComboBox`**| DB 컬럼 값을 드롭다운 선택상자로 연동합니다. | `DataSource`, `DataField` |
| **`TDBCheckBox`**| DB의 'Y'/'N' 또는 1/0 값을 체크박스(V)로 동기화합니다. | `DataSource`, `DataField`, `ValueChecked` |
| **`TDBRadioGroup`**| DB 특정 코드값을 라디오 버튼 그룹으로 동기화합니다. | `DataSource`, `DataField`, `Values` |
| **`TDBLookupComboBox`**| 다른 참조 DB 테이블의 명칭(예: 부서코드 ➔ 부서명)을 찾아서 선택하게 해주는 고급 드롭다운입니다. | `ListSource`, `KeyField`, `ListField` |
| **`TDBRichEdit`**| DB 서식 있는 장문 텍스트(RTF)를 출력하고 편집합니다. | `DataSource`, `DataField` |

---

## 🛢️ 2. ADO 탭 (MS SQL-Server / Access 등 연동 표준)

윈도우 환경에서 가장 광범위하게 쓰이는 OLE DB / ADO 기반 DB 연동 탭입니다.

| 컴포넌트명 | 역할 및 설명 | 주요 프로퍼티(Property) / 팁 |
| :--- | :--- | :--- |
| **`TADOConnection`**| DB 서버와의 물리적 연결(Connection String)을 총괄 관리합니다. | `ConnectionString`, `Connected` (True/False) |
| **`TADOQuery`** | **(실무 최고 자주 씀!)** SQL 문장(`SELECT`, `INSERT`, `UPDATE`)을 실행하여 결과를 받아옵니다. | `Connection`, `SQL` (TStrings), `Open`, `ExecSQL` |
| **`TADOTable`** | SQL문 작성 없이 특정 DB 테이블 전체를 직접 열어 데이터를 다룹니다. | `Connection`, `TableName`, `Active` |
| **`TADOCommand`**| 결과 집합을 반환하지 않는 단발성 명령(저장 프로시저 실행, 단순 UPDATE)을 전송합니다. | `CommandText`, `Execute` |
| **`TADODataSet`** | ADO의 모든 데이터 요청을 커스텀하게 다루는 범용 데이터셋 컴포넌트입니다. | `CommandText`, `CommandType` |
| **`TADOStoredProc`**| DB 서버에 저장되어 있는 저장 프로시저(Stored Procedure)를 호출합니다. | `ProcedureName`, `Parameters` |

---

## 🏛️ 3. BDE 탭 (Borland Database Engine - 레거시)

델파이 초창기에 많이 사용했던 보랜드 전용 DB 엔진 탭입니다. (현재는 ADO나 FireDAC, dbExpress로 이전하는 추세입니다.)

| 컴포넌트명 | 역할 및 설명 |
| :--- | :--- |
| **`TDatabase`** | BDE 방식의 DB 커넥션 및 트랜잭션(`StartTransaction`, `Commit`) 관리자 |
| **`TSession`** | BDE 세션 환경 관리자 |
| **`TTable`** | BDE 방식의 테이블 접근 컴포넌트 |
| **`TQuery`** | BDE 방식의 SQL 쿼리 실행 컴포넌트 |
| **`TStoredProc`**| BDE 방식의 저장 프로시저 실행 컴포넌트 |
| **`TUpdateSQL`** | Query로 가져온 데이터를 직접 수정 후 DB에 반영(`ApplyUpdates`)할 때 쓰는 보조 컴포넌트 |

---

## ⚡ 4. dbExpress, DataSnap, InterBase 탭

* **dbExpress 탭**: 렌더링 속도가 매우 빠른 경량 단방향(Unidirectional) DB 드라이버입니다. (`TSQLConnection`, `TSQLQuery`, `TSQLDataSet` 등)
* **DataSnap 탭**: 3-Tier (클라이언트 - 중계 애플리케이션 서버 - DB) 구조로 다층 네트워크 DB 시스템을 구축할 때 사용합니다. (`TDSocketConnection`, `TWebConnection` 등)
* **InterBase 탭**: 보랜드의 자체 RDBMS인 InterBase/Firebird 전용 연동 컴포넌트입니다. (`TIBDatabase`, `TIBTransaction`, `TIBQuery` 등)

---

* **목차로 돌아가기**: [README.md](README.md)
* **다음 단계**: [04. 네트워크, 웹, 인디(Indy) 통신 가이드](04-network-web-indy.md)
