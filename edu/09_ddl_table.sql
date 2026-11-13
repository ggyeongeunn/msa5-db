-- -----------------------------------
-- 개념적 설계
-- 테이블과 필요한 속성(컬럼)들이 무엇일까?
-- -----------------------------------
-- 유저 테이블
-- pk, 생년월일, 전화번호, 성별, 이름, 프로필, 주소, 이메일, 아이디, 비밀번호, 나이...(개념적 설계)
-- 가입일, 탈퇴일, 작성일, 수정일, 삭제일 ...
-- provider ex) KAKAO, NAVER, GOOGLE, ...

-- 게시글 테이블
-- pk, 제목, 본문, 이미지, 작성일, 작성자, 게시글 삭제일, 북마크, 수정일, 삭제일(레코드)
-- PK, 제목, 본문, 이미지, 작성자, 게시글 삭제일, 작성일, 수정일, 삭제일


-- 테이블 분리
-- 복수 디바이스 : provider(연동 계정)
-- 댓글 대댓글 관련
-- 복수 이미지일 경우 이미지
-- 좋아요
-- 공유(프론트에서 관리 가능)

-- -----------------------------------
-- 논리적 설계
-- ERD 제작(ERD Cloud)
-- -----------------------------------

-- -----------------------------------
-- 물리적 설계
-- 스키마(테이블) 만들어나가기
-- -----------------------------------

-- DB 생성
CREATE DATABASE test;
USE test;

-- Table 생성
-- 유저 테이블
-- TABLE위치 : table function index view 올 수 있음
CREATE TABLE users (
	id					BIGINT 			PRIMARY KEY AUTO_INCREMENT -- pk 부여해주면 unique, not null이 자동으로 설정됨
--	, email 	VARCHAR(100) NOT NULL UNIQUE
	, email 			VARCHAR(100) 	NOT NULL 
	, user_name 	VARCHAR(30) 	NOT NULL
	, `password` 	VARCHAR(255) 	NOT NULL
	, birth 			DATE 				NOT NULL
	, phone 			CHAR(13) 		NOT NULL COMMENT '\'010-0000-0000\', 하이픈 포함 13 자리' -- escape문 문자열 인식(자주 사용됨)
	, gender 		CHAR(1)			NOT NULL COMMENT '\'M\', \'F\''
	, add_number 	CHAR(5)
	, addr1 			VARCHAR(50) 
	, addr2 			VARCHAR(50)
	, `profile` 	VARCHAR(100)
	, hired_at 		DATE 				NOT NULL DEFAULT (CURRENT_DATE())
	-- now() : 해당 스키마 생성 당시의 시간이 기본값 
	-- currunt_timestamp() : insert 하는 시점의 시간이 기본값
	, withdrwan_at DATE 				DEFAULT NULL
	, created_at 	DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP()
	, updated_at 	DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP()
	, deleted_at 	DATETIME 		DEFAULT NULL
	
	-- CONSTRAINT 키워드로 이름을 별도로 지정
	-- 제약조건 / 제약조건의 의름 / 성격 / 컬럼명
	, CONSTRAINT uk_users_email  UNIQUE (email) -- constraint(제약조건) 이름 직접 지정	
);

CREATE TABLE posts (
	id					BIGINT 			PRIMARY KEY AUTO_INCREMENT
	, user_id 		BIGINT 			NOT NULL
	, title 			VARCHAR(100) 	NOT NULL
	, content 		VARCHAR(500) 
	, image 			VARCHAR(100) 	NOT NULL
	, deactived_at DATE		 		DEFAULT NULL
	, created_at 	DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP()
	, updated_at 	DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP()
	, deleted_at 	DATETIME 		DEFAULT NULL
	
-- 	, CONSTRAINT fk_posts_user_id  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- ------------------------
-- 스키마(테이블) 수정
-- ------------------------
-- ALTER TABLE [table name] ADD CLOUMN [column name] [data type] [constraint] [after column name]
-- 컬럼 추가
ALTER TABLE users
ADD COLUMN birth_month CHAR(2) NOT NULL COMMENT '\'MM\' 양식';

-- 컬럼 수정
ALTER TABLE users
MODIFY COLUMN birth_month CHAR(2) COMMENT '\'MM\' 양식';

-- 컬럼 삭제
ALTER TABLE users
DROP COLUMN birth_month;

-- posts 테이블에 fk 제약조건 추가
-- add : 추가
ALTER TABLE posts 
ADD CONSTRAINT fk_posts_user_id
FOREIGN KEY (user_id) REFERENCES users(id); -- fk는 index를 자동적으로 생성

-- posts 테이블에 fk 제약조건 제거
ALTER TABLE posts 
DROP CONSTRAINT fk_posts_user_id;

ALTER TABLE posts
DROP INDEX fk_posts_user_id;


-- ------------------------
-- AUTO_INCREMENT 값 변경
-- ------------------------
ALTER TABLE users AUTO_INCREMENT = 1;

-- ------------------------
-- TRUNCATE 문 : 테이블의 모든 데이터를 깨끗하게 제거하는 문법
-- ------------------------
TRUNCATE TABLE users;

-- ------------------------
-- 스키마(테이블) 삭제
-- ------------------------
DROP TABLE posts, users;




