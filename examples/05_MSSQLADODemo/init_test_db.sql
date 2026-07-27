-- =========================================================
-- Delphi 7 MS-SQL ADO DB 실습용 테스트 SQL 스크립트
-- =========================================================

-- 1. 테스트용 데이터베이스 생성 및 사용 (이미 존재할 경우 생략 가능)
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'TestDB')
BEGIN
    CREATE DATABASE TestDB;
END
GO

USE TestDB;
GO

-- 2. 기존 테스트 테이블이 존재하면 삭제
IF OBJECT_ID('TB_MEMBER', 'U') IS NOT NULL
BEGIN
    DROP TABLE TB_MEMBER;
END
GO

-- 3. 샘플 회원(TB_MEMBER) 테이블 생성
CREATE TABLE TB_MEMBER (
    MEMBER_ID   INT IDENTITY(1,1) NOT NULL PRIMARY KEY, -- 회원 번호 (자동 증가)
    MEMBER_NAME NVARCHAR(50)      NOT NULL,             -- 회원 이름
    EMAIL       VARCHAR(100)      NULL,                 -- 이메일 주소
    AGE         INT               DEFAULT 20,           -- 나이
    REG_DATE    DATETIME          DEFAULT GETDATE()     -- 가입 일시
);
GO

-- 4. 테스트용 샘플 데이터 5건 입력
INSERT INTO TB_MEMBER (MEMBER_NAME, EMAIL, AGE) VALUES (N'홍길동', 'gildong@example.com', 25);
INSERT INTO TB_MEMBER (MEMBER_NAME, EMAIL, AGE) VALUES (N'김철수', 'chulsoo@example.com', 28);
INSERT INTO TB_MEMBER (MEMBER_NAME, EMAIL, AGE) VALUES (N'이영희', 'younghee@example.com', 23);
INSERT INTO TB_MEMBER (MEMBER_NAME, EMAIL, AGE) VALUES (N'박민수', 'minsoo@example.com', 32);
INSERT INTO TB_MEMBER (MEMBER_NAME, EMAIL, AGE) VALUES (N'최지은', 'jieun@example.com', 27);
GO

-- 5. 데이터 정상 입력 확인 조회
SELECT 
    MEMBER_ID   AS [회원번호],
    MEMBER_NAME AS [이름],
    EMAIL       AS [이메일],
    AGE         AS [나이],
    CONVERT(VARCHAR(19), REG_DATE, 120) AS [가입일시]
FROM TB_MEMBER
ORDER BY MEMBER_ID ASC;
GO
