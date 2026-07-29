-- =========================================================
-- 델파이 7 DB 로그인 샘플 테이블 및 데이터 스크립트 (schema.sql)
-- MS SQL Server / SQLite / MySQL / Access 등 호환
-- =========================================================

-- 1. 사용자 테이블 생성 (USERS)
CREATE TABLE USERS (
    User_ID      VARCHAR(50)  NOT NULL PRIMARY KEY,  -- 사용자 아이디
    Password     VARCHAR(100) NOT NULL,              -- 비밀번호 (실무에서는 SHA256 해시 권장)
    User_Name    VARCHAR(50)  NOT NULL,              -- 사용자 이름
    User_Role    VARCHAR(20)  DEFAULT 'USER',        -- 권한 (ADMIN, USER)
    Is_Active    CHAR(1)      DEFAULT 'Y',           -- 계정 활성화 여부 (Y/N)
    Created_At   DATETIME     DEFAULT GETDATE()      -- 계정 생성일
);

-- 2. 테스트용 샘플 계정 데이터 추가
INSERT INTO USERS (User_ID, Password, User_Name, User_Role, Is_Active)
VALUES ('admin', 'admin123!', '관리자', 'ADMIN', 'Y');

INSERT INTO USERS (User_ID, Password, User_Name, User_Role, Is_Active)
VALUES ('user1', 'pass1234', '홍길동 사원', 'USER', 'Y');

INSERT INTO USERS (User_ID, Password, User_Name, User_Role, Is_Active)
VALUES ('guest', '1234', '방문자', 'GUEST', 'N'); -- 비활성 계정 예시

-- 3. 델파이 TADOQuery에서 실행하는 로그인 검증 파라미터화 SQL 쿼리 예시
-- :UserID 와 :Password 는 델파이 ADOQuery의 Parameters로 바인딩됩니다.
--
-- SELECT User_ID, User_Name, User_Role, Is_Active
-- FROM USERS
-- WHERE User_ID = :UserID
--   AND Password = :Password;
