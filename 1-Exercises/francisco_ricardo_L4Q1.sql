connect sys/sys as sysdba
CREATE USER francisco_ricardo_L4Q1 IDENTIFIED BY 123;
GRANT connect, resource TO francisco_ricardo_L4Q1;
CONNECT francisco_ricardo_L4Q1/123
SPOOL C:\BD1\francisco_ricardo_L4Q1.txt
CREATE TABLE location(locationid NUMBER, buildingname VARCHAR2(50));
CREATE TABLE department(deptid NUMBER, deptname VARCHAR2(50), locationid NUMBER);
CREATE TABLE employee(empid NUMBER, ename varchar2(50), salary number(10,2), deptid NUMBER);
CREATE TABLE job(jobid NUMBER, description varchar2(50));
CREATE TABLE emp_job(empid NUMBER, jobid NUMBER, date_job_assigned DATE);

ALTER TABLE location
ADD CONSTRAINT location_locationid_PK PRIMARY KEY (locationid);
ALTER TABLE department
ADD CONSTRAINT department_deptid_PK PRIMARY KEY (deptid);
ALTER TABLE employee
ADD CONSTRAINT employee_empid_PK PRIMARY KEY (empid);
ALTER TABLE job
ADD CONSTRAINT job_jobid_PK PRIMARY KEY (jobid);
ALTER TABLE emp_job
ADD CONSTRAINT emp_job_empid_jobid_PK PRIMARY KEY (empid,jobid);

ALTER TABLE department
ADD CONSTRAINT department_locationid_FK FOREIGN KEY (locationid)
REFERENCES location(locationid);
ALTER TABLE employee
ADD CONSTRAINT employee_deptid_FK FOREIGN KEY (deptid)
REFERENCES department(deptid);
ALTER TABLE emp_job
ADD CONSTRAINT emp_job_empid_FK FOREIGN KEY (empid)
REFERENCES employee(empid);
ALTER TABLE emp_job
ADD CONSTRAINT emp_job_jobid_FK FOREIGN KEY (jobid)
REFERENCES job(jobid);

SELECT table_name FROM user_tables;

DESC location;
DESC department;
DESC employee;
DESC job;
DESC emp_job;

SELECT constraint_name, constraint_type, table_name, status FROM user_constraints;

SPOOL OFF;