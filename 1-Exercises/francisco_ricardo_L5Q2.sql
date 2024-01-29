connect sys/sys as sysdba
CREATE USER francisco_ricardo_L5Q2 IDENTIFIED BY 123;
GRANT connect, resource TO francisco_ricardo_L5Q2;
CONNECT francisco_ricardo_L5Q2/123
SPOOL C:\BD1\francisco_ricardo_L5Q2.txt

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

SPOOL OFF;

