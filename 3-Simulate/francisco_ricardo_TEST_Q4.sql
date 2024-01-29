DROP USER francisco_ricardo_test_Q4 CASCADE


connect sys/sys as sysdba
CREATE USER francisco_ricardo_test_Q4 IDENTIFIED BY 123;
GRANT connect, resource TO francisco_ricardo_test_Q4;
CONNECT francisco_ricardo_test_Q4/123
SPOOL C:\BD1\francisco_ricardo_test_Q4.txt

--create tables 
CREATE TABLE customer(custid NUMBER, custname VARCHAR2(50));
CREATE TABLE product(productid NUMBER, description VARCHAR2(50), price NUMBER(10,2));
CREATE TABLE orders(oid NUMBER, odate DATE, payment VARCHAR2(10), custd NUMBER);
CREATE TABLE orders_line(productid NUMBER, oid NUMBER, quantity NUMBER);

--create PKs
ALTER TABLE customer
ADD CONSTRAINT customer_custid_PK PRIMARY KEY (custid);
ALTER TABLE product
ADD CONSTRAINT product_productid_PK PRIMARY KEY (productid);
ALTER TABLE orders
ADD CONSTRAINT orders_oid_PK PRIMARY KEY (oid);
ALTER TABLE orders_line
ADD CONSTRAINT orders_line_productid_oid_PK PRIMARY KEY (productid,oid);

--create FKs
ALTER TABLE orders
ADD CONSTRAINT orders_custd_FK FOREIGN KEY (custd)
REFERENCES customer(custid);
ALTER TABLE orders_line
ADD CONSTRAINT orders_line_productid_FK FOREIGN KEY (productid)
REFERENCES product(productid);
ALTER TABLE orders_line
ADD CONSTRAINT orders_oid_FK FOREIGN KEY (oid)
REFERENCES orders(oid);

--add/modify constraints NN
ALTER TABLE customer
MODIFY(custname CONSTRAINT customer_custname_NN NOT NULL);
ALTER TABLE product
MODIFY(description CONSTRAINT product_description_NN NOT NULL);

--add column
ALTER TABLE customer
ADD (gender CHAR(1));

--create CK
ALTER TABLE customer
ADD CONSTRAINT customer_gender_CK CHECK (gender in ('M','m','F','f'));
ALTER TABLE product
ADD CONSTRAINT product_price_CK CHECK (price >= 0);

--create UK
ALTER TABLE orders
ADD CONSTRAINT orders_payment_UK UNIQUE (payment);

--list tables
SELECT table_name FROM user_tables;

--desc tables
DESC customer;
DESC product;
DESC orders;
DESC orders_line;

-- list constraints
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

SPOOL OFF;

