-- VIEW

CREATE VIEW view_avg_salary_by_dept
AS 
	-- 쿼리 작성
	-- 부서별 현재 연봉 평균
	-- 부서코드, 부서명, 평균연봉 출력
	SELECT 
		depe.dept_code
		, dep.dept_name
		, CEIL(AVG(sal.salary)) avg_sal
	FROM departments dep
		JOIN department_emps depe
			ON dep.dept_code = depe.dept_code
				AND depe.end_at IS NULL
-- 		JOIN employees emp
-- 			ON emp.emp_id = depe.emp_id
-- 			AND emp.fire_at IS NULL
		JOIN salaries sal
			ON depe.emp_id = sal.emp_id
				AND sal.end_at IS NULL
	GROUP BY dep.dept_code, dep.dept_name
	ORDER BY dep.dept_code
;

-- VIEW 조회
SELECT
	*
FROM view_avg_salary_by_dept
;

-- VIEW 삭제
DROP VIEW view_avg_salary_by_dept;

