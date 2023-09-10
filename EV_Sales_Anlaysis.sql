select * from sales;
-- Validating the drop in sales for Sprint Scooters 
with cumulative_sum_sales as (
select date(sales_transaction_date) as 'Sales_Date', count(customer_id) as 'Number_of_units_sold',
sum(count(customer_id)) over(order by date(sales_transaction_date)) as 'Cumulative_Sales',
sum(count(customer_id)) over(order by date(sales_transaction_date) rows between 6 preceding and current row) as
'_7Days_Cumulative_Sum' from sales 
where product_id = 7 and date(sales_transaction_date) between '2016-10-10' and '2016-10-31'
group by date(sales_transaction_date) 
),
sales_growth_volume as (
select *, lag(_7Days_Cumulative_Sum) over(order by(Sales_Date)) as'prior_7Days_Cumulative_Sum'  from cumulative_sum_sales
)

select Sales_Date as 'Date', Number_of_units_sold as 'Unit Sold', _7Days_Cumulative_Sum as 'Cumm Total 7D'
, prior_7Days_Cumulative_Sum as 'Cumm Total 7D_Prev'
,round(coalesce((_7Days_Cumulative_Sum - prior_7Days_Cumulative_Sum)/prior_7Days_Cumulative_Sum, 0)*100,2) -- Computing the growth volume for Sprint Scooter
as 'Growth %'
from sales_growth_volume ;  

select * from products where product_id = 8 limit 1; -- finding the start of production date for Sprint LE
-- Calculating the  growth volume for the Sprint LE Scooter
with cumulative_sum_sales_LE as (
select date(sales_transaction_date) as 'Sales_Date_LE', count(customer_id) as 'Number_of_units_sold_LE',
sum(count(customer_id)) over(order by date(sales_transaction_date)) as 'Cumulative_Sales_LE',
sum(count(customer_id)) over(order by date(sales_transaction_date) rows between 6 preceding and current row) as
'_7Days_Cumulative_Sum_LE' from sales 
where product_id = 8 and date(sales_transaction_date) between '2017-02-15' and '2017-03-08'
group by date(sales_transaction_date) 
),
sales_growth_volume_LE as (
select *, lag(_7Days_Cumulative_Sum_LE) over(order by(Sales_Date_LE)) as'prior_7Days_Cumulative_Sum_LE'  from cumulative_sum_sales_LE
)

select *
,round(coalesce((_7Days_Cumulative_Sum_LE - prior_7Days_Cumulative_Sum_LE)/prior_7Days_Cumulative_Sum_LE, 0)*100,2) 
as Sales_Growth_Percentage_LE
from sales_growth_volume_LE;

-- Comparing the growth volume for the first three weeks after launch for both Sprint & Sprint LE Scooter to validate the assumption of Launch Date   
with cumulative_sum_sales as (
select row_number() over(order by date(Sales_Date)) as Days,
date(sales_transaction_date) as 'Sales_Date', count(customer_id) as 'Number_of_units_sold',
sum(count(customer_id)) over(order by date(sales_transaction_date)) as 'Cumulative_Sales',
sum(count(customer_id)) over(order by date(sales_transaction_date) rows between 6 preceding and current row) as
'_7Days_Cumulative_Sum' from sales 
where product_id = 7 and date(sales_transaction_date) between '2016-10-10' and '2016-10-31'
group by date(sales_transaction_date) 
),
sales_growth_volume as (
select *,lag(_7Days_Cumulative_Sum) over(order by(Sales_Date)) as'prior_7Days_Cumulative_Sum'  from cumulative_sum_sales
),
cumulative_sum_sales_LE as (
select row_number() over(order by date(Sales_Date_LE)) as Days,  
date(sales_transaction_date) as 'Sales_Date_LE', count(customer_id) as 'Number_of_units_sold_LE',
sum(count(customer_id)) over(order by date(sales_transaction_date)) as 'Cumulative_Sales_LE',
sum(count(customer_id)) over(order by date(sales_transaction_date) rows between 6 preceding and current row) as
'_7Days_Cumulative_Sum_LE' from sales 
where product_id = 8 and date(sales_transaction_date) between '2017-02-15' and '2017-03-08'
group by date(sales_transaction_date) 
),
sales_growth_volume_LE as (
select *, lag(_7Days_Cumulative_Sum_LE) over(order by(Sales_Date_LE)) as'prior_7Days_Cumulative_Sum_LE'  from cumulative_sum_sales_LE
)
-- End of Common Table Expressions 
select t1.Days as'Day', t1.Number_of_units_sold as 'Sprint', t2.Number_of_units_sold_LE as 'Sprint LE',
t1._7Days_Cumulative_Sum as 'Sprint CL7',t2._7Days_Cumulative_Sum_LE as 'Sprint LE CL7',
t1.prior_7Days_Cumulative_Sum as 'Previous Sprint CL7', t2.prior_7Days_Cumulative_Sum_LE as 'Previous Sprint LE CL7',
round(coalesce((t1._7Days_Cumulative_Sum - t1.prior_7Days_Cumulative_Sum)/t1.prior_7Days_Cumulative_Sum, 0)*100,2) 
as 'Sprint Growth %',
round(coalesce((t2._7Days_Cumulative_Sum_LE - t2.prior_7Days_Cumulative_Sum_LE)/t2.prior_7Days_Cumulative_Sum_LE, 0)*100,2) 
as 'SprintLE Growth %'
from sales_growth_volume as t1
left join sales_growth_volume_LE as t2 on t1.Days = t2.Days;

-- Email Summary for Sprint Campaign Analysis  
select * from emails;
select distinct(sent_dates) from emails;
select * from emails where date(sent_date) between '2016-07-22' and '2016-09-22';
select count(customer_id) as 'Email Sent' from emails where email_subject_id = 7;
select count(opened) as 'Opened' from emails
where email_subject_id = 7 and opened = 't';
select count(clicked) as 'Clicked' from emails
where email_subject_id = 7 and clicked = 't';
select count(bounced) as 'Bounced' from emails
where email_subject_id = 7 and bounced = 't';
-- KPI for Campaign Performance 
select round(((select count(opened)from emails where email_subject_id = 7 and opened = 't')/ count(customer_id))*100,2) 
as 'Opened Percentage Value'
from emails
where email_subject_id = 7 ;
select round(((select count(clicked)from emails where email_subject_id = 7 and clicked = 't')/ count(customer_id))*100,2) 
as 'Clicked Percentage Value'
from emails
where email_subject_id = 7 ;
