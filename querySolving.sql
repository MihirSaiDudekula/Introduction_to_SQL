CREATE TABLE aircraft(
  aid VARCHAR(9) PRIMARY KEY,
  aname VARCHAR(10),
  crange INT
);
 
CREATE TABLE employees(
  eid VARCHAR(9) PRIMARY KEY,
  ename VARCHAR(10),
  salary INT
);

 CREATE TABLE certified(
  aid VARCHAR(9),
  eid VARCHAR(9),
  FOREIGN KEY (eid) REFERENCES employees(eid),
  FOREIGN KEY (aid) REFERENCES aircraft(aid)
 );

INSERT INTO aircraft VALUES
('B001','Boeing',4000)
('B002','Boeing',2500);
('BB003','Blackbeard',6000);
('S004','Supermarine',8000);
('L005','Lockheed',2100);

INSERT INTO employees VALUES
(1,'Johnny',40000)
(2,'Timmy',60000);
(3,'Lawrence',70000);
(4,'Zuzu',90000);
(5,'Matt',80000);

INSERT INTO certified VALUES
('B001',1),
('B002',1),
('S004',3),
('S004',4),
('L005',5),
('B002',2),
('BB003',4),
('BB003',3),
('L005',4);

-- Find Emp ID of employee who makes highest salary

SELECT eid FROM employees WHERE salary=(SELECT MAX(salary) FROM employees);

-- Find the name of aircrafts such that all pilots certified to operate them earn more than 50000

SELECT aname FROM aircraft WHERE aid IN (SELECT aid FROM certified WHERE eid IN (SELECT eid FROM employees WHERE salary>50000));
-- or
SELECT	DISTINCT aname 
FROM	aircraft a, certified c, employees e 
WHERE	a.aid=c.aid and c.eid=e.eid and e.salary>50000;

--  Find the employees who are not certified for any aircrafts.
SELECT e.eid,e.ename from employees e
WHERE NOT EXISTS (SELECT * FROM certified c WHERE c.eid=e.eid);

-- Find the employees who are certified for the maximum number of aircrafts.

SELECT ename FROM (SELECT ename,count() AS c FROM employees NATURAL JOIN certified GROUP BY ename) AS a WHERE c=(SELECT max(c) FROM (SELECT ename,count() AS c FROM employees NATURAL JOIN certified GROUP BY ename) AS k);