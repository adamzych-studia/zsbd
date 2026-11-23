1.
SELECT first_name, last_name, salary,
       DENSE_RANK() OVER (
           ORDER BY salary DESC) AS rank
FROM employees;

2.
SELECT first_name, last_name, salary,
       RANK() OVER ( ORDER BY salary DESC ) AS rank,
        SUM(salary) OVER () AS suma
FROM employees;

3.
SELECT  e.last_name , p.product_name,
      SUM(s.quantity * s.price) OVER 
      (PARTITION BY e.employee_id
        ORDER BY s.sale_id ) AS skumulowana_wartosc_sprzedazy,
        RANK() OVER ( ORDER BY (s.quantity * s.price) DESC ) AS ranking_sprzedazy
FROM employees e
JOIN sales s
    ON e.employee_id = s.employee_id
JOIN products p
    ON s.product_id = p.product_id;
	
4.
SELECT  e.last_name , p.product_name, s.price,
     COUNT (*) OVER ( PARTITION BY s.product_id, TRUNC(s.sale_date)
     ) AS liczba_transakcji,
     SUM (s.price * s.quantity) OVER ( PARTITION BY s.product_id, TRUNC(s.sale_date)
     ) AS suma_dzienna,
     LAG (s.price) OVER ( PARTITION BY p.product_id
     ORDER BY s.sale_date
     ) AS poprzednia_cena,
    LEAD (s.price) OVER( PARTITION BY p.product_id
     ORDER BY s.sale_date
     ) AS nastepna_cena
     
FROM sales s
JOIN employees e
    ON s.employee_id = e.employee_id
JOIN products p
    ON s.product_id = p.product_id;

5.
SELECT p.product_name, s.price,
     SUM (s.price * s.quantity) OVER ( 
     PARTITION BY TRUNC(s.sale_date, 'MM')
     ) AS suma_miesieczna,
     SUM (s.price * s.quantity) OVER ( 
     PARTITION BY s.product_id, TRUNC (s.sale_date, 'MM')
     ORDER BY s.sale_date, s.sale_id
     ) AS suma_rosnaca
     
FROM sales s
JOIN employees e
    ON s.employee_id = e.employee_id
JOIN products p
    ON s.product_id = p.product_id;

6.
SELECT p.product_name, p.product_category,
        LAG(s.price) OVER (
        PARTITION BY p.product_id, TO_CHAR(s.sale_date, 'MM-DD')
        ORDER BY EXTRACT (YEAR FROM s.sale_date)
        ) AS cena_2022,
        s.price AS cena_2023,
        s.price - lAG(s.price) OVER (
        PARTITION BY s.product_id,TO_CHAR(s.sale_date, 'MM-DD')
        ORDER BY EXTRACT (YEAR FROM s.sale_date)
        ) AS roznica_cen
        
FROM sales s
JOIN products p
    ON s.product_id = p.product_id;

7.
SELECT p.product_name, p.product_category, s.price, 
       MIN(s.price) OVER (
       PARTITION BY p.product_category
       ) AS cena_minimalna,
       MAX(s.price) OVER (
       PARTITION BY p.product_category
       ) AS cena_maksymalna,
        MAX(s.price) OVER (
        PARTITION BY p.product_category
        ) - MIN(s.price) OVER (
        PARTITION BY p.product_category
        ) AS roznica_cen
FROM sales s
JOIN products p
    ON s.product_id = p.product_id;
    
8.
SELECT p.product_name, p.product_category, s.price, 
       AVG(s.price) OVER (
       PARTITION BY p.product_category
       ORDER BY s.sale_date
       ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
       ) AS srednia_kroczaca
FROM sales s
JOIN products p
    ON s.product_id = p.product_id;
	
9.
SELECT p.product_name, p.product_category, s.price, 
       RANK () OVER (
       PARTITION BY p.product_category
       ORDER BY s.price DESC
       ) AS ranking_cen,
       ROW_NUMBER() OVER (
       PARTITION BY p.product_category
       ORDER BY s.price DESC
       ) AS numer_wiersza,
       DENSE_RANK () OVER (
       PARTITION BY p.product_category
       ORDER BY s.price DESC
       ) AS gesty_ranking
FROM sales s
JOIN products p
    ON s.product_id = p.product_id;

10.
SELECT e.last_name, p.product_name, s.sale_date, s.price * s.quantity AS wartosc_sprzedazy,
       SUM(s.price * s.quantity)
           OVER (
               PARTITION BY e.employee_id
               ORDER BY s.sale_date
               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
           ) AS narastajaca_sprzedaz,
       RANK() OVER (
               ORDER BY s.price * s.quantity DESC
           ) AS ranking_sprzedazy
FROM sales s
JOIN employees e
    ON s.employee_id = e.employee_id
JOIN products p
    ON s.product_id = p.product_id;

11.
SELECT DISTINCT e.first_name, e.last_name, j.job_title
FROM employees e
JOIN sales s
    ON e.employee_id = s.employee_id
JOIN jobs j
    ON e.job_id = j.job_id;
