connect sys/sys as sysdba
DROP USER francisco_ricardo_test_Q5 CASCADE; 


connect sys/sys as sysdba
CREATE USER francisco_ricardo_test_Q5 IDENTIFIED BY 123;
GRANT connect, resource TO francisco_ricardo_test_Q5;
CONNECT francisco_ricardo_test_Q5/123
SPOOL C:\BD1\francisco_ricardo_test_Q5.txt

--create tables 
CREATE TABLE customer(custid NUMBER, custname VARCHAR2(50) CONSTRAINT customer_custname_NN NOT NULL, gender CHAR(1),
CONSTRAINT customer_custid_PK PRIMARY KEY (custid),
CONSTRAINT customer_gender_CK CHECK (gender in ('M','m','F','f')));

CREATE TABLE product(productid NUMBER, description VARCHAR2(50) CONSTRAINT product_description_NN NOT NULL, price NUMBER(10,2),
CONSTRAINT product_productid_PK PRIMARY KEY (productid),
CONSTRAINT product_price_CK CHECK (price >= 0));

CREATE TABLE orders(oid NUMBER, odate DATE, payment VARCHAR2(10) , custd NUMBER,
CONSTRAINT orders_oid_PK PRIMARY KEY (oid),
CONSTRAINT orders_custd_FK FOREIGN KEY (custd)
REFERENCES customer(custid),
CONSTRAINT orders_payment_UK UNIQUE (payment));

CREATE TABLE orders_line(productid NUMBER, oid NUMBER, quantity NUMBER,
CONSTRAINT orders_line_productid_oid_PK PRIMARY KEY (productid,oid),
CONSTRAINT orders_line_productid_FK FOREIGN KEY (productid)
REFERENCES product(productid),
CONSTRAINT orders_oid_FK FOREIGN KEY (oid)
REFERENCES orders(oid));

--list tables
SELECT table_name FROM user_tables;

--desc tables
DESC customer;
DESC product;
DESC orders;
DESC orders_line;

SELECT constraint_name, constraint_type, table_name, status FROM user_constraints;

-- insert values into the tables
INSERT INTO customer(custid, custname)
VALUES (1,'Francisco Ricardo');

SELECT * FROM customer;

INSERT INTO product(productid, description, price)
VALUES (1,'PRODUCT-1',1.99);

SELECT * FROM product;

INSERT INTO orders(oid, odate, payment, custd)
VALUES (1,sysdate,'CASH',1);

SELECT * FROM orders;

INSERT INTO orders_line(productid, oid, quantity)
VALUES (1,1,10);

SELECT * FROM orders_line;

CREATE SEQUENCE customer_seq START WITH 2 INCREMENT BY 1;
CREATE SEQUENCE product_seq START WITH 2 INCREMENT BY 1;
CREATE SEQUENCE orders_seq START WITH 2 INCREMENT BY 1;

-- insert values into the tables
INSERT INTO customer(custid, custname)
VALUES (customer_seq.NEXTVAL,'CUSTOMER A');

SELECT * FROM customer;

INSERT INTO product(productid, description, price)
VALUES (product_seq.NEXTVAL,'PRODUCT-A',1.99);

SELECT * FROM product;

INSERT INTO orders(oid, odate, payment, custd)
VALUES (orders_seq.NEXTVAL,sysdate,'CASH',customer_seq.CURRVAL);

SELECT * FROM orders;

INSERT INTO orders_line(productid, oid, quantity)
VALUES (product_seq.CURRVAL,orders_seq.CURRVAL,20);

SELECT * FROM orders_line;

SPOOL OFF;

