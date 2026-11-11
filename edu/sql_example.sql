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



-- <SubQuery GPT 예제 1.>
-- salaries 테이블에서 전체 급여의 평균보다 높은 급여를 받는 사원의 다음 정보를 조회하세요.
-- 사원번호 (emp_id)
-- 급여 (salary)
-- 조건:
-- 전체 급여의 평균을 서브쿼리로 구할 것
-- 퇴사 여부와 관계없이 모든 급여 데이터를 대상으로 할 것
-- 급여가 높은 순서대로 정렬할 것
-- 힌트: AVG(), WHERE, SELECT 내부 서브쿼리

SELECT
	emp_id
	, (
		SELECT 
			AVG(salary)
		FROM salaries
		WHERE
			end_at IS NULL
	) avg_sal
FROM salaries
WHERE 
	avg_sal 
ORDER BY avg_sal DESC
;

SELECT
	AVG(salary)
FROM salaries
WHERE
	end_at IS NULL
;

SELECT
	emp_id
	, salary
FROM salaries
WHERE
	salary >= (
		SELECT
			AVG(salary)
		FROM salaries
		WHERE
			end_at IS NULL
	)
	AND end_at IS NULL 
ORDER BY salary DESC
;

	

-- <SubQuery GPT 예제 2.>
-- salaries 테이블에서 현재 재직 중인 급여 데이터 중 가장 높은 급여를 받는 사원의 정보를 조회하세요.

-- 조회 항목:
-- 사원번호 (emp_id)
-- 급여 (salary)
-- 조건:
-- 현재 급여 데이터는 end_at IS NULL
-- 가장 높은 급여와 동일한 급여를 받는 사원이 여러 명이라면 모두 조회할 것
-- 서브쿼리를 활용할 것
-- 힌트: MAX(), WHERE, 서브쿼리
SELECT
	emp_id
	, salary
FROM salaries
WHERE
	salary = (
		SELECT
			MAX(salary)
		FROM salaries
		WHERE
			end_at IS NULL
	)
;

SELECT
	emp_id
	, salary
FROM salaries
WHERE
	end_at IS NULL
ORDER BY salary DESC
;




-- <SubQuery GPT 예제 3.>
-- 각 부서의 현재 소속 사원들의 평균 급여를 계산하고, 전체 재직 사원의 평균 급여보다 높은 부서만 조회하세요.

-- 조회 항목:
-- 부서명 (departments.dept_name)
-- 부서 코드 (departments.dept_code)
-- 부서별 평균 급여
-- 조건:
-- department_emps 테이블의 현재 소속 정보만 사용
-- salaries 테이블의 현재 급여 정보만 사용
-- 부서별 평균 급여가 전체 재직 사원의 평균 급여보다 높은 부서만 조회
-- 부서별 평균 급여 내림차순 정렬
-- 서브쿼리를 반드시 활용할 것
-- 힌트:
-- JOIN
-- GROUP BY
-- AVG()
-- HAVING
-- 서브쿼리



-- ----------------------------------

-- ----------------------------------
-- select


-- SELECT [DISTINCT] [컬럼명]
-- FROM [테이블명]
-- WHERE [쿼리 조건]
-- GROUP BY [컬럼명] HAVING [집계함수 조건]
-- ORDER BY [컬럼명 ASC || 컬럼명 DESC]
-- LIMIT [n] OFFSET [n]
-- ;

SELECT
	*
FROM employees
WHERE
	fire_at IS NOT NULL
ORDER BY birth ASC
LIMIT 10
;

SELECT
	*
FROM employees
WHERE
	emp_id = 10009
;

SELECT
	*
FROM employees
WHERE
	birth <= '2000-01-01'
	AND birth >= '1990-01-01'
;

SELECT
	*
FROM employees
WHERE
	`name` = '허미라'
	AND birth >= '1980-01-01'
;

SELECT DISTINCT
	`name`
FROM employees
WHERE
	`name` = '허미라'
	OR `name` = '박보람'
;

SELECT
	*
FROM employees
WHERE
	emp_id BETWEEN 1000 AND 1200
;

SELECT
	*
FROM employees
WHERE
	emp_id IN (1000, 1200)
;

SELECT
	*
FROM employees
WHERE
	`name` LIKE '%봄%'
;

SELECT 
	*
FROM employees
WHERE
	`name` LIKE '김_'
;

SELECT
	*
FROM employees
ORDER BY birth, `name` DESC
LIMIT 10
;

SELECT 
	salary
FROM salaries
ORDER BY salary DESC
;









