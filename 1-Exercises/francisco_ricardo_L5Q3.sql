connect sys/sys as sysdba
CREATE USER francisco_ricardo_L5Q3 IDENTIFIED BY 123;
GRANT connect, resource TO francisco_ricardo_L5Q3;
CONNECT francisco_ricardo_L5Q3/123
SPOOL C:\BD1\francisco_ricardo_L5Q3.txt

CREATE TABLE course(courseid NUMBER, coursename varchar2(40) CONSTRAINT course_coursename_NN NOT NULL, credits number,
CONSTRAINT course_courseid_PK PRIMARY KEY (courseid)); 

CREATE TABLE term(termid NUMBER, description VARCHAR2(50) CONSTRAINT term_description_NN NOT NULL, status VARCHAR2(10) CONSTRAINT term_status_CK CHECK (status in ('OPEN','CLOSED')),
CONSTRAINT term_termid_PK PRIMARY KEY (termid));

CREATE TABLE location(locid NUMBER, building VARCHAR2(20) CONSTRAINT location_building_NN NOT NULL, room NUMBER CONSTRAINT location_room_UK UNIQUE,
CONSTRAINT location_locid_PK PRIMARY KEY (locid));

CREATE TABLE student(studid NUMBER, sname varchar2(50) CONSTRAINT student_sname_NN NOT NULL, birthdate DATE,
CONSTRAINT student_studid_PK PRIMARY KEY (studid));

CREATE TABLE course_section(csectionid NUMBER, maxcapacity NUMBER CONSTRAINT course_section_maxcapacity_NN NOT NULL, courseid NUMBER, termid number, locid number,
CONSTRAINT course_section_csectionid_PK PRIMARY KEY (csectionid),
CONSTRAINT course_section_courseid_FK FOREIGN KEY (courseid)
REFERENCES course(courseid),
CONSTRAINT course_section_termid_FK FOREIGN KEY (termid)
REFERENCES term(termid),
CONSTRAINT course_section_locid_FK FOREIGN KEY (locid)
REFERENCES location(locid));

CREATE TABLE enrollment(studid NUMBER, csectionid NUMBER, grade NUMBER(3,2),
CONSTRAINT enroll_studid_csectionid_PK PRIMARY KEY (studid,csectionid),
CONSTRAINT enrollment_studid_FK FOREIGN KEY (studid)
REFERENCES student(studid),
CONSTRAINT enrollment_csectionid_FK FOREIGN KEY (csectionid)
REFERENCES course_section(csectionid));

SELECT table_name FROM user_tables;

DESC course;
DESC term;
DESC location;
DESC student;
DESC course_section;
DESC enrollment;

SELECT constraint_name, constraint_type, table_name, status FROM user_constraints;

INSERT INTO course
VALUES (1,'Database',3);

SELECT * FROM course;

INSERT INTO course_section (csectionid, maxcapacity, courseid, termid, locid)
VALUES (1,10,1,1,1);

-- CANNOT INSERT 'ITEM B' BECAUSE VIOLETED THE REFERENCIAL INTEGRITY WITH FK'S WHICH DO NOT EXIST (LOCID AND TERMID) IN REFERENCIAL TABLES. IT IS NECESSARY TO INSERT INTO THESE TABLES FIRST. 
-- SOLUTION: 

INSERT INTO term(termid, description, status)
VALUES (1,'WINTER TERM','OPEN');

SELECT * FROM term;

INSERT INTO location(locid, building, room)
VALUES (1,'MAIN','202');

SELECT * FROM location;

INSERT INTO course_section (csectionid, maxcapacity, courseid, termid, locid)
VALUES (14,10,1,1,1);

INSERT INTO course_section (csectionid, maxcapacity, courseid, termid, locid)
VALUES (15,10,1,1,1);

SELECT * FROM course_section;

INSERT INTO student(studid, sname, birthdate)
VALUES (1,'Francisco Ricardo', to_date('9-9-1982','dd-mm-yyyy'));

SELECT * FROM student;

INSERT INTO enrollment(studid, csectionid)
VALUES (1, 14);
INSERT INTO enrollment(studid, csectionid)
VALUES (1, 15);

SELECT * FROM enrollment;

UPDATE course_section 
SET maxcapacity = 25
WHERE csectionid = 15;

SELECT * FROM course_section;

SPOOL OFF;

