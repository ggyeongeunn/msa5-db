-- 01 모든 사원 정보 조회하기
SELECT
	*
FROM employees
;

-- 02	사원의 이름과 입사일만 조회하기
SELECT
	`name`
	, hire_at
FROM employees
;

-- 03	부서 정보 전체 조회하기
SELECT
	*
FROM departments
;

-- 04	사번이 1003인 사원 조회하기
SELECT
	*
FROM employees
WHERE emp_id = 1003
;

-- 05	성별이 여성인 사원 조회하기
SELECT
	*
FROM employees
WHERE gender = 'F'
;

-- 06	2020년 이후 입사한 사원 조회하기
SELECT
	*
FROM employees
WHERE hire_at > '2019-12-31'
ORDER BY hire_at
;

-- 07	급여가 400만 원 이상인 사원 조회하기
SELECT
	*
FROM salaries
WHERE salary / 12 >= 4000000
	AND end_at IS NULL
ORDER BY salary
;

-- 08	사원 정보를 입사일 기준 오름차순으로 정렬하기
SELECT
	*
FROM employees
ORDER BY hire_at
;

-- 09	급여가 높은 사원 3명 조회하기
SELECT
	*
FROM salaries
ORDER BY salary DESC
LIMIT 3
;
	
-- 10	새로운 부서 추가하기
START TRANSACTION;
INSERT INTO departments (
	dept_code
	, dept_name
	, start_at
	, end_at
	, created_at
	, updated_at
	, deleted_at
)
VALUES (
	'D010'
	, '신규부'
	, NOW()
	, NULL
	, NOW()
	, NOW()
	, null
);
ROLLBACK;
SELECT * FROM departments;

-- 11	사원 1002의 급여를 380만 원으로 변경하기
START TRANSACTION;
UPDATE salaries
SET 
	salary = 3800000 * 12
	, updated_at = NOW()
WHERE emp_id = 1002
	AND end_at IS NULL
;
SELECT * FROM salaries WHERE emp_id = 1002 AND end_at IS NULL;
ROLLBACK;

-- 12	사원 1004의 퇴사일 입력하기
START TRANSACTION;
UPDATE employees
SET 
	fire_at = NOW()
WHERE emp_id = 1004
;
SELECT * FROM employees WHERE emp_id = 1004;
ROLLBACK;

-- 13	특정 부서 정보 삭제하기
START TRANSACTION;
DELETE FROM departments
WHERE dept_name = '회계부'
;
SELECT * FROM departments;	
SELECT * FROM department_emps WHERE dept_code = 'D007';
ROLLBACK;

-- 14	전체 사원 수 구하기

-- 15	사원들의 평균 급여 구하기
-- 16	가장 높은 급여와 가장 낮은 급여 구하기
-- 17	전체 급여 합계 구하기
-- 18	사원 이름을 모두 대문자로 조회하기
-- 19	사원 이름의 글자 수 조회하기
-- 20	사원의 입사 연도만 조회하기
-- 21	현재 날짜 기준으로 입사 연차 계산하기
-- 22	급여를 천 단위로 반올림하여 조회하기
-- 23	사원 이름과 급여를 하나의 문자열로 합치기
-- 24	이름이 '김'으로 시작하는 사원 조회하기
-- 25	퇴사일이 NULL인 재직자 조회하기
-- 26 사원들의 평균 급여를 구하되 소수점 없이 출력하기
-- 27 입사일을 YYYY년 MM월 DD일 형식으로 출력하기
-- 28 사원의 이름과 입사일, 입사한 지 며칠이 지났는지 함께 조회하기
-- 29	성별별 사원 수 구하기
-- 30	부서별 사원 수 구하기
-- 31	부서별 평균 급여 구하기
-- 32	직급별 사원 수 구하기
-- 33	평균 급여가 400만 원 이상인 그룹만 조회하기
-- 34	사원 수가 1명 이상인 부서만 조회하기
-- 35	부서별 급여 합계를 높은 순서로 정렬하기
-- 36	전체 사원의 평균 급여보다 높은 급여를 받는 사원 조회하기
-- 37	가장 높은 급여를 받는 사원 조회하기
-- 38	김철수와 같은 부서에 속한 사원 조회하기
-- 39	개발팀에 소속된 사원 조회하기
-- 40	부서 평균 급여보다 높은 급여를 받는 사원 조회하기	상관
-- 41	한 명이라도 소속된 부서 조회하기	
-- 42	사원들의 급여 중 최저 급여보다 높은 급여를 받는 사원 조회하기
-- 43	부서별 평균 급여보다 높은 급여를 받는 사원 조회하기
-- 44	사원의 이름과 소속 부서명 조회하기	
-- 45	사원의 이름과 직급명 조회하기	
-- 46	사원의 이름과 급여 조회하기
-- 47	사원의 이름, 부서명, 직급명 조회하기
-- 48	각 부서의 관리자 이름과 부서명 조회하기
-- 49	사원의 이름과 직속 상사 이름 조회하기
-- 50	모든 부서와 소속 사원 조회하기
-- 51	소속 사원이 없는 부서까지 모두 조회하기
-- 52	모든 사원과 급여 정보를 조회하되 급여가 없는 사원도 포함하기
-- 53	개발팀에 소속된 사원들의 이름과 급여 조회하기	
-- 54	부서별 평균 급여와 부서명 함께 조회하기
-- 55	전체 평균 급여보다 높은 급여를 받는 사원의 이름과 부서명 조회하기	
-- 56	부서별 사원 수와 평균 급여를 함께 조회하기
-- 57	각 부서의 관리자 이름과 해당 부서의 사원 수 조회하기
-- 58	직급별 평균 급여가 가장 높은 직급 조회하기
-- 59	상사가 존재하는 사원의 이름과 상사 이름 조회하기
-- 60	각 부서에서 평균 급여보다 높은 급여를 받는 사원 조회하기	
-- 61	부서별 최고 급여를 받는 사원의 이름과 급여 조회하기	
-- 62	사원별 이름, 부서명, 직급명, 급여를 한 번에 조회하기



























