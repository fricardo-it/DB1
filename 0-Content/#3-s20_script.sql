-- Add PRIMARY KEY and FOREIGN KEY
  -- After Table creation time
  -- At table creation time

-- Syntax: ALTER TABLE name_of_table
--         ADD CONSTRAINT name_of_constraint PRIMARY KEY (name_of_column);
-- Ex1:  Create a user named amin and all tables using appropriate datatype
--       of the design below: (name the spool file sep20_spool.txt)

  --     MEMBER(MID, name)
  --     VIDEO(VID, title, rating)
  --     RENTAL(MID,VID, date_rent, date_return
connect sys/sys as sysdba
SPOOL C:\BD1\sep20_spool.txt
SELECT to_char(sysdate,'DD Month Year Day HH:MI:SS Am') FROM dual;
DROP USER amin CASCADE;
CREATE USER amin IDENTIFIED BY 123;
GRANT connect, resource TO amin;
CONNECT amin/123
SHOW USER
CREATE TABLE member(mid NUMBER, name VARCHAR2(50));
CREATE TABLE video(vid NUMBER, title VARCHAR2(50),rating VARCHAR(50));
CREATE TABLE rental(mid NUMBER, vid NUMBER, date_rent DATE, date_return DATE);

-- Ex2:  Add primary key to each table
ALTER TABLE member
ADD CONSTRAINT member_mid_PK PRIMARY KEY (mid);
ALTER TABLE video
ADD CONSTRAINT video_vid_PK PRIMARY KEY (vid);
ALTER TABLE rental
ADD CONSTRAINT rental_mid_vid_PK PRIMARY KEY (mid,vid);

-- Ex3: Using the E.R.D below add all foreign keys to table rental
--   
--              MEMBER ---E RENTAL 3---  VIDEO

--  Syntax:  ALTER TABLE name_of_table
--           ADD CONSTRAINT name_of_constraint FOREIGN KEY (child_column_name)
--           REFERENCES  name_of_parent_table (parent_column_name)  ;

ALTER TABLE rental
ADD CONSTRAINT rental_mid_FK FOREIGN KEY (mid)
REFERENCES member (mid) ;

ALTER TABLE rental
ADD CONSTRAINT rental_vid_FK FOREIGN KEY (vid)
REFERENCES video (vid) ;

SELECT constraint_name, constraint_type, table_name, status
FROM user_constraints;




  










SPOOL OFF;