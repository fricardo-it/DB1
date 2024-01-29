connect sys/sys as sysdba
CREATE USER francisco_ricardo_L5Q1 IDENTIFIED BY 123;
GRANT connect, resource TO francisco_ricardo_L5Q1;
CONNECT francisco_ricardo_L5Q1/123
SPOOL C:\BD1\francisco_ricardo_L5Q1.txt

CREATE TABLE course(courseid NUMBER, coursename varchar2(40), credits number); 
CREATE TABLE term(termid NUMBER, description VARCHAR2(50));
CREATE TABLE location(locid NUMBER, building VARCHAR2(20), room NUMBER);
CREATE TABLE student(studid NUMBER, sname varchar2(50), birthdate DATE);
CREATE TABLE course_section(csectionid NUMBER, maxcapacity NUMBER, courseid NUMBER, termid number, locid number);
CREATE TABLE enrollment(studid NUMBER, csectionid NUMBER, grade NUMBER(3,2));

ALTER TABLE course
ADD CONSTRAINT course_courseid_PK PRIMARY KEY (courseid);
ALTER TABLE term
ADD CONSTRAINT term_termid_PK PRIMARY KEY (termid);
ALTER TABLE location
ADD CONSTRAINT location_locid_PK PRIMARY KEY (locid);
ALTER TABLE student
ADD CONSTRAINT student_studid_PK PRIMARY KEY (studid);
ALTER TABLE course_section
ADD CONSTRAINT course_section_csectionid_PK PRIMARY KEY (csectionid);
ALTER TABLE enrollment
ADD CONSTRAINT enroll_studid_csectionid_PK PRIMARY KEY (studid,csectionid);

ALTER TABLE course_section
ADD CONSTRAINT course_section_courseid_FK FOREIGN KEY (courseid)
REFERENCES course(courseid);
ALTER TABLE course_section
ADD CONSTRAINT course_section_termid_FK FOREIGN KEY (termid)
REFERENCES term(termid);
ALTER TABLE course_section
ADD CONSTRAINT course_section_locid_FK FOREIGN KEY (locid)
REFERENCES location(locid);
ALTER TABLE enrollment
ADD CONSTRAINT enrollment_studid_FK FOREIGN KEY (studid)
REFERENCES student(studid);
ALTER TABLE enrollment
ADD CONSTRAINT enrollment_csectionid_FK FOREIGN KEY (csectionid)
REFERENCES course_section(csectionid);

ALTER TABLE course
MODIFY(coursename CONSTRAINT course_coursename_NN NOT NULL);
ALTER TABLE student
MODIFY(sname CONSTRAINT student_sname_NN NOT NULL);
ALTER TABLE location
MODIFY(building CONSTRAINT location_building_NN NOT NULL);
ALTER TABLE course_section
MODIFY (maxcapacity CONSTRAINT course_section_maxcapacity_NN NOT NULL);
ALTER TABLE term
MODIFY(description CONSTRAINT term_description_NN NOT NULL);

ALTER TABLE term
ADD (status VARCHAR2(10));

ALTER TABLE term
ADD CONSTRAINT term_status_CK CHECK (status in ('OPEN','CLOSED'));

ALTER TABLE location
MODIFY (room CONSTRAINT location_room_UK UNIQUE);

SELECT table_name FROM user_tables;

DESC course;
DESC term;
DESC location;
DESC student;
DESC course_section;
DESC enrollment;

SELECT constraint_name, constraint_type, table_name, status FROM user_constraints;

SPOOL OFF;

