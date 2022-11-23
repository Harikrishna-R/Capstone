1.
Select 
EXTRACT(DAY from order_received_timestamp) AS Day,
EXTRACT(MONTH from order_received_timestamp) AS Month,
EXTRACT(WEEK from order_received_timestamp) AS Week,
a.state AS State,
a.city AS City,
f.pincode AS Pincode,
avg(item_count) as avg_items


From  `pax-3-366517.ufh_dataset.fact_daily_orders` f
left join `pax-3-366517.ufh_dataset.dim_customer` c
  on f.customerid = c.customerid
left join `pax-3-366517.ufh_dataset.dim_address` a
  on c.address_id = a.address_id
group by Day, Month, Week, State, City, Pincode


2.
Select 
EXTRACT(DAY from order_received_timestamp) AS Day,
EXTRACT(MONTH from order_received_timestamp) AS Month,
EXTRACT(WEEK from order_received_timestamp) AS Week,
a.state AS State,
a.city AS City,
f.pincode AS Pincode,
avg(order_amount) as avg_sales


From  `pax-3-366517.ufh_dataset.fact_daily_orders` f
left join `pax-3-366517.ufh_dataset.dim_customer` c
  on f.customerid = c.customerid
left join `pax-3-366517.ufh_dataset.dim_address` a
  on c.address_id = a.address_id
group by Day, Month, Week, State, City, Pincode


3.
select
p.productname,p.sku,
EXTRACT(DAY from order_delivery_timestamp) Day,
EXTRACT(MONTH from order_delivery_timestamp) Month,
sum(quantity) as units_sold
From  `pax-3-366517.ufh_dataset.dim_product` p 
join `pax-3-366517.ufh_dataset.f_order_details` f
on p.productid = f.productid
group by productname,sku,Day,Month


4.
select 
EXTRACT(DATE from order_received_timestamp) AS Day,
o.productid,
a.city,
sum(order_amount) total_sales
from `pax-3-366517.ufh_dataset.fact_daily_orders` f
join `pax-3-366517.ufh_dataset.f_order_details` o on f.orderid = o.orderid 
join `pax-3-366517.ufh_dataset.dim_customer` c on f.customerid = c.customerid
join `pax-3-366517.ufh_dataset.dim_address` a on c.address_id = a.address_id
group by 
Day,
productid,
city
order by Day


5.
select 
a.state,
a.city,
count(distinct orderid) NumberOfOrders
from `pax-3-366517.ufh_dataset.fact_daily_orders` f
join `pax-3-366517.ufh_dataset.dim_customer` c on f.customerid = c.customerid
join `pax-3-366517.ufh_dataset.dim_address` a on c.address_id = a.address_id
group by 
state,city


6.
select 
customerid,
EXTRACT(DATE from order_received_timestamp) Date,
round(avg(order_amount),2) AS OrderAmount
from `pax-3-366517.ufh_dataset.fact_daily_orders` f
group by 
customerid,Date




7.
select 
Start_time,
count(customerid) NewCustomers
from `pax-3-366517.ufh_dataset.dim_customer`
where customerid in (select customerid from `pax-3-366517.ufh_dataset.dim_customer`
group by customerid having count(*)=1)
group by Start_time


8.
select distinct
EXTRACT(DATE from order_received_timestamp) Dates,
count(*) over (partition by EXTRACT(DATE from order_received_timestamp)) CustomerCounts
from `pax-3-366517.ufh_dataset.fact_daily_orders` f
group by 
order_received_timestamp
order by Dates


9.
select distinct
EXTRACT(DATE from order_delivery_timestamp) Dates,
EXTRACT(WEEK from order_delivery_timestamp) Weeks,
EXTRACT(DAYOFWEEK from order_delivery_timestamp) Weekdays,
EXTRACT(MONTH from order_delivery_timestamp) Months,
a.City,
Min(order_delivery_time_seconds) MinDeliveryTime,
max(order_delivery_time_seconds) MaxDeliveryTime,
avg(order_delivery_time_seconds) AvgDeliveryTime,
from `pax-3-366517.ufh_dataset.fact_daily_orders` f
join `pax-3-366517.ufh_dataset.dim_customer` c on f.customerid = c.customerid
join `pax-3-366517.ufh_dataset.dim_address` a on c.address_id = a.address_id
group by 
Dates,
Weeks,
Weekdays,
Months,
City


10.
select distinct
EXTRACT(DATE from order_delivery_timestamp) Dates,
EXTRACT(WEEK from order_delivery_timestamp) Weeks,
EXTRACT(DAYOFWEEK from order_delivery_timestamp) Weekdays,
EXTRACT(MONTH from order_delivery_timestamp) Months,
a.City,
count(orderid) NumberOfOrders
from `pax-3-366517.ufh_dataset.fact_daily_orders` f
join `pax-3-366517.ufh_dataset.dim_customer` c on f.customerid = c.customerid
join `pax-3-366517.ufh_dataset.dim_address` a on c.address_id = a.address_id
group by 
Dates,
Weeks,
Weekdays,
Months,
City