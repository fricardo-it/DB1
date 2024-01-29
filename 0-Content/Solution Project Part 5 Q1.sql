-- Project Part 5

-- Question 1:
-- The following design is normalized to 3NF

-- Connect to user sys (sys/sys as sysdba)
connect sys/sys as sysdba

-- Create a user called your_name_L5Q1
CREATE USER Gabriel_L5Q1 IDENTIFIED BY 123;

-- Connect to the user just created to:
GRANT connect, resource TO Gabriel_L5Q1;
CONNECT Gabriel_L5Q1/123

-- Create a SPOOL file called your_name_L5Q1.
SPOOL C:\BD1\Gabriel_L5Q1.txt;

-- Create all the tables of the following final design using data type NUMBER for ID , VARCHAR2 for text , and DATE for dates.

-- COURSE(CourseID, CourseName, Credits)
CREATE TABLE course (courseid NUMBER, coursename VARCHAR2(20), credits NUMBER);

-- TERM(TermID, Description)
CREATE TABLE term (termid NUMBER, description VARCHAR2(40));

-- LOCATION(LocID, Building, Room)
CREATE TABLE location (locid NUMBER, building VARCHAR2(40), room NUMBER);

-- STUDENT(StudID, SName,Birthdate)
CREATE TABLE student (studid NUMBER, sname VARCHAR2(40), birthdate DATE);

-- COURSE_SECTION(CSectionID, MaxCapacity, CourseID, TermID, LocID)
CREATE TABLE course_section (csectionid NUMBER, maxcapacity NUMBER, courseid NUMBER,
 termid NUMBER, locid NUMBER);

-- ENROLLMENT(StudID, CSectionID,GRADE)
CREATE TABLE enrollment (studid NUMBER, csectionid NUMBER, grade NUMBER);

-- Create appropriate Primary Key for each table
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
ADD CONSTRAINT enroll_studid_csectionid_PK PRIMARY KEY (studid, csectionid);

-- Using the E.R.D below to create appropriate Foreign Key for each table if needed.

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

-- Make sure that CourseName, SName, Building, MaxCapacity, 
-- and Description ALWAYS has a value in it.

ALTER TABLE course
MODIFY (coursename CONSTRAINT course_coursename_NN NOT NULL) ;

ALTER TABLE student
MODIFY (sname CONSTRAINT student_sname_NN NOT NULL) ;

ALTER TABLE location
MODIFY (building CONSTRAINT location_building_NN NOT NULL) ;

ALTER TABLE course_section
MODIFY (maxcapacity CONSTRAINT course_section_maxcapacity_NN NOT NULL) ;

ALTER TABLE term
MODIFY (description CONSTRAINT term_description_NN NOT NULL) ;

-- Add column STATUS of datatype VARCHAR2(10) to table TERM and constraint 
-- CHECK to accept only this two values: OPEN or CLOSED.

ALTER TABLE term
ADD (status VARCHAR2(10));

ALTER TABLE term
ADD CONSTRAINT term_status_CK CHECK (Status in ('OPEN','CLOSED'));

-- Add a UNIQUE constraint to column room of table LOCATION.
ALTER TABLE location
ADD CONSTRAINT location_room_UK UNIQUE(room);


SELECT constraint_name, constraint_type, table_name, status FROM user_constraints;

SELECT table_name FROM user_tables;

desc course;
desc term;
desc location;
desc student;
desc course_section;
desc enrollment;

spool off;
