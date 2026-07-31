-- =========================================================
-- DevExpress TcxGrid 상하 분할(Split-Panel) 마스터-디테일 실습 DB 스크립트
-- Target DB: Microsoft SQL Server 2000 / 2005 / 2008 / 2012+
-- =========================================================

USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'SALESDB')
BEGIN
    CREATE DATABASE [SALESDB];
    PRINT 'SALESDB 데이터베이스가 성공적으로 생성되었습니다.';
END
GO

USE [SALESDB];
GO

-- 1. 기존 테이블 삭제
IF OBJECT_ID('dbo.TB_SALES_DETAIL', 'U') IS NOT NULL DROP TABLE dbo.TB_SALES_DETAIL;
IF OBJECT_ID('dbo.TB_SALES_MASTER', 'U') IS NOT NULL DROP TABLE dbo.TB_SALES_MASTER;
GO

-- 2. 매출 전표 마스터 테이블 생성 (TB_SALES_MASTER)
CREATE TABLE dbo.TB_SALES_MASTER (
    SalesID       INT IDENTITY(1,1) NOT NULL,  -- 매출 고유번호 (PK)
    SalesNo       NVARCHAR(20) NOT NULL,        -- 매출 전표번호 (예: SL-202607-0001)
    SalesDate     DATETIME NOT NULL,            -- 매출 일자
    ClientName    NVARCHAR(100) NOT NULL,       -- 거래처명
    SalesRep      NVARCHAR(50) NOT NULL,        -- 담당 영업사원
    PaymentStatus NVARCHAR(20) DEFAULT N'미수' NOT NULL, -- 결제 상태 (완납, 미수, 부분입금)
    TotalPrice    MONEY DEFAULT 0 NOT NULL,     -- 총 매출금액
    Remark        NVARCHAR(200) NULL,           -- 적요 / 메모
    RegDate       DATETIME DEFAULT GETDATE() NOT NULL,
    CONSTRAINT PK_TB_SALES_MASTER PRIMARY KEY CLUSTERED (SalesID)
);
GO

-- 3. 매출 전표 디테일 (품목) 테이블 생성 (TB_SALES_DETAIL)
CREATE TABLE dbo.TB_SALES_DETAIL (
    DetailID    INT IDENTITY(1,1) NOT NULL,   -- 상세 고유번호 (PK)
    SalesID     INT NOT NULL,                 -- 마스터 매출번호 (FK)
    LineNo      INT NOT NULL,                 -- 품목 라인번호 (1, 2, 3...)
    ItemCode    NVARCHAR(20) NOT NULL,        -- 품목 코드
    ItemName    NVARCHAR(100) NOT NULL,       -- 품목명
    Price       MONEY DEFAULT 0 NOT NULL,     -- 단가
    Qty         INT DEFAULT 1 NOT NULL,       -- 수량
    Amount      MONEY DEFAULT 0 NOT NULL,     -- 공급가액
    CONSTRAINT PK_TB_SALES_DETAIL PRIMARY KEY CLUSTERED (DetailID),
    CONSTRAINT FK_SALES_DETAIL_MASTER FOREIGN KEY (SalesID) REFERENCES dbo.TB_SALES_MASTER(SalesID) ON DELETE CASCADE
);
GO

-- 4. 샘플 데이터 대량 입력 (40건 전표 / 120건 품목)
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

SELECT TOP 10 * FROM dbo.TB_SALES_MASTER ORDER BY SalesID DESC;
SELECT TOP 20 * FROM dbo.TB_SALES_DETAIL ORDER BY DetailID DESC;
GO
