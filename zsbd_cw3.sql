1.
CREATE VIEW v_wysokie_pensje AS
SELECT *
FROM employees e
WHERE salary > 6000;
SELECT * FROM v_wysokie_pensje;

2.
CREATE OR REPLACE VIEW v_wysokie_pensje AS
SELECT *
FROM employees e
WHERE salary > 12000;
SELECT * FROM v_wysokie_pensje;

3.
DROP VIEW v_wysokie_pensje;

4.
CREATE  VIEW v_widok AS
SELECT e.employee_id, e.last_name, e.first_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';

SELECT * FROM v_widok;

5.
CREATE  VIEW v_kadra AS
SELECT e.employee_id, e.last_name, e.first_name, e.salary, e.job_id, e.email, e.hire_date
FROM employees e
WHERE e.salary BETWEEN 5000 and 12000;

SELECT * FROM v_kadra;

6.
-- Poprzez widoki można dodać, edytować oraz usunąć pracownika
7.
CREATE  VIEW v_nowy1 AS
SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS liczba_pracownikow, AVG(e.salary) AS srednia_pensja, MAX(e.salary) AS najwyzsza_pensja
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT (e.employee_id) >= 4;
SELECT * FROM v_nowy1;

8.
CREATE VIEW v_wysokie_pensje AS
SELECT *
FROM employees e
WHERE e.salary > 12000 WITH CHECK OPTION;
SELECT * FROM v_wysokie_pensje;

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, salary) VALUES (300, 'Jan', 'Nowak', 'JNOWAK', SYSDATE,'IT_PROG', 15000);
-- Mogę dodać pracownika którego wynagordzenie spełnia warunek >12000, w przeciwnym razie jest błąd ORA-00001: naruszono więzy unikatowe
9.
CREATE MATERIALIZED VIEW v_managerowie AS
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.employee_id = d.manager_id;
SELECT * FROM v_managerowie;

10.
CREATE VIEW v_best AS
SELECT e.first_name, e.last_name, e.salary
FROM employees e
ORDER BY e.salary DESC
FETCH FIRST 10 ROWS ONLY;

SELECT * FROM v_best;