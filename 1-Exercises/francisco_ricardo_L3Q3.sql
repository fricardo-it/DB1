connect sys/sys as sysdba
CREATE USER francisco_ricardo_L3Q3 IDENTIFIED BY 123;
GRANT connect, resource TO francisco_ricardo_L3Q3;
CONNECT francisco_ricardo_L3Q3/123
SPOOL C:\BD1\francisco_ricardo_L3Q3.txt
CREATE TABLE faculty(fid NUMBER, fname VARCHAR2(50), salary varchar2(10));
CREATE TABLE student(sid NUMBER, sname varchar2(50));
CREATE TABLE course(cno NUMBER, cname varchar2(50));
CREATE TABLE enroll(secid NUMBER, sid NUMBER);
CREATE TABLE course_section(secid NUMBER, cno NUMBER, fid NUMBER);
DESC faculty;
DESC student;
DESC course;
DESC enroll;
DESC course_section;
SPOOL OFF;