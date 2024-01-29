CONNECT francisco_ricardo_L4Q1/123
SPOOL C:\BD1\francisco_ricardo_L4Q2.txt

CREATE TABLE region(regid NUMBER, regionname VARCHAR2(50));
ALTER TABLE region
ADD CONSTRAINT region_regid_PK PRIMARY KEY (regid);

ALTER TABLE employee
ADD (hiredate DATE);

ALTER TABLE job
ADD (skill_required VARCHAR2(50));

ALTER TABLE employee
DROP COLUMN salary;

ALTER TABLE location
ADD (regid NUMBER);

ALTER TABLE location
ADD CONSTRAINT location_regid_FK FOREIGN KEY (regid)
REFERENCES region(regid);

SELECT table_name FROM user_tables;

DESC location;
DESC department;
DESC employee;
DESC job;
DESC emp_job;
DESC region;

SELECT constraint_name, constraint_type, table_name, status FROM user_constraints;

SPOOL OFF;