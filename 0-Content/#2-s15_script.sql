  -- Menu du jour
  -- Install ORACLE
  -- User, table creation
  -- Create SCRIPT, SPOOL file

  --  SQL = Structured Query Language
  -- to connect to the DBA account do:
connect sys/sys as sysdba
  -- to create a SPOOL file do:
SPOOL C:\BD1\s15_spool2.txt
SELECT to_char(sysdate,'DD Month YYYY Year Day HH:MI:SS Am')
FROM dual;

  -- to display the current connection do:
show user
  -- to remove an user do:
  -- Syntax: DROP USER name_of_user CASCADE ;
DROP USER yasser CASCADE;
  -- to create a user do:
  -- Syntax:  CREATE USER name_of_user IDENTIFIED BY  password ;
CREATE USER yasser IDENTIFIED BY 123;
  -- to provide needed permission do:
  -- Syntax:  GRANT connect, resource TO name_of_user ;
GRANT connect, resource TO yasser ;
  -- to display the name of all users of the database do:
SELECT username FROM dba_users;
  -- to change the password of an user do:
  -- Syntax: ALTER USER name_of_user IDENTIFIED BY password ;
ALTER USER hr IDENTIFIED BY hr ;
  -- to unlock an account do:
  -- Syntax:  ALTER USER name_of_user ACCOUNT UNLOCK;
ALTER USER hr ACCOUNT UNLOCK;
  -- to connect to a normal user do:
  -- Syntax:   connect name_of_user / password
connect yasser/123
show user
  -- Table creation
  -- Syntax: 
  -- CREATE TABLE name_of_table(column1 datatype, column2 datatype,...);
 -- Ex: Create the table of the design below using datatype NUMBER for ID, 
 -- VARCHAR2 for text and DATE for date
 -- MEMBER(mid, name, dob)
CREATE TABLE member(mid NUMBER, name VARCHAR2(40), dob DATE);
 -- to find out the name of all tables belonged to the current user do:
SELECT table_name FROM user_tables;
 -- to display the structure or definition of a table do:
 -- Syntax:  DESCRIBE name_of_table   or  DESC name_of_table
DESC member
 -- to remove a table do:
 -- Syntax: DROP name_of_table ;
DROP TABLE member ;




SPOOL OFF;
