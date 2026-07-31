-- =========================================================
-- 통합 DB: DELPHI7_DB
-- =========================================================

USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'DELPHI7_DB')
BEGIN
    CREATE DATABASE [DELPHI7_DB];
    PRINT 'DELPHI7_DB 데이터베이스가 성공적으로 생성되었습니다.';
END
GO

USE [DELPHI7_DB];
GO

-- 1. 기존 테이블 삭제
IF OBJECT_ID('dbo.TB_ORDER_DETAIL', 'U') IS NOT NULL DROP TABLE dbo.TB_ORDER_DETAIL;
IF OBJECT_ID('dbo.TB_ORDER_MASTER', 'U') IS NOT NULL DROP TABLE dbo.TB_ORDER_MASTER;
GO

-- 2. 수주 마스터 테이블 생성
CREATE TABLE dbo.TB_ORDER_MASTER (
    OrderID      INT IDENTITY(1,1) NOT NULL,
    OrderNo      NVARCHAR(20) NOT NULL,
    OrderDate    DATETIME NOT NULL,
    CustomerName NVARCHAR(100) NOT NULL,
    OrderStatus  NVARCHAR(20) DEFAULT N'접수' NOT NULL,
    TotalAmount  MONEY DEFAULT 0 NOT NULL,
    Remark       NVARCHAR(200) NULL,
    RegDate      DATETIME DEFAULT GETDATE() NOT NULL,
    CONSTRAINT PK_TB_ORDER_MASTER PRIMARY KEY CLUSTERED (OrderID)
);
GO

-- 3. 수주 디테일 테이블 생성
CREATE TABLE dbo.TB_ORDER_DETAIL (
    DetailID    INT IDENTITY(1,1) NOT NULL,
    OrderID     INT NOT NULL,
    ItemNo      INT NOT NULL,
    ItemName    NVARCHAR(100) NOT NULL,
    UnitPrice   MONEY DEFAULT 0 NOT NULL,
    Qty         INT DEFAULT 1 NOT NULL,
    SubTotal    MONEY DEFAULT 0 NOT NULL,
    CONSTRAINT PK_TB_ORDER_DETAIL PRIMARY KEY CLUSTERED (DetailID),
    CONSTRAINT FK_ORDER_DETAIL_MASTER FOREIGN KEY (OrderID) REFERENCES dbo.TB_ORDER_MASTER(OrderID) ON DELETE CASCADE
);
GO

-- 4. 샘플 데이터 입력 (50건 수주 / 150건 품목)
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

    UPDATE dbo.TB_ORDER_MASTER SET TotalAmount = @MasterTotal WHERE OrderID = @OrderID;

    SET @i = @i + 1;
END

COMMIT TRANSACTION;
GO

SELECT COUNT(*) AS [TB_ORDER_MASTER_건수] FROM dbo.TB_ORDER_MASTER;

