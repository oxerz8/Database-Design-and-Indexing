CREATE TABLE employee (id serial primary key , name varchar(100) , salary integer, age integer);
INSERT INTO employee(name,salary,age)
SELECT
md5(random()::text) as name,
floor(random() * 10000 + 1)::int as salary,
floor(random() * (65-20+1) + 20)::int as age
FROM
generate_series(1,100000);

--creating 2 indices: b-tree on salary, hash on age
CREATE INDEX idx_emp_salary ON employee (salary);
CREATE INDEX idx_emp_age ON employee USING HASH (age);

--search examples to compare each's performance where they shine
EXPLAIN ANALYZE SELECT * FROM employee WHERE salary > 7300 AND salary < 9600;
EXPLAIN ANALYZE SELECT * FROM employee WHERE age=42;

--delete examples to compare each indices performance
EXPLAIN ANALYZE DELETE FROM employee where age=65;                                
EXPLAIN ANALYZE DELETE FROM employee where salary<8000 and salary > 7600;                                
