-- =========================================================
-- 델파이 7 실습 프로젝트 전용 마스터 통합 DB 생성 스크립트
-- 통합 데이터베이스 이름: DELPHI7_DB
-- SSMS에서 이 스크립트 하나만 실행하면 모든 실습 예제의 테이블과
-- 대량 샘플 데이터가 1초 만에 일괄 생성됩니다!
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

PRINT '1/3. [게시판 테이블 TB_BOARD] 생성 중...';
-- 1. 기존 게시판 테이블 삭제 후 생성
IF OBJECT_ID('dbo.TB_BOARD', 'U') IS NOT NULL DROP TABLE dbo.TB_BOARD;
GO

CREATE TABLE dbo.TB_BOARD (
    BoardID     INT IDENTITY(1,1) NOT NULL, -- 게시글 고유 번호 (PK)
    Title       NVARCHAR(200) NOT NULL,      -- 글 제목
    Content     NVARCHAR(MAX) NULL,          -- 글 내용
    WriterName  NVARCHAR(50)  NOT NULL,      -- 작성자 이름
    ViewCount   INT DEFAULT 0 NOT NULL,      -- 조회수
    IsNotice    BIT DEFAULT 0 NOT NULL,      -- 공지사항 여부 (1: 공지, 0: 일반)
    RegDate     DATETIME DEFAULT GETDATE() NOT NULL, -- 등록일시
    ModDate     DATETIME NULL,               -- 수정일시
    CONSTRAINT PK_TB_BOARD PRIMARY KEY CLUSTERED (BoardID)
);
GO

-- 2. 1,000건 대량 샘플 데이터 고속 생성
SET NOCOUNT ON;
BEGIN TRANSACTION;

DECLARE @i INT = 1;
DECLARE @Title NVARCHAR(200);
DECLARE @Content NVARCHAR(MAX);
DECLARE @Writer NVARCHAR(50);
DECLARE @IsNotice BIT;
DECLARE @RegDate DATETIME;

WHILE @i <= 1000
BEGIN
    SET @Title = N'페이징 테스트 게시글 제목 ' + RIGHT('0000' + CAST(@i AS VARCHAR(5)), 4) + N'호';
    SET @Content = N'이 게시글은 TcxGrid 페이징 성능 테스트를 위해 자동으로 생성된 샘플 데이터입니다. 글 번호: ' + CAST(@i AS VARCHAR(5));
    SET @Writer = N'작성자_' + CAST((@i % 10) + 1 AS VARCHAR(3));
    
    IF @i % 50 = 0 SET @IsNotice = 1;
    ELSE SET @IsNotice = 0;

    SET @RegDate = DATEADD(MINUTE, -@i * 15, GETDATE());

    INSERT INTO dbo.TB_BOARD (Title, Content, WriterName, ViewCount, IsNotice, RegDate)
    VALUES (@Title, @Content, @Writer, (@i * 7) % 350, @IsNotice, @RegDate);

    SET @i = @i + 1;
END

COMMIT TRANSACTION;
GO

SELECT COUNT(*) AS [TB_BOARD_전체건수] FROM dbo.TB_BOARD;


PRINT '2/3. [수주 마스터/디테일 테이블 TB_ORDER_MASTER / DETAIL] 생성 중...';
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


PRINT '3/3. [매출 전표 마스터/디테일 테이블 TB_SALES_MASTER / DETAIL] 생성 중...';
-- 1. 기존 테이블 삭제
IF OBJECT_ID('dbo.TB_SALES_DETAIL', 'U') IS NOT NULL DROP TABLE dbo.TB_SALES_DETAIL;
IF OBJECT_ID('dbo.TB_SALES_MASTER', 'U') IS NOT NULL DROP TABLE dbo.TB_SALES_MASTER;
GO

-- 2. 매출 전표 마스터 테이블 생성
CREATE TABLE dbo.TB_SALES_MASTER (
    SalesID       INT IDENTITY(1,1) NOT NULL,
    SalesNo       NVARCHAR(20) NOT NULL,
    SalesDate     DATETIME NOT NULL,
    ClientName    NVARCHAR(100) NOT NULL,
    SalesRep      NVARCHAR(50) NOT NULL,
    PaymentStatus NVARCHAR(20) DEFAULT N'미수' NOT NULL,
    TotalPrice    MONEY DEFAULT 0 NOT NULL,
    Remark        NVARCHAR(200) NULL,
    RegDate       DATETIME DEFAULT GETDATE() NOT NULL,
    CONSTRAINT PK_TB_SALES_MASTER PRIMARY KEY CLUSTERED (SalesID)
);
GO

