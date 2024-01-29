connect sys/sys as sysdba
CREATE USER francisco_ricardo_L3Q1 IDENTIFIED BY 123;
GRANT connect, resource TO francisco_ricardo_L3Q1;
CONNECT francisco_ricardo_L3Q1/123
SPOOL C:\BD1\francisco_ricardo_L3Q1.txt
CREATE TABLE customer(custid NUMBER, custname VARCHAR2(50), phone varchar2(10));
CREATE TABLE orders(oid NUMBER, odate DATE, custid NUMBER);
CREATE TABLE product(productid NUMBER, description varchar2(50), price NUMBER(10,2));
CREATE TABLE order_line(productid NUMBER, oid NUMBER, quantity NUMBER);
DESC customer;
DESC orders;
DESC product;
DESC order_line;
SPOOL OFF;