use [pizza DB]
select *from pizza_sales;
SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'pizza_sales';

-- total revenue
select sum(total_price) as total_revenue from pizza_sales;

-- average order value
select sum(total_price)/ count(distinct order_id) as avg_order_value from pizza_sales;

-- total pizzas sold
select sum(quantity) as total_pizza_sold from pizza_sales;

-- total orders
select count(distinct order_id) as total_orders from pizza_sales;

-- average pizzas per order
select sum(quantity)/count(distinct order_id) as average_piiza_sold
from pizza_sales;

-- another way
select cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2)) as avg_pizza_order from pizza_sales;

-- trend of orders by day
select datename(dw,order_date) as order_day, count(distinct order_id) as total_orders
from pizza_sales
group by datename(dw,order_date)
order by total_orders desc;


-- trend of orders by month
select month(order_date) as order_month, count(distinct order_id) as total_orders
from pizza_sales
group by month(order_date)
-- another way
select datename(month,order_date) as order_month, count(distinct order_id) as total_orders
from pizza_sales
group by datename(month,order_date)
order by total_orders desc;

-- 
select count(pizza_category) as number from pizza_sales;
select count(distinct pizza_category) as number from pizza_sales;
--select (pizza_category) as category, sum(quantity) as total_order
--from pizza_sales
--group by (pizza_category);


-- pct by pizza_category
select pizza_category,cast(sum(total_price) as decimal(10,2)) as total_revenue, sum(total_price)*100/(select sum(total_price) from pizza_sales) as pct
from pizza_sales
group by pizza_category;

-- pct by pizza size quarterly report for 1st quarter by suing datepart func
select pizza_size, cast(sum(total_price) as decimal(10,2)) as total_revenue,sum(total_price)*100/(select sum(total_price) from pizza_sales where datepart(quarter,order_date)=1) as pct_size
from pizza_sales
where datepart(quarter,order_date)=1
group by pizza_size
order by pct_size;

-- Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


-- top 5 bestsellers by revenue, by total qunatity as well as the total orders
select distinct pizza_name_id from pizza_sales;
select count(distinct pizza_name_id) from pizza_sales;

select top 5 pizza_name, sum(total_price) as revenue 
from pizza_sales
group by pizza_name
order by revenue desc;

select top 5 pizza_name, sum(quantity) as total_qty
from pizza_sales
group by pizza_name
order by total_qty desc;


select top 5 pizza_name,count( distinct order_id) as order_sales
from pizza_sales
group by pizza_name
order by order_sales desc;

-- bottom 5 pizza as per the above given conditions
select top 5 pizza_name, sum(total_price) as revenue 
from pizza_sales
group by pizza_name
order by revenue asc;

select top 5 pizza_name, sum(quantity) as total_qty
from pizza_sales
group by pizza_name
order by total_qty asc;

select top 5 pizza_name,count( distinct order_id) as order_sales
from pizza_sales
group by pizza_name
order by order_sales asc;