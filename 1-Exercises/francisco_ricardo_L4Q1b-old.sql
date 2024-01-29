connect sys/sys as sysdba
CREATE USER francisco_ricardo_L4Q1b IDENTIFIED BY 123;
GRANT connect, resource TO francisco_ricardo_L4Q1b;
CONNECT francisco_ricardo_L4Q1b/123
SPOOL C:\BD1\francisco_ricardo_L4Q1b.txt

CREATE TABLE customer(custid NUMBER,phone varchar2(10), custname VARCHAR2(50) CONSTRAINT customer_custname_NN NOT NULL, 
CONSTRAINT customer_custid_PK PRIMARY KEY (custid));
      
CREATE TABLE supplier(supplierid NUMBER, suppliername VARCHAR2(50) CONSTRAINT supplier_suppliername_NN NOT NULL,
CONSTRAINT supplier_supplierid_PK PRIMARY KEY (supplierid));

CREATE TABLE orders(oid NUMBER, odate DATE, custid NUMBER,
CONSTRAINT orders_oid_PK PRIMARY KEY (oid),
CONSTRAINT customer_custid_FK FOREIGN KEY (custid)
REFERENCES customer(custid));

CREATE TABLE product(productid NUMBER, description varchar2(50) CONSTRAINT product_description_NN NOT NULL, price NUMBER (10,2), supplierid NUMBER,
CONSTRAINT product_price_CK CHECK ( price >= 0),
CONSTRAINT product_productid_PK PRIMARY KEY (productid),
CONSTRAINT supplier_supplierid_FK FOREIGN KEY (supplierid)
REFERENCES supplier(supplierid));

CREATE TABLE order_line(productid NUMBER, oid NUMBER, quantity NUMBER,
CONSTRAINT order_line_productid_oid_PK PRIMARY KEY (productid,oid),
CONSTRAINT order_line_productid_FK FOREIGN KEY (productid)
REFERENCES product(productid),
CONSTRAINT order_line_oid_FK FOREIGN KEY (oid)
REFERENCES orders(oid));

SELECT table_name FROM user_tables;

DESC customer;
DESC supplier;
DESC orders;
DESC product;
DESC order_line;

SELECT constraint_name, constraint_type, table_name, status FROM user_constraints;

SPOOL OFF;