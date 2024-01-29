-- Q3
-- connect to sys as sysdba
connect sys/sys as sysdba

-- spool the output to a file
spool \\Mac\Home\Desktop\midTerm\amin_test.txt

-- create user and grant privileges
create user amin_test identified by 123;
grant connect, resource to amin_test;

-- connect to the new user
connect amin_test/123

-- create customer table
create table customer (custId number,custName varchar2(50));

-- create product table
create table product (productId number,description varchar2(50),price number);

-- create order table
create table orders (orderId number,orderDate date,custId number, payment varchar2(50));

-- create order Line table
create table orderLine (orderId number,productId number,quantity number);

-- add primaty keys
alter table customer 
add constraint pk_customer_custId primary key(custId);
alter table product 
add constraint pk_product_productId primary key(productId);
alter table orders 
add constraint pk_orders_orderId primary key(orderId);
alter table orderLine 
add constraint pk_orderLine primary key(orderId, productId);

-- add foreign keys
alter table orders 
add constraint fk_orders_custId foreign key(custId) 
references customer(custId);

alter table orderLine 
add constraint fk_orderLine_orderId 
foreign key(orderId) 
references orders(orderId);
alter table orderLine 
add constraint fk_orderLine_productId 
foreign key(productId) 
references product(productId);

-- add constarint not null to to custName and description
alter table customer 
modify (custName constarint customer_custName_nn not null);
alter table product 
modify (description constarint product_description_nn not null);

-- add column gender to customer table
alter table customer 
add gender char(1);
-- gender should be either M or F
alter table customer 
add constraint ck_customer_gender check (lower(gender) in ('m', 'f'));
--OR  add constraint ck_customer_gender check (gender IN ('M', 'F','m', 'f'));
-- make sure price is positive
alter table product add constraint ck_product_price check (price > 0);

-- add constraint UNIQUE to column payment in orders table
alter table orders 
add constraint uk_orders_payment unique (payment);

-- Q4
-- insert 1 row into all tables
insert into customer values (1, 'amin', 'M');
insert into product values (1, 'book', 10);
insert into orders values (1, sysdate, 1, 'cash');
insert into orderLine values (1, 1, 1);

-- Q5
-- we need to generate all pk and fk values automatically, so we need to create sequences
create sequence customer_seq start with 2 increment by 1;
create sequence product_seq start with 2 increment by 1;
create sequence orders_seq start with 2 increment by 1;
-- DONT NEED create sequence orderLine_seq start with 2 increment by 1;

-- insert 1 row into all tables using sequences
insert into customer values (customer_seq.nextval, 'amin seq', 'M');
insert into product values (product_seq.nextval, 'book seq', 10);
insert into orders values (orders_seq.nextval, sysdate, customer_seq.currval, 'credit');
insert into orderLine values (orders_seq.currval, product_seq.currval, 1);


-- Q6
-- display custName, orderDate, payment, description, price, quantity of all orders created by customer with custId = 1
select c.custName, o.orderDate, o.payment, p.description, p.price, ol.quantity
from customer c, orders o, product p, orderLine ol
where c.custId = o.custId
and o.orderId = ol.orderId
and ol.productId = p.productId
and c.custId = 1;

-- turn off spooling
spool off