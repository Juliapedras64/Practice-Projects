create table if not exists customer_table(
  c_id integer Primary Key autoincrement
, c_name VARCHAR (100)
, c_location VARCHAR (100)
, c_phoneno integer
);

insert into customer_table(c_id, c_name, c_location, c_phoneno)
VALUES ('1111', 'Nisha', 'Kerala', '8392320'),
       ('1212', 'Oliver', 'Kerala','4353891'),
       ('1216', 'Nila', 'Delhi', '3323242'),
       ('1246', 'Vignesh', 'Chennai', '1111212'),
       ('1313', 'Shiny', 'Maharastra', '5454543'),
       ('1910', 'Mohan', 'Mumbai', '9023941'),
       ('2123', 'Biyush','Bomaby', '1253358'),
       ('3452', 'Alexander', 'West Bengal', '1212134'),
       ('3921', 'Mukesh', 'Manipur', '4232321'),
       ('5334', 'Christy', 'Pakistan', '2311111'),
       ('9021', 'Rithika', 'Kashmir', '1121344'),
       ('9212', 'Jessica', 'Banglore', '1233435'),
       ('9875', 'Stephen', 'Chennai', '1212133');

create table if not exists product_table(
   p_code integer Primary key references sales_table(p_code)
 , p_name VARCHAR (100) 
 , price integer 
 , stock integer
 , category VARCHAR (100)
);

create table if not exists sales_table(
   order_no VARCHAR (100) primary key
 , order_date date
 , c_id integer references customer_table(c_id)
 , c_name VARCHAR (100)
 , s_code integer
 , p_name VARCHAR (100)
 , qty integer
 , price integer
);

---Write a query to display the order ID, customer ID, order date, price, and quantity columns of the sales table---

select order_no, c_id, order_date, price, qty
from sales_table;

---Write a query to show details from the product table where the category is stationary---

select *
from product_table
where category like 'stationary';

---Write a query to display the unique categories in the product table---

select distinct category
from product_table;


---- fixing sales table because s_code = p_code---

alter table sales_table
rename column s_code to p_code;

---Write a query to display the product details in descending order of price---

select *
from product_table
order by price desc;

