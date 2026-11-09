-- 내장 함수 (Function)

-- -----------------------
-- 데이터 타입 변환 함수
-- -----------------------
SELECT 
	1234 num
	, CAST(1234 AS CHAR(6)) as cast_fnc
	, CONVERT(1234, CHAR(6)) as convert_fnc
;

SELECT
	CONVERT(emp_id, CHAR(30))
FROM employees
WHERE
	emp_id = 100005
;

-- -----------------------
-- 제어 흐름 함수
-- -----------------------
-- IF(수식, 참일 경우의 값, 거짓일 경우의 값)
SELECT
	`name`
	, gender
	, IF(gender = 'M', '남자', '여자') ko_gender
FROM employees
;

-- IFNULL(수식1, 수식2)
-- 수식1이 null이면 수식2를 반환, 아니면 수식1을 반환
SELECT
	IFNULL(fire_at, '재직중') fire_chk
	, fire_at
FROM employees
;

-- NULLIF(수식1, 수식2)
-- 수식1과 수식2를 비교해서 같으면 NULL을 반환
-- 다르면 수식1을 반환
SELECT
	NULLIF(gender, 'M') gender_chk
FROM employees
;

-- CASE ~ WHEN ~ ELSE ~ END
SELECT
	CASE gender
		WHEN 'M' THEN '남자'
		WHEN 'F' THEN '여자'
		ELSE '기타'
	END	ko_gender
FROM employees
;

-- -----------------------
-- 문자열 함수
-- -----------------------
-- 문자열 연결
SELECT CONCAT('안녕', ' ', '하세요.') say_hello;
SELECT CONCAT(`name`, ' ' , gender) nm_gd FROM employees;

-- 구분자로 문자열을 연결
SELECT CONCAT_WS(' & ', '자바', 'JS', 'HTML') text_ws;

-- 숫자에 자릿수(,) 및 소수점 자리수 표시
SELECT FORMAT(salary, 0) FROM salaries;

-- 문자열의 왼쪽/ 오른쪽부터 길이만큼 잘라 반환
SELECT LEFT('123456', 2) left_str, RIGHT('123456',2) right_str;

-- 문자열의 좌/우에 문자열 길이만큼 채울 문자열을 삽입
SELECT LPAD('123', 6, '0') l_pad, RPAD('123',6,'0') r_pad;

-- 문자열의 좌/우 공백을 제거
SELECT
	'                   		test	'
	, TRIM('                   		test	') trim_str
	, LTRIM('                   		test	') ltrim_str
	, RTRIM('                   		test	') rtrim_str
;

SELECT 
	TRIM(BOTH 'a' FROM 'abcdefa') trim_str
	, TRIM(LEADING 'a' FROM 'abcdefa') trim_str2
	, TRIM(TRAILING 'a' FROM 'abcdefa') trim_str3
;

-- 문자열을 시작위치에서 길이만큼 잘라서 반환
SELECT SUBSTRING('123456789', 3, 2) sub_str;
SELECT SUBSTR('123456789', 3, 2) sub_str;

-- 왼쪽부터 구분자가 n번째 만큼 나오면 그 이후를 버림
SELECT SUBSTRING_INDEX(
	'abc.test.123.txt'
	, '.'
	, -1
) txt;

-- 영어 대/소문자 변경
SELECT UPPER('abcdQWEQdsfa') up_str, LOWER('asfeEWFWFQsdfaf') lo_str;

-- -----------------------
-- 숫자 함수
-- -----------------------
-- 올림, 반올림, 버림
SELECT 
	CEILING(3.141592) c
	, CEIL(3.141592) c2
	, FLOOR(3.141592) f
	, ROUND(3.141592) r
;
-- 절대값
SELECT ABS(-10) n, ABS(10) p;

-- 소수점을 기준으로 특정 자리수까지 구하고 나머지는 버리고 싶을 때
SELECT TRUNCATE(3.141592, 0);

-- -----------------------
-- 날짜 및 시간 함수
-- -----------------------
-- 현재 날짜 및 시간 반환(YYYY-MM-DD hh:mi:ss)
SELECT 
	NOW()
	, DATE('2026-11-09 16:06:32')
	, DATE(created_at) FROM employees
LIMIT 1
;

-- 날짜의 단위기간에 따라 더한 날짜/시간을 반환
SELECT 
	ADDDATE(NOW(), INTERVAL 1 YEAR) add_y
	, DATE_ADD(NOW(), INTERVAL 1 YEAR) add_y2
	, ADDDATE(NOW(), INTERVAL -1 YEAR) n_y
	, ADDDATE(NOW(), INTERVAL 1 MONTH) add_m
	, ADDDATE(NOW(), INTERVAL 1 DAY) add_d
	, ADDDATE(NOW(), INTERVAL 1 HOUR) add_h
	, ADDDATE(NOW(), INTERVAL 1 MINUTE) add_mi
	, ADDDATE(NOW(), INTERVAL 1 SECOND) add_s
;

-- -----------------------
-- 순차 함수
-- -----------------------
-- RANK() OVER(ORDER BY 컬럼 ASC/DESC)
-- 지정한 컬럼을 기준으로 순위를 매겨 반환
-- 동일한 값이 있는 경우 동일한 순위를 부여

SELECT 
	emp_id
	, salary
	, RANK() OVER(ORDER BY salary DESC) `rank`
FROM salaries
WHERE
	end_at IS NULL
;

-- ROW_NUMBER() OVER(ORDER BY 컬럼 ASC/DESC)
-- 레코드에 순위를 매겨 반환
-- 동일한 값이 있는 경우에도 각 행에 고유한 번호를 부여

SELECT 
	emp_id
	, salary
	, ROW_NUMBER() OVER(ORDER BY salary DESC, start_at) `rank`
FROM salaries
WHERE
	end_at IS NULL
;