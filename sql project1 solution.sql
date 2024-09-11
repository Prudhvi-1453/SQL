-- select distinct category from retail_sales
select distinct category from retail_sales

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:

select * from retail_sales
where sale_date= '2022-11-05'


--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select *
from retail_sales
where quantity >2 and category= 'Clothing' and
to_char(sale_date, 'yyyy-mm')= '2022-11'


--Write a SQL query to calculate the total sales (total_sale) for each category.:

select category, sum(total_sale) as sales from retail_sales
group by category
order by sum(total_sale)

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

select category,avg(age)
from retail_sales
where category='Beauty'
group by category


--Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select transactions_id , total_sale from retail_sales
where total_sale >1000


--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select category,gender,count(transactions_id)
from retail_sales
group by category,gender
order by category

--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select year,month,avg_sales
from (
	select extract(year from sale_date) as year,
		   extract(month from sale_date) as month,
		   avg(total_sale)as avg_sales,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
	from retail_sales
	group by 1,2
)
where rank=1

--Write a SQL query to find the top 5 customers based on the highest total sales **:

select customer_id, sum(total_sale)
from retail_sales
group by customer_id
order by sum(total_sale) desc
limit 5


--Write a SQL query to find the number of unique customers who purchased items from each category.:

select category,count(distinct(customer_id))
from retail_sales
group by category


--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

with hourly_sales
AS (
	SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM SALE_TIME) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM SALE_TIME) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS shift
	from RETAIL_SALES
)

SELECT shift,COUNT(*)
from hourly_sales
group by shift;





