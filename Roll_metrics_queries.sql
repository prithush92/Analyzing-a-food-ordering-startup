USE rollfiesta;

SELECT * FROM driver;
SELECT * FROM ingredients;
SELECT * FROM rolls;
SELECT * FROM rolls_recipes;
SELECT * FROM driver_order;
SELECT * FROM customer_orders;

-- ROLL METRICS
-- 1.How many rolls were ordered?
SELECT count(roll_id) as rolls_ordered
FROM customer_orders;

-- 2 How many unique customer orders were made?
SELECT COUNT(DISTINCT customer_id) as unique_customer
from customer_orders;

-- 3.How many successful  orders were delivered by driver?
SELECT driver_id, SUM(New_Cancellation)cnt FROM
(SELECT driver_id,
CASE WHEN cancellation IN ('cancellation','customer cancellation') THEN 0 ELSE 1 END AS New_Cancellation
FROM driver_order)a
GROUP BY driver_id;

-- 4. HOW MANY OF EACH TYPE OF ROLL WERE DELIVERED?
WITH temp_driver_order(order_id,driver_id,category) AS
(
SELECT order_id,driver_id,
CASE WHEN cancellation ='Cancellation' OR cancellation ='Customer Cancellation' THEN'Cancel' 
ELSE 'Not cancel' END AS Category
FROM driver_order)
, 
join_table (customer_id,roll_id,category) as
(SELECT c.order_id,c.roll_id,t.category
FROM customer_orders as c
JOIN temp_driver_order as t
on t.order_id=c.order_id)

SELECT roll_name,count(r.roll_id) AS total_roll_delivered
FROM rolls as r
JOIN join_table j
ON r.roll_id=j.roll_id
WHERE category='Not Cancel'
GROUP BY roll_name;


-- 5.How many veg and non-veg were ordered by each customer
SELECT  customer_id,r.roll_id,roll_name,count(r.roll_id)
FROM customer_orders as c
JOIN rolls as r
on c.roll_id=r.roll_id
group by customer_id,r.roll_id,roll_name
ORDER BY roll_name desc;

-- 6. What was the maximum number of rolls were delivered in a single order?
WITH temp_driver_order(order_id,driver_id,category) AS
(
SELECT order_id,driver_id,
CASE WHEN cancellation ='Cancellation' OR cancellation ='Customer Cancellation' THEN'Cancel' 
ELSE 'Not cancel' END AS Category
FROM driver_order)


SELECT t.order_id,count(*) as max_rolls_delivered 
FROM temp_driver_order as t
JOIN customer_orders  as c
on t.order_id=c.order_id
where category='Not Cancel'
group by t.order_id
order by max_rolls_delivered  desc
limit 1;


-- 7.For each customer ,how many delivered atleast one change and how many had no change.?

WITH temp_t
(orders_id,driver_id,distance,new_cancellation)
AS (SELECT order_id,driver_id,distance,CASE WHEN cancellation ='Cancellation' OR cancellation='Customer Cancellation' then 'Cancel'
ELSE 'Not Cancel' END AS CNC
FROM driver_order) 

SELECT final.customer_id,final.case_count,COUNT(orders_id) AS count_order_id
FROM
(SELECT *,
CASE WHEN ff.no_include='No Change' AND ff.extra_include='No Change' THEN "NO Change"
ELSE " Atleast one Change" END Case_count
FROM
(select * from temp_t T
JOIN
(SELECT order_id,customer_id,
CASE WHEN not_include_items IS NULL OR not_include_items =''  THEN 'No Change'
else 'Change' end as no_include,
CASE WHEN extra_items_included IS NULL OR extra_items_included ='' OR extra_items_included = 'NaN' THEN 'No Change'
ELSE 'Change' END AS extra_include
FROM CUSTOMER_ORDERS) T1
ON T.orders_id=T1.order_id
WHERE new_cancellation = 'Not Cancel') ff) final
GROUP BY final.customer_id,final.Case_count;

-- 8. HOW MANY ROLLS WERE DELIVERED THAT HAD BOTH EXCLUSIONS AND EXTRAS 

WITH temp_t
(orders_id,driver_id,distance,new_cancellation)
AS (select order_id,driver_id,distance,
CASE WHEN cancellation ='Cancellation' OR cancellation='Customer Cancellation' then 'Cancel'
ELSE 'Not Cancel' end as CNC
from driver_order),
 
table1
(Order_id,customer_id,roll_id,exclude_items,include_items)
AS
(SELECT Order_id,customer_id,roll_id,
CASE WHEN not_include_items='' OR  not_include_items IS NULL OR not_include_items='NaN' THEN "No Change" 
ELSE "Exclude_change"  END AS exclude_items,
CASE WHEN extra_items_included='' OR extra_items_included IS NULL OR extra_items_included='NaN' THEN "No Change"
ELSE "Add_items_change" END AS include_items
FROM CUSTOMER_ORDERS)

SELECT COUNT(*) as total_exclude_include_items
FROM temp_t T 
JOIN table1 T1
ON T.orders_id=T1.order_id
WHERE exclude_items='Exclude_change' AND include_items='Add_items_change';

-- 9. WHAT WAS THE TOTAL NUMBER OF ROLLS ORDERED FOR EACH HOURS OF THE DAY
SELECT concat(cast(hour(ORDER_DATE)AS CHAR),"-",cast(hour(ORDER_DATE)+1 AS CHAR)) hours, count(roll_id) AS Roll_Ordered_hours
FROM CUSTOMER_ORDERS
GROUP BY hours 
ORDER BY Roll_Ordered_hours DESC;

-- 10. WHAT WAS THE NUMBER OF ORDER FOR EACH DAY OF THE WEEK 
SELECT dayname(order_date) AS Day,count(roll_id) AS roll_orders_day
FROM CUSTOMER_ORDERS
GROUP BY dayname(order_date)
ORDER BY  roll_orders_day DESC