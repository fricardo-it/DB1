-- Create table STUDENT using the design below:
--  STUDENT (SID, name)
  CREATE TABLE student(sid NUMBER, name VARCHAR2(20));
-- Add column birthdate and phone to table student
  ALTER TABLE student
  ADD (birthdate DATE);
  ALTER TABLE student
  ADD (phone NUMBER(10));
-- Remove column birthdate from table student
  ALTER TABLE student
  DROP COLUMN birthdate;