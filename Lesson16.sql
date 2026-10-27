create table if not exists Product (
  Product_Id integer primary key,
  Product_name VARCHAR(250),
  Category VARCHAR (250)
);

create table if not exists Sales(
  Sale_Id integer,
  Product_Id integer,
  Sale_date date,
  quantity_sold integer
);

insert into Product(Product_Id, Product_name, Category)
VALUES 
    (1, 'Laptop', 'Electronics'),
    (2, 'Smartphone', 'Electronics'),
    (3, 'Coffee Maker', 'Appliances'),
    (4, 'Running Shoes', 'Apparel');

insert into Sales (Sale_Id, Product_Id, Sale_date, quantity_sold)
values
(1, 1, '2023-01-05', 10),
(2, 2, '2023-01-10', 15),
(3, 3, '2023-01-15', 8),
(4, 4, '2023-01-20', 12),
(5, 1, '2023-02-05', 14),
(6, 2, '2023-02-12', 18),
(7, 3, '2023-02-18', 9),
(8, 4, '2023-02-25', 16),
(9, 1, '2023-03-06', 20),
(10, 2, '2023-03-11', 22),
(11, 3, '2023-03-16', 13),
(12, 4, '2023-03-24', 18),
(13, 1, '2023-04-05', 16),
(14, 2, '2023-04-10', 24),
(15, 3, '2023-04-18', 11),
(16, 4, '2023-04-28', 19),
(17, 1, '2023-05-07', 21),
(18, 2, '2023-05-12', 28),
(19, 3, '2023-05-19', 15),
(20, 4, '2023-05-26', 22),
(21, 1, '2023-06-04', 18),
(22, 2, '2023-06-13', 26),
(23, 3, '2023-06-21', 14),
(24, 4, '2023-06-29', 20),
(25, 1, '2024-01-06', 24),
(26, 2, '2024-01-11', 30),
(27, 3, '2024-01-17', 16),
(28, 4, '2024-01-23', 25),
(29, 1, '2024-02-04', 26),
(30, 2, '2024-02-09', 32),
(31, 3, '2024-02-15', 18),
(32, 4, '2024-02-21', 27),
(33, 1, '2024-03-03', 28),
(34, 2, '2024-03-10', 35),
(35, 3, '2024-03-18', 20),
(36, 4, '2024-03-26', 29),
(37, 1, '2024-04-05', 25),
(38, 2, '2024-04-13', 34),
(39, 3, '2024-04-19', 19),
(40, 4, '2024-04-27', 31),
(41, 1, '2024-05-06', 30),
(42, 2, '2024-05-14', 38),
(43, 3, '2024-05-20', 22),
(44, 4, '2024-05-29', 33),
(45, 1, '2024-06-04', 27),
(46, 2, '2024-06-12', 36),
(47, 3, '2024-06-18', 21),
(48, 4, '2024-06-25', 32),
(49, 1, '2024-06-28', 29),
(50, 2, '2024-06-30', 40);


---calculate the total sales for each product
---Write a SQL query using the SUM() OVER Window Functions to calculate the total sales for each product.

select Product.Product_name, Product.Product_Id, Sales.quantity_sold, Sales.Sale_date,
sum(Sales.quantity_sold) over(partition by Product.Product_Id) as total_sales
from Product
join Sales on Product.Product_Id = Sales.Product_Id
order by Product.Product_name, Sales.quantity_sold; 

---Analyze the monthly sales trend over the past years
--Develop a SQL query utilizing the SUM() OVER Function to analyze the monthly sales trend over the past years.

select distinct Product.Product_name, substr(Sales.Sale_date, 1, 7) as month,
sum(Sales.quantity_sold) OVER (partition by Product.Product_Id, substr(Sales.Sale_date, 1, 7)) as monthly_sales
from Sales
join Product on Sales.Product_Id = Product.Product_Id
order by month, Product.Product_name;

---Identify the top N products with the highest total sales
--Create a SQL query using the RANK() window function to identify the top N products with the highest total sales.

select P.Product_name, sum(s.quantity_sold) as total_sales
from Product p 
join Sales s on p.Product_Id = s.Product_Id 
group by p.Product_Id, p.Product_name;

with Product_Sales as (select P.Product_name, sum(s.quantity_sold) as total_sales
from Product p 
join Sales s on p.Product_Id = s.Product_Id 
group by p.Product_Id, p.Product_name
)
select Product_name, total_sales, 
rank() over(order by total_sales desc) as sales_rank
from Product_Sales 
order by sales_rank;