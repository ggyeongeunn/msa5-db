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

SELECT
	*
FROM employees
WHERE
-- 	birth >= '1990-01-01 00:00:00'
	birth >= '1990-01-01'
	AND birth <= '1990-12-31'
-- 	AND birth < '1991-01-01 00:00:00'
;

SELECT
	*
FROM employees
WHERE
	`name` = '박보람'
	OR `name` = '정유리'
;

SELECT
	*
FROM employees
WHERE
	(
		birth >= '1990-12-01' 
		AND birth <= '1990-12-31'
	)
	OR `name` = '정유리'
;

SELECT
	*
FROM employees
WHERE
	birth >= '1990-01-01'
	AND 
	(
		`name` = '정유리'
		OR `name` = '박보람'
	)
;

-- BETWEEN 연산자: 지정한 범위 내의 데이터 조회
-- 예전 버전은 속도가 느림 요즘은 권장
SELECT
	*
FROM employees
WHERE
	birth BETWEEN '1990-01-01' AND '1990-12-31'
;

-- IN 연산자 : 다수의 지정한 값과 일치하는 데이터를 조회
-- or 와 같은 기능
SELECT
	*
FROM employees
WHERE
	`name` IN('박보람', '정유리')
;

SELECT
	*
FROM employees
WHERE
	emp_id IN (10001, 10005, 10006)
;

-- LIKE 절 : 문자열의 내용을 조회
-- 반드시 문자열 데이터 타입에서만 사용 오동작할 가능성 높음
-- text longtext에서 찾을 경우 속도 저하 발생
-- % : 글자 수와 상관없이 조회할 경우 사용
SELECT
	*
FROM employees
WHERE
	`name` LIKE '%우' -- '우'로 끝나는 문자열
-- 	`name` LIKE '우%' -- '우'로 시작하는 문자열
-- 	`name` LIKE '%우%' -- '우'가 포함된 문자열
;

-- _ : 언더바의 개수만큼 글자수를 허용해서 조회
-- fulltextsearch?
SELECT
	*
FROM employees
WHERE
	`name` LIKE '_우%' 
;

-- ORDER BY 절 : 조회한 데이터를 정렬하는 기능
-- ASC가 기본 설정
-- NULL이 제일 먼저 정렬
SELECT
	*
FROM employees
ORDER BY `birth` DESC
;

SELECT
	*
FROM employees
WHERE gender = 'F'
ORDER BY `name`, birth
;

-- LIMIT 키워드, OFFSET 키워드 : 출력의 개수를 제한
SELECT
	*
FROM employees
-- LIMIT 5 OFFSET 10
LIMIT 10, 5
;

SELECT
	*
FROM employees
ORDER BY RAND()
LIMIT 5
;

-- 집계함수
-- SUM(col) : 조회된 해당 컬럼의 모든 값의 합계를 반환하는 함수
SELECT
	SUM(salary) sum_sal -- 별칭 사용
FROM salaries
WHERE
	end_at IS NULL
;
-- MAX(col) : 최대값
SELECT
	MAX(salary) max_sal
FROM salaries
WHERE
	end_at IS NULL
;

-- MIN(col) : 최소값
SELECT
	MIN(salary) min_sal
FROM salaries
WHERE
	end_at IS NULL
;
-- AVG(col) : 평균값
SELECT
	AVG(salary) avg_sal
FROM salaries
WHERE
	end_at IS NULL
;
-- COUNT(col) : 해당 col의 NULL값은 제외하고 조회, col에 *을 넣으면 NULL값의 의미가 없음
SELECT
	COUNT(*) cnt
FROM employees
WHERE
	fire_at IS NULL
;

-- DISTINCT 키워드 : 검색결과에서 중복된 레코드 없이 출력
SELECT DISTINCT
	`name`
FROM employees
ORDER BY `name`
;

-- GROUP BY 절, HAVING 절
-- 그룹으로 묶어서 조회

-- 부서별 사원 수
SELECT
	dept_code
	, COUNT(*) cnt_emps
	-- GROUP BY  절에서 사용한 컬럼과
	-- 집계함수만 작성(SQL 표준 문법)
FROM department_emps
WHERE
	end_at IS NULL
GROUP BY dept_code
;

SELECT
	COUNT(gender) cnt_gd
	, gender
FROM employees
GROUP BY gender
;

SELECT
	title_code
	, COUNT(*) cnt
FROM title_emps
WHERE end_at IS NULL
GROUP BY title_code 
	HAVING cnt >= 10000
;
