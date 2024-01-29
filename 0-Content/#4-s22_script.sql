  -- Menu du jour
  -- Create Primary Key, Foreign key at table creation time
  -- BREAK
  -- Continue with Project Part 2, Part3.
  -- A la casa

  -- Example 1:  Create all tables of the design below with all the Primary
  -- key, and Foreign key created at table creation time (table and key create
  -- at the same time).  Note that all tables are belonged to the user luis, and
  -- the name of the spool file is s22_spool.txt
  --     MEMBER(MID, name)
  --     VIDEO(VID, title, rating)
  --     RENTAL(MID,VID, date_rent, date_return

     --    MEMBER ---E RENTAL 3--- VIDEO
  -- Solution:
  -- connect to an dba account
connect sys/sys as sysdba
  -- create spool
SPOOL C:\BD1\s22_spool.txt
  -- display current time
SELECT to_char(sysdate,'DD Month YYYY Day HH:MI:SS Am') FROM dual;
  -- find out the name of all users
SELECT username FROM dba_users;
  -- create user luis
CREATE USER luis IDENTIFIED BY 123;
  -- provide needed privileges
GRANT connect, resource TO luis;
  -- connect user luis to the database
CONNECT luis/123
  -- Column level:
  -- Syntax: 
  -- CREATE TABLE name_of_table(column1 DATATYPE CONSTRAINT name_of_constraint PRIMARY KEY,
  --                              column2 DATATYPE, ... );
CREATE TABLE member (mid NUMBER CONSTRAINT member_mid_PK PRIMARY KEY, name VARCHAR2(20));
CREATE TABLE video (vid NUMBER CONSTRAINT video_vid_PK PRIMARY KEY, title VARCHAR2(20),
                        rating VARCHAR2(20));
CREATE TABLE rental (mid NUMBER CONSTRAINT rental_mid_PK PRIMARY KEY, 
                     vid NUMBER CONSTRAINT rental_vid_PK PRIMARY KEY, 
                     date_rent DATE, date_return DATE);

--  NO NO NO NO composit primary key MUST BE at table level (also FOREIGN KEY)
   CREATE TABLE rental (mid NUMBER, vid NUMBER, date_rent DATE, date_return DATE ,
         CONSTRAINT rental_mid_vid_PK PRIMARY KEY(mid,vid) );

 -- Syntax for foreign key:
 -- CREATE TABLE name_of_table (column1 DATATYPE, colunm2 DATATYPE, ...  ,
 --  CONSTRAINT name_of_constraint FOREIGN KEY (name_of_child_column)
 --  REFERENCES name_of_parent_table(name_of_unique_column)  ); 
 -- remove table rental
DROP TABLE rental CASCADE CONSTRAINTS; 
 -- re-create table rental with pk and 2 fk.
CREATE TABLE rental (mid NUMBER, vid NUMBER, date_rent DATE, date_return DATE ,
  CONSTRAINT rental_mid_vid_PK PRIMARY KEY(mid,vid),
  CONSTRAINT rental_mid_FK FOREIGN KEY(mid)
  REFERENCES member(mid) ,
  CONSTRAINT rental_vid_FK FOREIGN KEY(vid)
  REFERENCES video(vid));

SELECT constraint_name, constraint_type, table_name, status FROM user_constraints;
  -- remove table member
DROP TABLE member CASCADE CONSTRAINT;

CREATE TABLE member (mid NUMBER, name VARCHAR2(40),
     CONSTRAINT member_mid_PK PRIMARY KEY(mid) );

SPOOL OFF;


 