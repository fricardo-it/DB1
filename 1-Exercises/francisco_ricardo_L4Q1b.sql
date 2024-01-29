connect sys/sys as sysdba
CREATE USER francisco_ricardo_L4Q1b IDENTIFIED BY 123;
GRANT connect, resource TO francisco_ricardo_L4Q1b;
CONNECT francisco_ricardo_L4Q1b/123
SPOOL C:\BD1\francisco_ricardo_L4Q1b.txt

CREATE TABLE customer(custid NUMBER,phone varchar2(10), custname VARCHAR2(50)); 
CREATE TABLE supplier(supplierid NUMBER, suppliername VARCHAR2(50));
CREATE TABLE orders(oid NUMBER, odate DATE, custid NUMBER);
CREATE TABLE product(productid NUMBER, description varchar2(50), price NUMBER (10,2));
CREATE TABLE order_line(productid NUMBER, oid NUMBER, quantity NUMBER);

ALTER TABLE customer
ADD CONSTRAINT customer_custid_PK PRIMARY KEY (custid);
ALTER TABLE supplier
ADD CONSTRAINT supplier_supplierid_PK PRIMARY KEY (supplierid);
ALTER TABLE orders
ADD CONSTRAINT orders_oid_PK PRIMARY KEY (oid);
ALTER TABLE product
ADD CONSTRAINT product_productid_PK PRIMARY KEY (productid);
ALTER TABLE order_line
ADD CONSTRAINT order_line_productid_oid_PK PRIMARY KEY (productid,oid);


ALTER TABLE customer
ADD CONSTRAINT customer_custid_PK PRIMARY KEY (custid);
ALTER TABLE supplier
ADD CONSTRAINT supplier_supplierid_PK PRIMARY KEY (supplierid);
ALTER TABLE orders
ADD CONSTRAINT orders_oid_PK PRIMARY KEY (oid);
ALTER TABLE product
ADD CONSTRAINT product_productid_PK PRIMARY KEY (productid);
ALTER TABLE order_line
ADD CONSTRAINT order_line_productid_oid_PK PRIMARY KEY (productid,oid);

ALTER TABLE orders
ADD CONSTRAINT orders_custid_FK FOREIGN KEY (custid)
REFERENCES customer(custid);
ALTER TABLE product
ADD (supplierid NUMBER);
ALTER TABLE product
ADD CONSTRAINT product_supplierid_FK FOREIGN KEY (supplierid)
REFERENCES supplier(supplierid);
ALTER TABLE order_line
ADD CONSTRAINT order_line_productid_FK FOREIGN KEY (productid)
REFERENCES product(productid);
ALTER TABLE order_line
ADD CONSTRAINT order_line_oid_FK FOREIGN KEY (oid)
REFERENCES orders(oid);

ALTER TABLE customer
MODIFY(custname CONSTRAINT customer_custname_NN NOT NULL) ;

ALTER TABLE supplier
MODIFY(suppliername CONSTRAINT supplier_suppliername_NN NOT NULL) ;

ALTER TABLE product
MODIFY(description CONSTRAINT product_description_NN NOT NULL) ;

ALTER TABLE product
ADD CONSTRAINT product_price_CK CHECK (price >= 0);

SELECT table_name FROM user_tables;

DESC customer;
DESC supplier;
DESC orders;
DESC product;
DESC order_line;

SELECT constraint_name, constraint_type, table_name, status FROM user_constraints;

SPOOL OFF;