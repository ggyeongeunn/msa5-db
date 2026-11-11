-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT
	emp.emp_id
	, emp.`name`
	, tit.title_code
FROM employees emp
	JOIN title_emps tit
		ON emp.emp_id = tit.emp_id
			AND emp.fire_at IS NULL
			AND tit.end_at IS NULL
;


-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	, emp.gender
	, sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND emp.fire_at IS NULL
			AND sal.end_at IS NULL
;

-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
SELECT
	emp.`name`
	, sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND emp.emp_id = 10010
;

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT
	emp.emp_id
	, emp.`name`
	, dep.dept_name
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
		AND depe.end_at IS NULL 
		AND emp.fire_at IS NULL
	JOIN departments dep
		ON dep.dept_code = depe.dept_code
;


-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	, emp.`name`
	, sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
		AND sal.end_at IS NULL
		AND emp.fire_at IS NULL
ORDER BY sal.salary DESC
LIMIT 10
;
-- 속도 개선 버전 (공간 복잡도는 증가할 수 있음)
SELECT
	emp.emp_id
	, emp.`name`
	, tmp_sal.salary
FROM employees emp
	JOIN (
		SELECT
			sal.emp_id
			, sal.salary
		FROM salaries sal
		where
			sal.end_at IS NULL 
		ORDER BY sal.salary DESC
		LIMIT 10
	) tmp_sal
		ON emp.emp_id = tmp_sal.emp_id
			AND emp.fire_at IS NULL
ORDER BY tmp_sal.salary DESC
;


-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT
	dep.dept_name
	, emp.`name`
	, emp.hire_at
FROM employees emp
	JOIN department_managers depm
		ON emp.emp_id = depm.emp_id
			AND depm.end_at IS NULL
			AND emp.fire_at IS NULL
	JOIN departments dep
		ON dep.dept_code = depm.dept_code
			AND dep.end_at IS NULL
;
-- SELECT * FROM department_managers WHERE end_at IS NULL;

-- 7. 현재 직급이 "부장"인 사원들의 각각 연봉 평균을 출력해 주세요.
-- SELECT
-- 	sal.emp_id
-- 	, sal.salary
-- FROM title_emps tite
-- 	JOIN titles tit
-- 		ON tite.title_code = tit.title_code
-- 		AND tit.title = '부장'
-- 	JOIN salaries sal
-- 		ON sal.emp_id = tite.emp_id
-- ;
-- 
-- SELECT
-- 	sal.emp_id
-- 	, 
-- FROM title_emps tite
-- 	JOIN titles tit
-- 		ON tite.title_code = tit.title_code
-- 			AND tit.title = '부장'
-- 			AND tite.end_at IS NULL
-- 	JOIN salaries sal
-- 		ON sal.emp_id = tite.emp_id
-- 		
-- ;
SELECT
	sal.emp_id
	, TRUNCATE(AVG(sal.salary),0) avg_sal
FROM salaries sal
	JOIN title_emps tite
		ON tite.emp_id = sal.emp_id
	JOIN titles tit
		ON tit.title_code = tite.title_code
			AND tit.title = '부장'
			AND tite.end_at IS NULL
GROUP BY sal.emp_id
ORDER BY sal.emp_id
;

-- 7-1. (보너스)현재 각 부장별 이름, 연봉평균
SELECT
	emp.emp_id
	, emp.`name`
	, TRUNCATE(AVG(sal.salary),0) avg_sal
FROM title_emps tite
	JOIN titles tit
		ON tite.title_code = tit.title_code
			AND tite.end_at IS NULL
			AND tit.title = '부장'
	JOIN salaries sal
		ON sal.emp_id = tite.emp_id
	JOIN employees emp
		ON sal.emp_id = emp.emp_id
			AND emp.fire_at IS NULL
GROUP BY sal.emp_id
ORDER BY sal.emp_id
;


-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
SELECT
	emp.`name`
	, emp.hire_at
	, emp.emp_id
	, depm.dept_code
FROM employees emp
	JOIN department_managers depm
		ON emp.emp_id = depm.emp_id
		AND emp.fire_at IS NULL
;


-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 
-- 직급명, 평균연봉(정수)를을 평균연봉 내림차순으로 출력해 주세요.

SELECT
	tit.title
	, TRUNCATE(AVG(sal.salary),0) avg_sal
FROM salaries sal
	JOIN title_emps tite
		ON sal.emp_id = tite.emp_id
			AND sal.end_at IS NULL
			AND tite.end_at IS NULL
	JOIN titles tit
		ON tite.title_code = tit.title_code
GROUP BY tit.title HAVING AVG(sal.salary) >= 60000000
ORDER BY avg_sal DESC
;
-- 통계성 집계는 속도가 오래 걸리는 경우가 많음
-- 필터링이 따로 없으면 개선할 방법이 스키마? 단계에서 적용?


-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT
	tite.title_code
	, COUNT(tite.emp_id) cnt_tit -- pk를 쓰는게 안정적
FROM employees emp
	JOIN title_emps tite
		ON emp.emp_id = tite.emp_id
			AND emp.fire_at IS NULL
			AND tite.end_at IS NULL
			AND emp.gender = 'F'
GROUP BY tite.title_code
ORDER BY tite.title_code
;

-- ------------------------------
-- 전체 평균 급여보다 높은 급여를 받는 사원의 
-- 사번, 이름, 현재급여를 조회
SELECT 
	emp.emp_id
	, emp.`name`
	, sal.salary
FROM salaries sal
	JOIN employees emp
		ON sal.emp_id = emp.emp_id
			AND sal.end_at IS null
			AND sal.salary >= (
				SELECT
					AVG(sal.salary)
				FROM salaries sal
			)
;

SELECT
	AVG(salary)
FROM salaries;


-- 가장 높은 급여를 받은 이력이있는 사원의 사번과 급여를 조회
SELECT
	salary
	, emp_id
FROM salaries
ORDER BY salary DESC
LIMIT 1
;