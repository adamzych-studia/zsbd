CREATE TABLE REGIONS (
region_id INT PRIMARY KEY,
region_name VARCHAR2(30)
);
CREATE TABLE COUNTRIES (
country_name VARCHAR2(20), 
country_id INT PRIMARY KEY ,
region_id INT NOT NULL
);
ALTER TABLE COUNTRIES ADD FOREIGN KEY (region_id) REFERENCES REGIONS(region_id);

CREATE TABLE LOCATIONS (
location_id INT PRIMARY KEY, 
street_address VARCHAR2(20), 
poscat_code NUMBER (10,2), 
city VARCHAR2(30),
state_province VARCHAR(20),
country_id INT
);
ALTER TABLE LOCATIONS ADD FOREIGN KEY (country_id) REFERENCES COUNTRIES (country_id);

CREATE TABLE DEPARTMENTS (
department_id INT PRIMARY KEY, 
department_name VARCHAR2(20), 
manager_id INT, 
location_id INT
);

ALTER TABLE DEPARTMENTS ADD FOREIGN KEY (location_id) REFERENCES LOCATIONS(location_id);

CREATE TABLE EMPLOYEES (
employee_id INT PRIMARY KEY, 
first_name VARCHAR2(20), 
last_name VARCHAR2(30), 
email VARCHAR(30),
phone_number VARCHAR(20),
hire_date DATE,
job_id INT,
salary NUMBER,
commission_pct INT,
manager_id INT,
department_id INT
);

ALTER TABLE EMPLOYEES ADD FOREIGN KEY (department_id) REFERENCES DEPARTMENTS(department_id);
ALTER TABLE EMPLOYEES ADD FOREIGN KEY (manager_id) REFERENCES EMPLOYEES(employee_id);

CREATE TABLE JOBS (
job_id INT PRIMARY KEY, 
job_title VARCHAR2(30) ,
min_salary NUMBER(10, 2),
max_salary NUMBER (10, 2)
);
CREATE TABLE JOB_HISTORY (
start_date DATE, 
end_date DATE, 
job_id INT NOT NULL,
department_id INT NOT NULL
);
ALTER TABLE JOB_HISTORY ADD employee_id INT;
ALTER TABLE JOB_HISTORY ADD FOREIGN KEY (job_id) REFERENCES JOBS(job_id);
ALTER TABLE JOB_HISTORY ADD FOREIGN KEY (department_id) REFERENCES DEPARTMENTS(department_id);
ALTER TABLE JOB_HISTORY ADD FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id);
ALTER TABLE JOB_HISTORY ADD PRIMARY KEY (employee_id, start_date);


ALTER TABLE EMPLOYEES ADD FOREIGN KEY (job_id) REFERENCES JOBS(job_id);


ALTER TABLE JOBS ADD CONSTRAINT check_salary CHECK (max_salary - min_salary >= 2000);


INSERT INTO JOBS (job_id, job_title, min_salary, max_salary) VALUES (1, 'Profesor', 7000, 10000);

INSERT INTO JOBS (job_id, job_title, min_salary, max_salary) VALUES (2, 'Adiunkt', 6000, 9000);

INSERT INTO JOBS (job_id, job_title, min_salary, max_salary) VALUES (3, 'Asystent', 5000, 8000);

INSERT INTO JOBS (job_id, job_title, min_salary, max_salary) VALUES (4, 'Nauczyciel akademicki', 4000, 7000);



INSERT INTO EMPLOYEES (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
) VALUES (1, 'Jan', 'Kowalski', 'jan.kowalski@domena.com', '510-100-200',
    DATE '2006-01-01', 1, 7000, NULL, 7, 1
);

INSERT INTO EMPLOYEES (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
) VALUES (2, 'Sławomir', 'Nowak', 'sławomir.nowak@domena.com', '510-200-300',
    DATE '2002-05-01', 2, 8000, 10, 6, 2
);

INSERT INTO EMPLOYEES (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
) VALUES (3, 'Jerzy', 'Duda', 'jerzy.duda@domenae.com', '510-300-400',
    '2008-09-01', 3, 9500, NULL, 2, 3
);

INSERT INTO EMPLOYEES (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
) VALUES (4, 'Marta', 'Wiśniewska', 'marta.wisniewska@domena.com', '510-400-500',
    DATE '2016-03-01', 4, 6000, 5, 3, 4
);

UPDATE EMPLOYEES SET manager_id = 1 WHERE employee_id IN (2, 3);

UPDATE JOBS SET min_salary = min_salary + 500, max_salary = max_salary + 500
WHERE LOWER(job_title) LIKE '%b%' OR LOWER(job_title) LIKE '%s%';
   
   
   
DELETE FROM JOBS WHERE max_salary > 9000;


DROP TABLE REGIONS CASCADE CONSTRAINTS;   --tabelę można przywrócić jeśli znajduje się w RECYCLEBIN;

FLASHBACK TABLE REGIONS TO BEFORE DROP;   --przywrócenie tabeli po usunięciu
