1.
SELECT last_name || ' ' || salary AS wynagrodzenie
FROM employees
WHERE department_id IN (20, 50) AND salary BETWEEN 2000 AND 7000
ORDER BY last_name;

2.
SELECT hire_date, last_name, salary 
FROM employees
WHERE manager_id IS NOT NULL AND EXTRACT(YEAR FROM hire_date) = 2005
ORDER BY salary;

3.
SELECT first_name || ' ' || last_name, salary, phone_number
FROM employees
WHERE last_name LIKE '__e%'  AND first_name LIKE '%' || :fragment || '%'
ORDER BY 1 DESC, 2 

4. 
SELECT first_name || ' ' ||last_name, round(months_between(DATE '2020-01-01', hire_date)) AS liczba_miesiecy,
CASE
    WHEN round(months_between(DATE '2020-01-01', hire_date)) <= 150 
         THEN 0.1 * salary
    WHEN round(months_between(DATE '2020-01-01', hire_date)) BETWEEN 150 AND 200
         THEN 0.2 * salary
    WHEN round(months_between(DATE '2020-01-01', hire_date)) >= 200
         THEN 0.3 * salary
END AS wysokosc_dodatku
FROM employees
ORDER BY liczba_miesiecy;

5.
SELECT department_id, SUM(salary) AS suma_zarobkow, ROUND(AVG(salary)) AS srednia_zarobkow
FROM employees
GROUP BY department_id
HAVING MIN(salary) > 5000

6.
SELECT  e.last_name, e.department_id, d.department_name, e.job_id
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE city = 'Toronto';

7.
SELECT e1.first_name, e1.last_name, e2.first_name, e2.last_name
FROM employees e1
JOIN employees e2 ON e1.department_id = e2.department_id 
WHERE e1.first_name = 'Jennifer' AND e1.employee_id <> e2.employee_id;

8.
SELECT d.department_id, d.department_name
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.department_id IS NULL;

9.
SELECT e.first_name, e.last_name, e.job_id, d.department_name, e.salary, j.grade
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN job_grades j ON e.salary BETWEEN j.min_salary AND j.max_salary;

10.
SELECT e.first_name, e.last_name, e.salary
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY e.salary DESC;

11.
SELECT e.employee_id, e.first_name, e.last_name
FROM employees e
WHERE e.department_id IN (SELECT department_id FROM employees WHERE last_name LIKE '%u%');

12.
SELECT e.employee_id, e.first_name, e.last_name, round(months_between(SYSDATE, hire_date)) AS staz_pracy
FROM employees e
WHERE months_between(SYSDATE, e.hire_date) > (SELECT AVG(months_between(SYSDATE, hire_date)) FROM employees);

13.
SELECT d.department_name, COUNT(*) AS liczba_pracownikow, ROUND(AVG(e.salary)) AS srednie_wynagrodzenie
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY liczba_pracownikow DESC;

14.
SELECT e.first_name, e.last_name
FROM employees e
WHERE e.salary < ANY (
    SELECT it.salary
    FROM employees it
    JOIN departments d ON it.department_id = d.department_id
    WHERE d.department_name = 'IT');
	
15.
SELECT d.department_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
      AND e.salary > (SELECT AVG(salary) FROM employees));
	  
16.
SELECT j.job_title, ROUND(AVG(e.salary)) AS srednie_zarobki
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
GROUP BY j.job_title
ORDER BY srednie_zarobki DESC
FETCH FIRST 5 ROWS ONLY;

17.
SELECT r.region_name, COUNT(DISTINCT c.country_id) AS liczba_krajow, COUNT(e.employee_id) AS liczba_pracownikow
FROM regions r
LEFT JOIN countries c ON r.region_id = c.region_id
LEFT JOIN locations l ON c.country_id = l.country_id
LEFT JOIN departments d ON l.location_id = d.location_id
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY r.region_name
ORDER BY liczba_pracownikow DESC;

18.
SELECT e.first_name, e.last_name
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;

19.
SELECT EXTRACT(MONTH FROM hire_date) AS miesiac, COUNT(*) AS liczba_pracownikow
FROM employees
GROUP BY EXTRACT(MONTH FROM hire_date)
ORDER BY miesiac;

20.
SELECT d.department_name, ROUND(AVG(e.salary)) AS srednia_pensja
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY srednia_pensja DESC
FETCH FIRST 3 ROWS ONLY;
