CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
)



select * from sales
-- Data exploration
-- How many sales we have?
select count (*) as total_sales
from sales

-- How many unique customers we have?
select count (distinct customer_id) as total_customers
From sales

-- How many unique categories we have?
select count (distinct category) as total_customers
From sales

Select * from sales
where 
transactions_id	is null
or
sale_date is null
or
sale_time is null
or
customer_id	is null
or
gender is null
or
age	is null
or
category is null
or
quantiy	is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null

--Data Analysis and Business key problems & answers
---My Analysis & Findings

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
Select * from sales
where sale_date = '2022-11-05'

--2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022:
Select *
from sales
where category = 'Clothing' 
      and 
	  quantiy = 4 
	  and 
	  To_Char(sale_date, 'yyyy-mm') = '2022-11'

--Write a SQL query to calculate the total sales (total_sale) for each category.:
Select 
	Category,
	sum(total_sale) as sum_sale
from sales
group by 1

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

Select
	Avg(age) as avg_age
from sales
where 
	category = 'Beauty'

--Write a SQL query to find all transactions where the total_sale is greater than 1000.:
Select *
from sales
where 
total_sale > 1000

--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select 
	Count(transactions_id) as total_transac,
	gender,
	category
From sales
group by 2,3

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * From
(
Select
	Extract (year from sale_date) as sale_year,
	Extract (month from sale_date) as sale_month,
	Avg(total_sale) as avg_sale,
	Rank() over(partition by Extract (year from sale_date) order by Avg(total_sale) desc) as rank_sale
From sales
group by 1,2
) as t1
where rank_sale = 1

-- Write a SQL query to find the top 5 customers based on the highest total sales

Select 
	customer_id,
	sum(total_sale) as highest_sale
From sales
group by 1
order by 2 desc
limit 5

--Write a SQL query to find the number of unique customers who purchased items from each category.:
Select
	Count(distinct customer_id),
	category
from sales
group by 2

--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

with hourly_sale
as
(
select *,
	case when extract (hour from sale_time) < 12 then 'Morning'
     when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
	 else 'Evening'
	 end as shift
from sales
) 
select  
count (*) as number_orders,
shift
from hourly_sale
group by shift

--- End of the project




	