-- 3. 매출 전표 디테일 테이블 생성
CREATE TABLE dbo.TB_SALES_DETAIL (
    DetailID    INT IDENTITY(1,1) NOT NULL,
    SalesID     INT NOT NULL,
    LineNo      INT NOT NULL,
    ItemCode    NVARCHAR(20) NOT NULL,
    ItemName    NVARCHAR(100) NOT NULL,
    Price       MONEY DEFAULT 0 NOT NULL,
    Qty         INT DEFAULT 1 NOT NULL,
    Amount      MONEY DEFAULT 0 NOT NULL,
    CONSTRAINT PK_TB_SALES_DETAIL PRIMARY KEY CLUSTERED (DetailID),
    CONSTRAINT FK_SALES_DETAIL_MASTER FOREIGN KEY (SalesID) REFERENCES dbo.TB_SALES_MASTER(SalesID) ON DELETE CASCADE
);
GO

-- 4. 샘플 데이터 입력 (40건 전표 / 120건 품목)
SET NOCOUNT ON;
BEGIN TRANSACTION;

DECLARE @i INT = 1;
DECLARE @j INT = 1;
DECLARE @SalesID INT;
DECLARE @SalesNo NVARCHAR(20);
DECLARE @SalesDate DATETIME;
DECLARE @Client NVARCHAR(100);
DECLARE @Rep NVARCHAR(50);
DECLARE @Status NVARCHAR(20);
DECLARE @MasterTotal MONEY;

DECLARE @Clients TABLE (ID INT IDENTITY(1,1), Name NVARCHAR(100));
INSERT INTO @Clients (Name) VALUES 
(N'네이버 클라우드'), (N'카카오 엔터프라이즈'), (N'라인플러스'), (N'쿠팡 테크'),
(N'배달의민족 (우아한형제들)'), (N'토스 (비바리퍼블리카)'), (N'당근마켓'), (N'야놀자');

DECLARE @Reps TABLE (ID INT IDENTITY(1,1), Name NVARCHAR(50));
INSERT INTO @Reps (Name) VALUES 
(N'김철수 팀장'), (N'이영희 과장'), (N'박민수 대리'), (N'정수진 주임');

DECLARE @Products TABLE (ID INT IDENTITY(1,1), Code NVARCHAR(20), Name NVARCHAR(100), Price MONEY);
INSERT INTO @Products (Code, Name, Price) VALUES 
(N'IT-SER-01', N'엔터프라이즈 서버 랙', 8500000),
(N'IT-SW-02', N'데이터베이스 L6 라이선스', 3200000),
(N'IT-NET-03', N'기가비트 48포트 스위치', 1450000),
(N'IT-DEV-04', N'개발자용 고성능 모니터 34인치', 780000),
(N'IT-SEC-05', N'방화벽 보안 솔루션 패키지', 4500000);

WHILE @i <= 40
BEGIN
    SET @SalesNo = N'SL-202607-' + RIGHT('000' + CAST(@i AS VARCHAR(5)), 4);
    SET @SalesDate = DATEADD(DAY, -(@i % 30), GETDATE());
    SELECT @Client = Name FROM @Clients WHERE ID = ((@i % 8) + 1);
    SELECT @Rep = Name FROM @Reps WHERE ID = ((@i % 4) + 1);
    
    IF @i % 3 = 0 SET @Status = N'완납';
    ELSE IF @i % 5 = 0 SET @Status = N'부분입금';
    ELSE SET @Status = N'미수';

    INSERT INTO dbo.TB_SALES_MASTER (SalesNo, SalesDate, ClientName, SalesRep, PaymentStatus, TotalPrice, Remark)
    VALUES (@SalesNo, @SalesDate, @Client, @Rep, @Status, 0, N'하반기 라이선스 및 장비 공급건 ' + CAST(@i AS VARCHAR(5)));

    SET @SalesID = SCOPE_IDENTITY();
    SET @MasterTotal = 0;
    SET @j = 1;

    WHILE @j <= ((@i % 3) + 2)
    BEGIN
        DECLARE @Code NVARCHAR(20);
        DECLARE @ProdName NVARCHAR(100);
        DECLARE @UnitPrice MONEY;
        DECLARE @Qty INT;
        DECLARE @Amount MONEY;

        SELECT @Code = Code, @ProdName = Name, @UnitPrice = Price FROM @Products WHERE ID = (((@i + @j) % 5) + 1);
        SET @Qty = (@j * 2) + (@i % 2);
        SET @Amount = @UnitPrice * @Qty;
        SET @MasterTotal = @MasterTotal + @Amount;

        INSERT INTO dbo.TB_SALES_DETAIL (SalesID, LineNo, ItemCode, ItemName, Price, Qty, Amount)
        VALUES (@SalesID, @j, @Code, @ProdName, @UnitPrice, @Qty, @Amount);

        SET @j = @j + 1;
    END

    UPDATE dbo.TB_SALES_MASTER SET TotalPrice = @MasterTotal WHERE SalesID = @SalesID;

    SET @i = @i + 1;
END

COMMIT TRANSACTION;
GO

SELECT COUNT(*) AS [TB_SALES_MASTER_건수] FROM dbo.TB_SALES_MASTER;


PRINT '=== [통합 데이터베이스 DELPHI7_DB 구축 완료!] ===';
