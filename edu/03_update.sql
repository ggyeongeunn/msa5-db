-- UPDATE문
-- DML 중 하나로 저장되어 있는 기존 데이터를
-- 수정하기 위해 사용하는 쿼리
-- UPDATE 테이블명
-- SET
-- 	컬럼1 = 값1
-- 	[, 컬럼2 = 값2...]
-- [WHERE절] : 안주면 전체 갱신(생략 가능)
UPDATE employees
SET
	`name` = '미어캣'
	, gender = 'M'
WHERE 
	emp_id = 100005
;

UPDATE employees
SET
	`name` = '마이콜'
	, birth = '2020-01-01'
WHERE
	emp_id = 100005
;