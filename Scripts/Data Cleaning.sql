CREATE DATABASE practise;

USE practise;

-- Load CSV to MySQL server

SELECT * FROM hr;
DESC hr;
 
-- Data Cleaning

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

SELECT birthdate FROM hr;
SET sql_safe_updates = 0;
UPDATE hr
SET birthdate = CASE 
                  WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
                  WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
                  ELSE NULL
                  END;
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

SELECT hire_date FROM hr;
UPDATE hr
SET hire_date = CASE 
                  WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
                  WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
                  ELSE NULL
                  END;
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT termdate FROM hr;
UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;
SET sql_mode = 'ALLOW_INVALID_DATES';
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr ADD COLUMN age INT;
UPDATE hr
SET age=TIMESTAMPDIFF(YEAR,birthdate,CURDATE());
SELECT birthdate,age FROM hr;

SELECT COUNT(*) FROM hr WHERE age<18;

SELECT * FROM hr;