-- ----------------------
-- INDEX
-- ----------------------
-- INDEX 확인
SHOW INDEX FROM employees;

-- 0.03s -> 0.00s
SELECT * FROM employees WHERE `name` = '이미경';

-- index generate
ALTER TABLE employees
ADD INDEX idx_employees_name (`name`);

-- index delete
ALTER TABLE employees
DROP INDEX idx_employees_name;

