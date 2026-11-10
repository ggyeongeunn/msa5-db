-- 직원 조회
-- 전체 직원의 사번, 이름, 생년월일, 성별을 조회하시오.
-- 이름을 기준으로 오름차순 정렬하시오.

SELECT
	emp_id
	, 	`name`
	, birth
	, gender
FROM employees
ORDER BY `name`
;

-- 조건 검색
-- 성별이 남성인 직원만 조회하시오.
-- 이름과 입사일을 출력하시오.
SELECT
	`name`
	, hire_at
FROM employees
WHERE gender = 'M'
;

-- 날짜 조건
-- 2020년 1월 1일 이후에 입사한 직원을 조회하시오.
-- 입사일이 빠른 순서대로 정렬하시오.
SELECT
	*
FROM employees
WHERE 
	hire_at >= '2020-01-01'
ORDER BY hire_at 
;

-- 문자열 검색
-- 이름에 '김'이 포함된 직원을 조회하시오.
-- 이름이 3글자인 직원만 조회하시오.
SELECT
	*
FROM employees
WHERE
	`name` LIKE '%김%'
	AND CHAR_LENGTH(`name`) = 3
;

-- 직원 추가
-- 직원 테이블에 새로운 직원을 등록하시오.
-- 사번은 1001, 이름은 홍길동, 성별은 M으로 설정하시오.
-- 나머지 필드는 적절한 테스트 값을 사용하시오.
INSERT INTO employees (
	`name`
	, birth
	, gender
	, hire_at
)
VALUES (
	'홍길동'
	, '2000-01-01'
	, 'M'
	, NOW()
);

-- 직원 정보 수정
-- 사번이 100009인 직원의 이름을 '홍길순'으로 변경하시오.
UPDATE employees
SET
	`name` = '홍길순'
WHERE emp_id = 100009
;

-- 급여 정보 추가
-- 사번이 1001인 직원에게 급여 3,500,000원을 등록하시오.
-- 급여 시작일은 2026년 1월 1일로 설정하시오.
-- title_emps table insert
INSERT INTO title_emps (
	emp_id
	, title_code
	, start_at
	, end_at
	, created_at
	, updated_at
	, deleted_at
)
SELECT 
	emp_id
	, 'T001'
	, NOW()
	, NULL
	, NOW()
	, NOW()
	, NULL
FROM employees
WHERE 
	emp_id = 100009
;

-- salaries table insert
INSERT INTO salaries (
	emp_id
	, salary
	, start_at
	, end_at
	, created_at
	, updated_at
	, deleted_at
)
SELECT 
	emp_id
	, 3500000
	, start_at
	, end_at
	, created_at
	, updated_at
	, deleted_at
FROM title_emps
WHERE 
	emp_id = 100009
;

-- update start_at
UPDATE salaries
SET start_at = '2026-01-01'
WHERE emp_id = 100009
;

SELECT * FROM salaries WHERE emp_id = 100009;
	

-- 데이터 삭제
-- 사번이 1001인 직원의 급여 정보를 삭제하시오.
-- 삭제하기 전에 해당 데이터가 맞는지 SELECT로 확인하시오.

DELETE FROM salaries
WHERE emp_id = 100009
;
SELECT 
	*
FROM salaries
WHERE
	emp_id = 100009
;