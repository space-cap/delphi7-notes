-- =========================================================
-- 델파이 7 + DevExpress TcxGrid 게시판(BBS) 실습 DB 및 테이블 생성 스크립트
-- Target DB: Microsoft SQL Server 2000 / 2005 / 2008 / 2012+
-- =========================================================

-- 1. 데이터베이스(BBSDB) 생성 (존재하지 않는 경우 신규 생성)
USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'BBSDB')
BEGIN
    CREATE DATABASE [BBSDB];
    PRINT 'BBSDB 데이터베이스가 성공적으로 생성되었습니다.';
END
GO

-- 2. 생성된 BBSDB 데이터베이스 선택
USE [BBSDB];
GO

-- 3. 기존 TB_BOARD 테이블이 존재하는 경우 삭제 후 재생성
IF OBJECT_ID('dbo.TB_BOARD', 'U') IS NOT NULL
    DROP TABLE dbo.TB_BOARD;
GO

-- 4. 게시판(TB_BOARD) 테이블 생성
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

-- 5. 1,000건 대량 샘플 데이터 고속 생성 (트랜잭션 활용)
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
    
    -- 50번째 글마다 공지사항(IsNotice = 1) 설정
    IF @i % 50 = 0
        SET @IsNotice = 1;
    ELSE
        SET @IsNotice = 0;

    -- 과거 시간으로 등록일시 고르게 분배 (15분 간격)
    SET @RegDate = DATEADD(MINUTE, -@i * 15, GETDATE());

    INSERT INTO dbo.TB_BOARD (Title, Content, WriterName, ViewCount, IsNotice, RegDate)
    VALUES (@Title, @Content, @Writer, (@i * 7) % 350, @IsNotice, @RegDate);

    SET @i = @i + 1;
END

COMMIT TRANSACTION;
GO

-- 6. 데이터 생성 건수 및 샘플 목록 확인
SELECT COUNT(*) AS [총데이터건수] FROM dbo.TB_BOARD;
SELECT TOP 20 * FROM dbo.TB_BOARD ORDER BY IsNotice DESC, BoardID DESC;
GO
