--Question 2:
--Can you create all the tables, primary keys, foreign keys ... 
--of question 1 ALL at the same time? If yes, create a user 
--with your_name_L5Q2 to do so.


-- Connect to user sys (sys/sys as sysdba)
connect sys/sys as sysdba

-- Create a user called your_name_L5Q2
CREATE USER Gabriel_L5Q2 IDENTIFIED BY 123;

-- Connect to the user just created to:
GRANT connect, resource TO Gabriel_L5Q2;
CONNECT Gabriel_L5Q2/123

-- Create a SPOOL file called your_name_L5Q2.
SPOOL C:\BD1\Gabriel_L5Q2.txt;

-- Create all the tables of the following final design using data type 
-- NUMBER for ID , VARCHAR2 for text , and DATE for dates.


-- COURSE(CourseID, CourseName, Credits)
CREATE TABLE course (courseid NUMBER, coursename VARCHAR2(20)
CONSTRAINT course_coursename_NN NOT NULL, credits NUMBER,
CONSTRAINT course_courseID_PK PRIMARY KEY(courseID));

-- TERM(TermID, Description)
CREATE TABLE term (termid NUMBER, description VARCHAR2(40)
CONSTRAINT term_description_NN NOT NULL, status VARCHAR2(10),
CONSTRAINT term_termin_PK PRIMARY KEY(termid),
CONSTRAINT term_status_CK CHECK (Status in ('OPEN','CLOSED')));

-- LOCATION(LocID, Building, Room)
CREATE TABLE location (locid NUMBER, building VARCHAR2(40)
CONSTRAINT location_building_NN NOT NULL, room NUMBER,
CONSTRAINT loc_locid_PK PRIMARY KEY(locid),
CONSTRAINT location_room_UK UNIQUE(room));

-- STUDENT(StudID, SName,Birthdate)
CREATE TABLE student (studid NUMBER, sname VARCHAR2(40)
CONSTRAINT student_sname_NN NOT NULL, birthdate DATE,
CONSTRAINT stud_studid_PK PRIMARY KEY(studid));

-- COURSE_SECTION(CSectionID, MaxCapacity, CourseID, TermID, LocID)
CREATE TABLE course_section (csectionid NUMBER, maxcapacity NUMBER
CONSTRAINT cs_maxcapacity_NN NOT NULL, courseid NUMBER,
termid NUMBER, locid NUMBER,
CONSTRAINT cs_csectionid_PK PRIMARY KEY(csectionid),
CONSTRAINT cs_courseid_FK FOREIGN KEY (courseid)
REFERENCES course(courseid),
CONSTRAINT cs_termid_FK FOREIGN KEY (termid)
REFERENCES term(termid),
CONSTRAINT cs_locid_FK FOREIGN KEY (locid)
REFERENCES location(locid));

-- ENROLLMENT(StudID, CSectionID,GRADE)
CREATE TABLE enrollment (studid NUMBER, csectionid NUMBER, grade NUMBER,
CONSTRAINT enroll_studid_csectionid_PK PRIMARY KEY(studid,csectionid),
CONSTRAINT enroll_csectionid_FK FOREIGN KEY (csectionid)
REFERENCES course_section(csectionid),
CONSTRAINT enroll_studid_FK FOREIGN KEY (studid)
REFERENCES student(studid));

SELECT constraint_name, constraint_type, table_name, status FROM user_constraints;

SELECT table_name FROM user_tables;

desc course;
desc term;
desc location;
desc student;
desc course_section;
desc enrollment;


spool off;

SPOOL C:\BD1\Gabriel_L5Q3.txt;

--Question 3: We need the following data to be inserted in the database :
--a. A new course using the following values: 
-- Course Name : Database 
-- Credits: 3 
-- Id: 1 

INSERT INTO course (coursename, credits, courseid)
VALUES ('Database', 3 , 1);

-- b. Two new course_section using the following values: 
-- course_id : 1 
-- c_section_id : 14, 15 
-- term_id : 1
-- LOC_ID : 1 
-- Maximum capacity: 10

-- this isnt gonna work bc there is no value in termid and locid and they 
--  cannot be null.
-- In part b, if you can not insert data , explain why and give a solution.
-- solution // create termid 1 and locid 1
INSERT INTO term
VALUES (1, 'winter22', 'OPEN');

INSERT INTO location
VALUES (1, 'building1',301);

INSERT INTO course_Section 
VALUES (14, 10, 1, 1,1);

INSERT INTO course_Section 
VALUES (15, 10, 1, 1,1);


-- c. You are student number 1. You will be enrolled in both courses sections 
-- just inserted in part b, and have not yet received a note (GRADE = NULL) . 
-- Write the SQL statement for this event. 

insert into student
VALUES (1, 'Gabriel',null);

insert into enrollment
values (1,14,null);

insert into enrollment
values (1,15,null);

-- d. Change the maximum capacity of section 15 to 25

UPDATE course_section SET maxcapacity = 25 where csectionid = 15;

SELECT * FROM course;
SELECT * FROM term;
SELECT * FROM location;
SELECT * FROM student;
SELECT * FROM course_section;
SELECT * FROM enrollment;

spool off;

-- Question 4:
-- We would like to automatically generate all the values of the PK, FK .
-- Could you do that? If so, Please Re - do question 3 with the values 
-- of all the KEYS Auto- generated.

SPOOL C:\BD1\Gabriel_L5Q4.txt;
rollback;

CREATE SEQUENCE course_seq NOCACHE;
CREATE SEQUENCE term_seq NOCACHE;
CREATE SEQUENCE location_seq NOCACHE;
CREATE SEQUENCE student_seq NOCACHE;
CREATE SEQUENCE course_section_seq start with 14 NOCACHE;
CREATE SEQUENCE enrollment_seq NOCACHE;

-- a
INSERT INTO course
VALUES (course_seq.NEXTVAL, 'Database', 3);

-- b
INSERT INTO term
VALUES (term_seq.NEXTVAL, 'Winter23', 'OPEN');

INSERT INTO location
VALUES (location_seq.NEXTVAL, 'building1', 301);

INSERT INTO student
VALUES (student_seq.NEXTVAL, 'Gabriel', null);

INSERT INTO course_section
VALUES (course_section_seq.NEXTVAL, 10, course_seq.CURRVAL, term_seq.CURRVAL, location_seq.CURRVAL);

INSERT INTO enrollment
VALUES (student_seq.CURRVAL, course_section_seq.CURRVAL, null);

INSERT INTO course_section
VALUES (course_section_seq.NEXTVAL, 10, course_seq.CURRVAL, term_seq.CURRVAL, location_seq.CURRVAL);

INSERT INTO enrollment
VALUES (student_seq.CURRVAL, course_section_seq.CURRVAL, null);

-- d

UPDATE course_section
SET maxcapacity = 25 
WHERE csectionid = 15;

SELECT table_name FROM user_tables;

SELECT * FROM course;
SELECT * FROM term;
SELECT * FROM location;
SELECT * FROM student;
SELECT * FROM course_section;
SELECT * FROM enrollment;

spool off;