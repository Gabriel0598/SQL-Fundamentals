--Self-taught queries

CREATE TABLE departments (  
  deptno        number,  
  name          varchar2(50) not null,  
  location      varchar2(50),  
  constraint pk_departments primary key (deptno)  
);

CREATE TABLE employees (  
  empno             number,  
  name              varchar2(50) not null,  
  job               varchar2(50),  
  manager           number,  
  hiredate          date,  
  salary            number(7,2),  
  commission        number(7,2),  
  deptno           number,  
  constraint pk_employees primary key (empno),  
  constraint fk_employees_deptno foreign key (deptno) 
      references DEPARTMENTS (deptno)  
);

----------------------------------------

SELECT * FROM DEPARTMENTS; --Is not case sensitive
SELECT * FROM EMPLOYEES;

-----------------------------------------

DESCRIBE employees;

-----------------------------------------

create or replace trigger  DEPARTMENTS_BIU
    before insert or update on DEPARTMENTS
    for each row
begin
    if inserting and :new.deptno is null then
        :new.deptno := to_number(sys_guid(), 
          'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    end if;
end;
/

create or replace trigger EMPLOYEES_BIU
    before insert or update on EMPLOYEES
    for each row
begin
    if inserting and :new.empno is null then
        :new.empno := to_number(sys_guid(), 
            'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    end if;
end;
/

-------------------------------------------------

insert into departments (name, location) values
   ('Finance','New York');

insert into departments (name, location) values
   ('Development','San Jose');
   
SELECT * FROM DEPARTMENTS;

-------------------------------------------------

BEGIN TRANSACTION;
--DELETE * FROM departments WHERE DEPTNO = 300375714187737760841917314495716939813;

-------------------------------------------------

insert into EMPLOYEES 
   (name, job, salary, deptno) 
   values
   ('Sam Smith','Programmer', 
    5000, 
  300375351449142234426753956669999991164);

insert into EMPLOYEES 
   (name, job, salary, deptno) 
   values
   ('Mara Martin','Analyst', 
   6000, 
   300375351449139816575114727411650578812);

insert into EMPLOYEES 
   (name, job, salary, deptno) 
   values
   ('Yun Yates','Analyst', 
   5500, 
   300375351449142234426753956669999991164);
   
SELECT * FROM EMPLOYEES;

-------------------------------------------------

SELECT first_name name, last_name AS surname, email FROM employees;
SELECT employee_id, salary + nvl(salary * comission_pct, 0) + 1000, salary FROM employees;

SELECT first_name, last_name, email FROM employees;
SELECT first_name AS name, last_name as surname, email FROM employees; 
SELECT first_name AS "My     Name", email "E-mail" FROM employees;
SELECT first_name AS "My Name", email "E-mail" FROM employees; 
SELECT employee_id, salary + nvl(salary*commission_pct,0) + 1000 new_salary, salary FROM employees;

SELECT * FROM dual;
SELECT 'I''m using quote operator in SQL statements' AS "Output" FROM dual;
SELECT q'dI'm using quote operator in SQL statementsd' AS "Quote Operator" FROM dual;

SELECT DISTINCT first_name FROM employees;
SELECT DISTINCT job_id, department_id, first_name FROM employees;

-------------------------------------------------------------------------------
--Begin of instructor course

--Class 43
SELECT 'The comission percentage is ' || comission_pct AS concatenation, comission_pct FROM employees;
SELECT first_name || '' || last_name AS "Full Name" FROM employees;
SELECT * FROM employees;
SELECT * FROM locations;
SELECT street_address || ',' || city || ',' || postal_code || ',' || state_province || ',' || country_id  AS "Full Address" FROM locations;

--Class 44
SELECT employee_id, salary, salary+100*12 AS annual_salary FROM employees;
SELECT sysdate + 4 FROM dual;
SELECT employee_id, hire_date, hire_date + 5 FROM employees;
SELECT salary, salary * comission_pct, comission_pct FROM employees;

--Class 45
SELECT * FROM employees WHERE salary > 10000;
SELECT * FROM employees WHERE job_id = 'IT_PROG';

--Class 46
SELECT * FROM employees WHERE salary < 10000 AND hire_date > '21-MAY-07';

--Class 47
SELECT * FROM employees WHERE salary BETWEEN 10000 AND 14000;
SELECT * FROM employees WHERE hire_date BETWEEN '07-JUN-02' AND '29-JAN-08';

--Class 48
SELECT * FROM employees WHERE employee_id IN (50, 100, 65, 210, 150);
SELECT * FROM employees WHERE first_name IN ('Steven', 'Peter', 'Adam', 'Aa');
SELECT * FROM employees WHERE hire_date IN ('08-MAR-08', '30-JAN-05');

--Class 49
SELECT * FROM employees WHERE job_id LIKE 'sa%';
SELECT * FROM employees WHERE first_name LIKE 'a%';
SELECT * FROM employees WHERE first_name LIKE '%a%';
SELECT * FROM employees WHERE first_name LIKE '_r%';

--Class 50
SELECT * FROM employees WHERE comission_pct IS NOT NULL;

--Class 51
SELECT * FROM employees WHERE job_id = 'SA_REP' AND salary > 10000;
SELECT * FROM employees WHERE job_id = 'SA_REP' OR salary > 10000;
SELECT * FROM employees WHERE salary > 10000 AND job_id NOT IN ('SA_MAN', 'SA_REP');

--Class 52
SELECT first_name, last_name, job_id, salary FROM employees WHERE job_id = 'IT_PROG' OR job_id = 'ST_CLERK' AND SALARY > 5000;

--Class 54
SELECT * FROM employees;
SELECT first_name, last_name, salary FROM employees ORDER BY first_name;
SELECT first_name, last_name, salary FROM employees ORDER BY last_name;

SELECT first_name, last_name, salary, (10*(salary/5) + 3000) - 100 NEW_SALARY
FROM employees ORDER BY NEW_SALARY;
SELECT first_name, last_name, salary, (10*(salary/5) + 3000) - 100 NEW_SALARY
FROM employees ORDER BY 1; --Order by first column, in this case FIRST_NAME
SELECT first_name, last_name, salary, (10*(salary/5) + 3000) - 100 AS NEW_SALARY
FROM employees ORDER BY 2; --Order by second column, in this case LAST_NAME

SELECT * FROM employees ORDER BY 5; --Order by fifth column, in this case PHONE_NUMBER
SELECT * FROM employees ORDER BY first_name, last_name;

--Class 55
SELECT employee_id, first_name, last_name, salary FROM employees ORDER BY first_name ASC; --ASCENDENT
SELECT employee_id, first_name, last_name, salary FROM employees ORDER BY first_name DESC, last_name DESC; --DESCENDENT
SELECT employee_id, first_name, last_name, salary AS s FROM employees ORDER BY first_name DESC, s DESC; --s alias for salary
SELECT employee_id, first_name, last_name, salary s FROM employees ORDER BY 2 DESC, s DESC;

SELECT first_name, salary, commission_pct FROM employees ORDER BY commission_pct;

--Class 56
SELECT first_name, salary, commission_pct FROM employees ORDER BY commission_pct NULLS FIRST;
SELECT first_name, salary, commission_pct FROM employees ORDER BY commission_pct ASC NULLS FIRST;
SELECT first_name, salary, commission_pct FROM employees ORDER BY commission_pct DESC NULLS LAST;

--Class 57
SELECT employee_id, first_name, last_name, salary, rowid, rownum FROM employees
WHERE department_id = 80 AND rownum <= 5 ORDER BY salary DESC;

SELECT employee_id, first_name, last_name, salary, rowid, rownum FROM
(SELECT employee_id, first_name, last_name, salary, rowid
FROM employees
WHERE department_id = 80
ORDER BY salary DESC)
WHERE rownum <= 5;

SELECT employee_id, first_name, last_name, salary, rowid, rownum FROM
(SELECT employee_id, first_name, last_name, salary, rowid
FROM employees
WHERE department_id = 80
ORDER BY salary DESC)
WHERE rowid = 'AAAdUjAAAAAAGblAAt';

--Class 58
SELECT first_name, last_name, salary FROM employees ORDER BY salary DESC
OFFSET 1 ROW FETCH FIRST 10 ROWS ONLY;

SELECT first_name, last_name, salary FROM employees ORDER BY salary DESC
OFFSET 1 ROW FETCH FIRST 10 ROWS WITH TIES;

SELECT first_name, last_name, salary FROM employees ORDER BY salary DESC
OFFSET 1 ROW FETCH NEXT 10 ROWS WITH TIES;

SELECT first_name, last_name, salary FROM employees ORDER BY salary DESC
OFFSET 5 ROW;

--Class 59

SELECT employee_id, first_name, last_name, department_id
FROM employees WHERE department_id = &department_no;

SELECT employee_id, first_name, last_name, department_id
FROM employees WHERE first_name = '&name';

SELECT employee_id, first_name, last_name, &column_name --salary
FROM &table_name --employees
WHERE &condition --salary > 10000
ORDER BY &order_by_clause; --salary

--Class 60
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary BETWEEN &sal AND &sal + 1000;
--value is not stored here

SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary BETWEEN &&sal AND &&sal + 1000;

&&limit = 5000; --don't works
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary = &&limit; --don't works

SELECT employee_id, first_name, last_name, &&column_name
FROM employees
GROUP BY &column_name
ORDER BY &column_name;

SELECT * FROM employees;
SELECT * FROM departments;

DEFINE emp_num = 100;
SELECT * FROM employees WHERE employee_id = &emp_num;

-- EXEC :finance_dep := 100; --Don't run
DEFINE column_name = 'first_name';

UNDEFINE emp_num; --Drop stored variable in session;
DEFINE; --Use to help
DEFINE column_name;
UNDEF column_name; --Same result
DEF column_name; --Same result

--Class 61
ACCEPT emp_id PROMPT 'Please enter a valid Employee ID';
--Is possible personalize the message that appear;

SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE employee_id = &emp_id;

ACCEPT min_salary PROMPT 'Please specify the MINIMUM salary:';
ACCEPT max_salary PROMPT 'Please specify the MAXIMUM salary';

SELECT employee_id, last_name, salary
FROM employees
WHERE salary BETWEEN &min_salary AND &max_salary;

--Class 62
SET VERIFY ON;
SET VERIFY OFF;

SELECT employee_id, first_name, last_name
FROM employees WHERE employee_id = &emp_id;

SET DEFINE ON;
SET DEFINE OFF;

SELECT * FROM departments WHERE department_name = 'R&D';

--Class 64
SELECT first_name, UPPER(first_name), last_name, LOWER(last_name), email, INITCAPT(email) FROM employees WHERE INITCAP(last_name) = 'King';

--Class 65
SELECT first_name, substr(first_name, 3, 6), substr(first_name, 3), last_name, length(last_name) FROM employees;
SELECT first_name || last_name || employee_id FROM employees;

--Class 66
SELECT instr('I am learning how to use functions in Oracle', 'in', 1, 1) FROM dual;
SELECT first_name, instr(first_name, 'a') FROM employees;

--Class 67
SELECT rtrim(ltrim('www.yourwebsitename.com', 'w.'), '.com') trimmed_text FROM dual;

--Class 68
SELECT first_name, lpad(firs_name, 6, '*') pad FROM employees;
SELECT first_name, lpad('My name is' || last_name, 20, '-') pad FROM employees;

--Class 69
SELECT mod(8,2) FROM dual;
SELECT floor (12.99) FROM dual;
SELECT trunc(12.536) FROM dual;
SELECT round(12.536) FROM dual;

--Class 70
SELECT first_name || ' ' || last_name full_name,
substr(concat(concat(first_name, ''), last_name),
instr(first_name || ' ' || last_name, ' ') + 1) output
FROM employees;

--Class 71
SELECT * FROM employees;

--Class 72
SELECT sysdate, current_date, sessiontimezone, systimestamp, current_timestamp FROM dual;

SELECT sysdate, sysdate + 4, sysdate - 4, sysdate + 4 - 10, sysdate + 1/(24*60) FROM dual;
SELECT employee_id, hire_date, sysdate, trunc(sysdate-hire_date) worked_in_days FROM employees;

SELECT employee_id, hire_date, sysdate, trunc((sysdate-hire_date)/365) worked_in_years FROM employees ORDER BY worked_in_years;

--Class 73
SELECT sysdate, add_months(sysdate, -2) FROM dual;
SELECT sysdate, add_months(sysdate, 30) FROM dual;
SELECT sysdate, add_months('12/07/2021', 30) FROM dual;

SELECT employee_id, hire_date, trunc(hire_date, 'MONTH') truncated_result, round(hire_date, 'MONTH') rounded_result FROM employees;
SELECT employee_id, hire_date, trunc(hire_date, 'MONTH') truncated_result, round(hire_date, 'YEAR') rounded_result FROM employees;
SELECT extract(month from sysdate) extracted_result FROM dual;

--Class 74
SELECT * FROM employees WHERE salary > '5000';
SELECT * FROM employees WHERE hire_date = '17-JUN-03';
SELECT department_id || department_name FROM departments;

--Class 75
SELECT first_name, hire_date, to_char(hire_date, 'DDTHSP=MMTH-yyyy HH24:MI:SS') "Formatted Date" FROM employees;

--Class 76
SELECT salary, salary * comission_pct * 100 Original, to_char(salary * comission_pct * 100, '$00099,999.00') "Formatted Version"
FROM employeees WHERE comission_pct IS NOT NULL;
SELECT to_number('$5,322.33', '$99,999.00') formatted_number FROM dual;

--Class 77
SELECT employee_id, salary, comission_pct, salary + salary * nvl(comission_pct, 0) nvl_new_sal
FROM employees;

SELECT first_name, last_name, length(first_name) lenl, length(last_name) len2,
nullif(length(first_name), length(last_name)) result
FROM employees
WHERE nullif(length(first_name), length(last_name)) IS NULL;

SELECT coalesce(null, null, null, 1, 2, 3, null) FROM dual;
SELECT coalesce(null, null, null, null) FROM dual;

SELECT * FROM locations;
SELECT coalesce(state_province, city) FROM locations;

--Class 78
SELECT first_name, last_name, job_id, salary,
CASE job_id
WHEN 'ST_CLERK' THEN salary * 1.2
WHEN 'SA_REP' THEN salary * 1.3
WHEN 'IT_PROG' THEN salary * 1.4
ELSE salary
END "UPDATED SALARY"
FROM employees;

SELECT first_name, last_name, job_id, salary
FROM employees
WHERE (CASE
    WHEN job_id = 'IT_PROG' AND salary > 5000 THEN 1
    WHEN job_id = 'SA_MAN' AND salary > 10000 THEN 1
    ELSE 0
    END) = 1;

--Class 79
SELECT decode(1,1,'one',2,'two') result FROM dual;
SELECT decode(2,1,'one',2,'two') result FROM dual;
SELECT decode(3,1,'one',2,'two') result FROM dual;
SELECT decode(25,1,'one',2,'two',3,'three','Not found') result FROM dual;

SELECT first_name, last_name, job_id, salary, decode(job_id, 'ST_CLERK', salary * 1.20,
'SA_REP', salary * 1.30, 'IT_PROG', salary * 1.50, salary) AS updated_salary FROM employees;

--Class 81
SELECT avg(salary), avg(ALL salary), avg(DISTINCT salary) FROM employees WHERE job_id = 'IT_PROG';

SELECT avg(commission_pct), avg(nvl(commission_pct,0)) FROM employees;

--Class 82
SELECT count(*), count(comission_pct), count(distinct comission_pct), count(distinct nvl(comission_pct, 0)) FROM employees;

--Class 83
SELECT max(salary), max(hire_date), max(first_name) FROM employees;
SELECT * FROM employees ORDER BY first_name;

--Class 84
SELECT min(salary), min(comission_pct), min(nvl(comission_pct, 0)),
min(hire_date), min(first_name) FROM employees;

--Class 85
SELECT SUM(salary), SUM(ALL salary), SUM(DISTINCT salary) FROM employees;

--Class 86
SELECT j.job_title,
LISTAGG (e.first_name, ',') WITHIN GROUP (ORDER BY e.first_name) AS employees_list
FROM employees AS e, jobs as J
WHERE e.job_id = j.job_id
GROUP BY j.job_title;

--Class 87
SELECT SUM(salary), AVG(salary), MAX(hire_date), MIN(comission_pct),
COUNT(DISTINCT manager_id), LISTAGG(job_id, ','), hire_date FROM employees;

--Class 88
SELECT job_id, avg(salary) FROM employees GROUP BY job_id ORDER BY avg(salary) DESC;
SELECT job_id, department_id, manager_id, avg(salary), count(*) FROM employees GROUP BY job_id, department_id, manager_id ORDER BY count(*) DESC;

--Class 89
SELECT job_id, avg(salary), sum(salary), max(hire_date), count(*) FROM employees GROUP BY job_id;
SELECT job_id, avg(salary), sum(salary), max(hire_date), count(*) FROM employees WHERE job_id IN('IT_PROG', 'ST_MAN', 'AC_ACCOUNT') GROUP BY job_id;

--Class 90
SELECT job_id, avg(salary) FROM employees WHERE hire_date > '28-MAY-05' GROUP BY job_id HAVING avg(salary) > 10000;

--Class 91
SELECT max(avg(salary)), min(avg(salary)) FROM employees GROUP BY department_id;

--Class 94
SELECT * FROM employees;
SELECT * FROM departments;

DESC employees;
DESC departments;

SELECT * FROM employees NATURAL JOIN departments;
SELECT * FROM departments NATURAL JOIN employees;

--Class 95
SELECT * FROM employees JOIN departments USING(department_id);
SELECT * FROM employees JOIN departments USING(department_id, manager_id);

--Class 96
SELECT * FROM employees AS e JOIN departments USING(department_id);

--Class 103
SELECT first_name, last_name, department_id, department_name
FROM employees LEFT OUTER JOIN departments USING(department_id);

SELECT first_name, last_name, department_id, department_name
FROM employees LEFT OUTER JOIN departments ON(e.department_id = d.department_id);

--Class 104
SELECT first_name, last_name, e.department_id, d.department_name, location_id
FROM employees e RIGHT OUTER JOIN departments d
ON(e.department_id = d.department_id)
LEFT OUTER JOIN locations
USING(location_id);

--Class 105
SELECT first_name, last_name, e.department_id, d.department_name, location_id
FROM employees e FULL OUTER JOIN departments d
ON(e.department_id = d.department_id);

--Class 106
SELECT first_name, last_name, e.department_id, d.department_name, job_title j
FROM employees e CROOSS JOIN departments d
CROSS JOIN jobs j;

--Class 113
SELECT salary FROM employees WHERE employee_id = 145;
SELECT * FROM employees WHERE salary > 14000;

SELECT * FROM employees WHERE salary > (SELECT salary FROM employees WHERE employee_id = 145);

--Class 115
SELECT first_name, last_name, department_id, salary
FROM employees
WHERE department_id IN (SELECT department_id
                        FROM departments
                        WHERE location_id IN (SELECT location_id
                                                FROM locations
                                                WHERE country_id IN (SELECT country_id
                                                                        FROM countries
                                                                        WHERE country_name = 'United Kingdom')));
--Class 117
SELECT e.employee_id, e.first_name, e.last_name, b.department_name, b.city, b.state_province
FROM employees AS e JOIN (SELECT department_id, department_name, state_province, city
                            FROM departments JOIN locations USING(location_id) ORDER BY department_id) b USING(department_id);

--Class 123
--Exclude duplicates
SELECT * FROM retired_employees
UNION
SELECT * FROM employees
WHERE job_id = 'IT_PROG';

--Include duplicates
SELECT first_name, last_name, email, hire_date, salary, job_id, FROM retired_employees
UNION ALL
SELECT first_name, last_name, email, hire_date, salary, job_id FROM employees;

--Class 124
SELECT first_name, last_name, email, hire_date, salary, job_id, FROM retired_employees
INTERSECT
SELECT first_name, last_name, email, hire_date, salary, job_id FROM employees;

--Class 125
SELECT first_name, last_name, email, hire_date, salary, job_id, FROM retired_employees
MINUS
SELECT first_name, last_name, email, hire_date, salary, job_id FROM employees;

--Class 131
CREATE TABLE my_employees(
employee_id NUMBER(3) NOT NULL,
first_name VARCHAR2(50) DEFAULT 'No name',
last_name VARCHAR2(50),
hire_date DATE DEFAULT sysdate NOT NULL
);

SELECT * FROM my_employees;
INFO my_employees;

--Class 132
CREATE TABLE employees_copy
AS SELECT first_name, last_name, salary FROM employees;
SELECT * FROM employees_copy;

--Class 133
ALTER TABLE employees_copy ADD ssn VARCHAR2(11);

--Class 135
CREATE GLOBAL TEMPORARY TABLE emp_temp AS SELECT * FROM employees;
SELECT * FROM emp_temp;
ALTER TABLE emp_temp READ ONLY;
ALTER TABLE emp_temp ADD gender VARCHAR(2);

--Class 136
SELECT * FROM employees_copy;
DROP TABLE employees_copy; --Is possible recovery/ exclude schema
DROP TABLE employees_copy PURGE; --Is not possible recovery
FLASHBACK TABLE employees_copy TO BEFORE DROP; --Recovery command;

--Class 137
TRUNCATE TABLE employees_copy; --Just remove registers, don't exclude schema;

--Class 138
DROP TABLE employees_copy;
CREATE TABLE employees_copy AS SELECT * FROM employees;
COMMENT ON COLUMN employees_copy.job_id IS 'Stores job title abbreviation';
COMMENT ON TABLE employees_copy IS 'This is a copy of employees table';

SELECT * FROM user_tab_comments WHERE table_name = 'EMPLOYEES_COPY';
SELECT * FROM user_col_comments WHERE table_name = 'EMPLOYEES_COPY';

--Class 139
ALTER TABLE employees_copy RENAME COLUMN hire_date TO start_date;
ALTER TABLE employees_copy RENAME to employees_duplicate;
RENAME employees_duplicate TO employees_backup;
SELECT * FROM employees_backup;

--Class 141
CREATE TABLE jobs_copy AS SELECT * FROM jobs;
INSERT INTO jobs_copy(job_id, job_title, min_salary, max_salary) VALUES('PR_MGR', 'Project Manager', 7000, 20000);
SELECT * FROM jobs_copy;

--Class 142
INSERT INTO employees_copy SELECT * FROM employees WHERE job_id = 'IT_PROG';
SELECT * FROM employees_copy;

--Class 148
DELETE FROM employees_copy WHERE job_id = 'IT_PROG';
DELETE FROM employees_copy WHERE department_id IN(SELECT department_id FROM departments WHERE upper(department_name) LIKE '%SALES%');

--Class 149
UPDATE employees_copy SET salary = 500;
UPDATE employees_copy SET salary = 50000 WHERE job_id = 'IT_PROG';
UPDATE employees_copy SET (salary, commission_pct) = (SELECT max(salary), max(commission_pct) FROM employees)  WHERE job_id = 'IT_PROG';
UPDATE employees_copy SET salary = 100000 WHERE hire_date = (SELECT max(hire_date) FROM employees);

--Class 150
INSERT INTO employees_copy SELECT * FROM employees WHERE job_id = 'SA_REP';
MERGE INTO employees_copy c USING (SELECT * FROM employees) e ON (c.employee_id = e.employee_id) WHEN MATCHED THEN
UPDATE SET c.first_name = e.first_name, c.last_name = e.last_name, c.salary = e.salary DELETE WHERE department_id IS NULL
WHEN NOT MATCHED THEN INSERT VALUES (e.employee_id, e.first_name, e.last_name, e.email, e.phone_number, e.hire_date, e.job_id, e.salary, e.commission_pct, e.manager_id, e.department_id);

--Class 152
SELECT * FROM employees_copy;
DELETE employees_copy WHERE job_id = 'SA_REP';
UPDATE employees_copy SET first_name = 'John';
ROLLBACK;
UPDATE employees_copy SET first_name = 'John';
COMMIT;

--Class 154
SELECT * FROM employees_copy;
SELECT * FROM jobs_copy;
CREATE TABLE jobs_copy AS SELECT * FROM jobs;
DELETE FROM employees_copy WHERE job_id = 'IT_PROG';
SAVEPOINT A;

UPDATE employees_copy SET salary = 1.2 * salary;
SAVEPOINT B;

INSERT INTO jobs_copy VALUES('PY_DEV', 'Python Developer', 12000, 20000);
SAVEPOINT C;

ROLLBACK TO A;

--Class 155
SELECT * FROM employees_copy WHERE job_id = 'IT_PROG' FOR UPDATE;
SELECT first_name, last_name, salary FROM employees_copy e JOIN departments d
USING(department_id) WHERE location_id = 1400 FOR UPDATE OF first_name, location_id NOWAIT;

--Class 157
CREATE TABLE managers (manager_id NUMBER NOT NULL, first_name VARCHAR(50),
last_name VARCHAR2(50) CONSTRAINT lname_nn NOT NULL, department_id NUMBER NOT NULL);

--Class 158
CREATE TABLE managers
(manager_id NUMBER CONSTRAINT mgr_mid_uk UNIQUE,
first_name VARCHAR2(50),
last_name VARCHAR2(50),
department_id NUMBER NOT NULL,
phone_number VARCHAR2(11) UNIQUE NOT NULL,
email VARCHAR2(100),
UNIQUE(email),
CONSTRAINT mgr_composite_uk UNIQUE(first_name, last_name, department_id));

--Class 159
CREATE TABLE managers
(manager_id NUMBER CONSTRAINT mgr_mid_uk PRIMARY KEY,
first_name VARCHAR2(50),
last_name VARCHAR2(50),
department_id NUMBER NOT NULL,
phone_number VARCHAR2(11) UNIQUE NOT NULL,
email VARCHAR2(100),
UNIQUE(email),
CONSTRAINT mgr_composite_uk UNIQUE(first_name, last_name, department_id));

CREATE TABLE executives
(executive_id NUMBER,
first_name VARCHAR2(50),
last_name VARCHAR2(50),
CONSTRAINT exec_eid_pk PRIMARY KEY(executive_id, last_name));

--Class 160
CREATE TABLE executives
(executive_id NUMBER,
first_name VARCHAR2(50),
last_name VARCHAR2(50),
department_id NUMBER NOT NULL,
phone_number VARCHAR2(11) UNIQUE NOT NULL,
email VARCHAR2(100),
UNIQUE(email),
CONSTRAINT exec_eid_pk FOREIGN KEY(manager_id) REFERENCES employees_copy(employee_id));

--Class 162
CREATE TABLE executives
(executive_id NUMBER,
first_name VARCHAR2(50),
last_name VARCHAR2(50),
department_id NUMBER NOT NULL,
phone_number VARCHAR2(11) UNIQUE NOT NULL,
email VARCHAR2(100),
UNIQUE(email),
CONSTRAINT exec_eid_pk FOREIGN KEY(manager_id) REFERENCES employees_copy(employee_id) ON DELETE CASCADE);

CREATE TABLE executives
(executive_id NUMBER,
first_name VARCHAR2(50),
last_name VARCHAR2(50),
department_id NUMBER NOT NULL,
phone_number VARCHAR2(11) UNIQUE NOT NULL,
email VARCHAR2(100),
UNIQUE(email),
CONSTRAINT exec_eid_pk FOREIGN KEY(manager_id) REFERENCES employees_copy(employee_id) ON DELETE SET NULL);

--Class 163
CREATE TABLE managers2
(manager_id NUMBER,
first_name VARCHAR2(50),
last_name VARCHAR2(50),
email VARCHAR2(50),
salary NUMBER,
CONSTRAINT salary_check CHECK(salary > 100 AND salary < 50000 AND upper(email) LIKE '%.COM'));

--Class 164
ALTER TABLE employees_copy ADD CONSTRAINT emp_cpy_email_uk UNIQUE(email);
ALTER TABLE employees_copy ADD CONSTRAINT emp_cpy_dept_uk FOREIGN KEY (department_id) REFERENCES deparments(deparment_id);

--Class 165
ALTER TABLE employees_copy DROP CONSTRAINT EMP_CPY_EMP_ID_PK CASCADE;

--Class 167
ALTER TABLE employees_copy RENAME CONSTRAINT EMP_CPY_EMP_ID_PK TO cpy_id;

--Class 175
CREATE VIEW empvw20 AS
SELECT employee_id e_id, first_name name, last_name surname FROM employees WHERE department_id = 30;

--Class 176
CREATE VIEW emp_cx_vw (DNAME, MIN_SAL, MAX_SAL) AS
SELECT DISTINCT upper(department_name), min(salary), max(salary)
FROM employees e JOIN departments d
USING(department_id)
GROUP BY department_name;

--Class 178
CREATE OR REPLACE VIEW empvw60 AS
SELECT employee_id, first_name, last_name, email, hire_date, job_id, department_id
FROM employees_copy WHERE department_id = 60;

--Class 179
CREATE OR REPLACE VIEW empvw60 AS
SELECT employee_id, first_name, last_name, email, hire_date, job_id, department_id
FROM employees_copy WHERE department_id = 80
WITH CHECK OPTION CONSTRAINT emp_dept80_chk;

--Is not possible do INSERT
INSERT INTO empvw80 VALUES (216, 'John2', 'Brown2', 'JBROWN2', sysdate, 'SA_MAN');
UPDATE empvw80 SET department_id = 70 WHERE employee_id = 217;

--Class 180
CREATE OR REPLACE VIEW empvw60 AS
SELECT employee_id, first_name, last_name, email, hire_date, job_id, department_id
FROM employees_copy WHERE department_id = 80 AND job_id = 'SA_MAN'
WITH READ ONLY;

--Class 181
--Is necessary before drop constraints to drop views
DROP VIEW empvw60;

--Class 183
SELECT * FROM dictionary;
SELECT * FROM dictionary WHERE upper(comments) LIKE '%CONSTRAINT%';

--Class 193
CREATE SEQUENCE employee_seq START WITH 100
INCREMENT BY 3
MAX VALUE 99999
CACHE 30
NOCYCLE;

--Class 194
ALTER SEQUENCE employee_seq
INCREMENT BY 4
MAX VALUE 99999
CACHE 30
NOCYCLE;

--Class 195
DROP SEQUENCE employee_seq;

--Class 200
CREATE TABLE temp
(ID NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY STARTS WITH 50 INCREMENT BY 3,
text VARCHAR2(100));

CREATE TABLE temp2
(ID NUMBER GENERATED BY ALWAYS AS IDENTITY, text VARCHAR2(100));

--Class 203
CREATE OR REPLACE SYNONYM test_syn FOR deparments;
SELECT * FROM test_syn;
DROP SYNONYM test_syn;

CREATE OR REPLACE PUBLIC SYNONYM test_syn FOR deparments;
CREATE OR REPLACE PRIVATE SYNONYM test_syn FOR system.redo_db;