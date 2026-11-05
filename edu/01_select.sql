-- SELECT 문
-- DML 중 하나로, 저장되어 있는 데이터를 
-- 조회하기 위해 사용하는 쿼리
-- SELECT절 : 조회하는 데이터 중 특정 컬럼만 출력
-- 예약어로 쓰이는 컬럼명은 백틱(`)으로 감싸면 컬럼으로 인식됨
SELECT 
	emp_id
	, `name`
	, gender
FROM employees	-- 테이블 지정
;

-- Asterrisk (*) : 모든 컬럼 조회, 사용 지양
SELECT
	*
FROM employees
;

-- WHERE 절 : 특정 컬럼의 값이 조건에 맞는 데이터만 조회 (filering)
SELECT 
	*
FROM employees
WHERE
	emp_id = 10009
;

SELECT
	*
FROM employees emp
WHERE
	`name` = '박보람'
;

SELECT
	*
FROM employees
WHERE
	birth >= '2000-01-01'
;

SELECT
	*
FROM employees
WHERE `name` LIKE '%보람'
;

SELECT
	*
FROM employees
WHERE MONTH(birth) = MONTH(CURDATE())
AND DAY(birth) = DAY(CURDATE())
;

SELECT
	*
FROM employees
WHERE 
-- 	fire_at IS NOT NULL	
fire_at IS NULL
;