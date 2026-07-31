-- =========================================================
-- DevExpress TcxGrid 주문 마스터-디테일(Master-Detail) 실습 DB 스크립트
-- Target DB: Microsoft SQL Server 2000 / 2005 / 2008 / 2012+
-- =========================================================

USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'ORDERDB')
BEGIN
    CREATE DATABASE [ORDERDB];
    PRINT 'ORDERDB 데이터베이스가 성공적으로 생성되었습니다.';
END
GO

USE [ORDERDB];
GO

-- 1. 기존 테이블 삭제
IF OBJECT_ID('dbo.TB_ORDER_DETAIL', 'U') IS NOT NULL DROP TABLE dbo.TB_ORDER_DETAIL;
IF OBJECT_ID('dbo.TB_ORDER_MASTER', 'U') IS NOT NULL DROP TABLE dbo.TB_ORDER_MASTER;
GO

-- 2. 주문 마스터 테이블 생성 (TB_ORDER_MASTER)
CREATE TABLE dbo.TB_ORDER_MASTER (
    OrderID      INT IDENTITY(1,1) NOT NULL, -- 주문 고유번호 (PK)
    OrderNo      NVARCHAR(20) NOT NULL,       -- 주문 번호 (예: ORD-202607-0001)
    OrderDate    DATETIME NOT NULL,           -- 주문 일자
    CustomerName NVARCHAR(100) NOT NULL,      -- 고객사 / 거래처명
    OrderStatus  NVARCHAR(20) DEFAULT N'접수' NOT NULL, -- 상태 (접수, 진행중, 완료, 취소)
    TotalAmount  MONEY DEFAULT 0 NOT NULL,    -- 총 주문 금액
    Remark       NVARCHAR(200) NULL,          -- 비고 / 메모
    RegDate      DATETIME DEFAULT GETDATE() NOT NULL,
    CONSTRAINT PK_TB_ORDER_MASTER PRIMARY KEY CLUSTERED (OrderID)
);
GO

-- 3. 주문 디테일 (품목) 테이블 생성 (TB_ORDER_DETAIL)
CREATE TABLE dbo.TB_ORDER_DETAIL (
    DetailID    INT IDENTITY(1,1) NOT NULL,  -- 디테일 고유번호 (PK)
    OrderID     INT NOT NULL,                -- 마스터 주문번호 (FK)
    ItemNo      INT NOT NULL,                -- 품목 순번 (1, 2, 3...)
    ItemName    NVARCHAR(100) NOT NULL,       -- 품목명 / 상품명
    UnitPrice   MONEY DEFAULT 0 NOT NULL,     -- 단가
    Qty         INT DEFAULT 1 NOT NULL,       -- 수량
    SubTotal    MONEY DEFAULT 0 NOT NULL,     -- 공급가액 (단가 * 수량)
    CONSTRAINT PK_TB_ORDER_DETAIL PRIMARY KEY CLUSTERED (DetailID),
    CONSTRAINT FK_ORDER_DETAIL_MASTER FOREIGN KEY (OrderID) REFERENCES dbo.TB_ORDER_MASTER(OrderID) ON DELETE CASCADE
);
GO

-- 4. 마스터 및 디테일 샘플 데이터 입력
SET NOCOUNT ON;
BEGIN TRANSACTION;

DECLARE @i INT = 1;
DECLARE @j INT = 1;
DECLARE @OrderID INT;
DECLARE @OrderNo NVARCHAR(20);
DECLARE @OrderDate DATETIME;
DECLARE @Customer NVARCHAR(100);
DECLARE @Status NVARCHAR(20);
DECLARE @MasterTotal MONEY;

DECLARE @Customers TABLE (ID INT IDENTITY(1,1), Name NVARCHAR(100));
INSERT INTO @Customers (Name) VALUES 
(N'(주)삼성전자'), (N'(주)LG전자'), (N'SK하이닉스(주)'), (N'현대자동차(주)'),
(N'포스코홀딩스(주)'), (N'(주)한화'), (N'네이버(주)'), (N'(주)카카오');

DECLARE @Products TABLE (ID INT IDENTITY(1,1), Name NVARCHAR(100), Price MONEY);
INSERT INTO @Products (Name, Price) VALUES 
(N'27인치 4K 모니터', 450000), (N'무선 기계식 키보드', 120000), (N'인공지능 마우스', 85000),
(N'USB-C 멀티 허브', 45000), (N'스마트 워크스테이션 PC', 2100000), (N'노이즈캔슬링 헤드셋', 280000);

WHILE @i <= 50
BEGIN
    SET @OrderNo = N'ORD-202607-' + RIGHT('000' + CAST(@i AS VARCHAR(5)), 4);
    SET @OrderDate = DATEADD(DAY, -(@i % 30), GETDATE());
    SELECT @Customer = Name FROM @Customers WHERE ID = ((@i % 8) + 1);
    
    IF @i % 4 = 0 SET @Status = N'완료';
    ELSE IF @i % 3 = 0 SET @Status = N'진행중';
    ELSE IF @i % 7 = 0 SET @Status = N'취소';
    ELSE SET @Status = N'접수';

    INSERT INTO dbo.TB_ORDER_MASTER (OrderNo, OrderDate, CustomerName, OrderStatus, TotalAmount, Remark)
    VALUES (@OrderNo, @OrderDate, @Customer, @Status, 0, N'상반기 정기 구매건 ' + CAST(@i AS VARCHAR(5)));

    SET @OrderID = SCOPE_IDENTITY();
    SET @MasterTotal = 0;
    SET @j = 1;

    -- 주문 품목 2~4개 생성
    WHILE @j <= ((@i % 3) + 2)
    BEGIN
        DECLARE @ProdName NVARCHAR(100);
        DECLARE @UnitPrice MONEY;
        DECLARE @Qty INT;
        DECLARE @SubTotal MONEY;

        SELECT @ProdName = Name, @UnitPrice = Price FROM @Products WHERE ID = (((@i + @j) % 6) + 1);
        SET @Qty = (@j * 2) + (@i % 3);
        SET @SubTotal = @UnitPrice * @Qty;
        SET @MasterTotal = @MasterTotal + @SubTotal;

        INSERT INTO dbo.TB_ORDER_DETAIL (OrderID, ItemNo, ItemName, UnitPrice, Qty, SubTotal)
        VALUES (@OrderID, @j, @ProdName, @UnitPrice, @Qty, @SubTotal);

        SET @j = @j + 1;
    END

    -- 마스터 총 금액 업데이트
    UPDATE dbo.TB_ORDER_MASTER SET TotalAmount = @MasterTotal WHERE OrderID = @OrderID;

    SET @i = @i + 1;
END

COMMIT TRANSACTION;
GO

-- 5. 생성 검증 조회
SELECT TOP 10 * FROM dbo.TB_ORDER_MASTER ORDER BY OrderID DESC;
SELECT TOP 20 * FROM dbo.TB_ORDER_DETAIL ORDER BY DetailID DESC;
GO
