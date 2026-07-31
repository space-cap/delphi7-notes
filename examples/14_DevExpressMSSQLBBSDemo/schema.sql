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

