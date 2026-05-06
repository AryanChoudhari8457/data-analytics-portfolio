
-- orders & revenue-----------------------------------------------------------

--1) Top 5 customers by spending
select cc.customer_unique_id, sum(payment_value) total_spend from sales.orders o
join sales.order_payments op on o.order_id = op.order_id 
join customers.customers cc on cc.customer_id = o.customer_id
group by cc.customer_unique_id
order by total_spend desc 
limit 5

-- 2) Revenue per state
select customer_state, sum(sop.payment_value) as revenue
from customers.customers cc
join sales.orders so on cc.customer_id = so.customer_id
join sales.order_payments sop on so.order_id = sop.order_id
group by cc.customer_state
order by revenue desc



-- 3)Revenue contribution % by state
select customer_state, sum(sop.payment_value) as revenue, 
(sum(sop.payment_value) * 100.0 / sum(sum(payment_value)) over()) as percent_revenue 
from customers.customers cc
join sales.orders so on cc.customer_id = so.customer_id
join sales.order_payments sop on so.order_id = sop.order_id
group by cc.customer_state
order by revenue desc





-- 4)Find top 5 sellers based on total sales.
SELECT seller_id, SUM(price) AS total_sales
FROM sales.order_items
GROUP BY seller_id
ORDER BY total_sales DESC
LIMIT 5;






-- product analysis------------------------------------------------------------


-- 5)Most popular product categories
select pp.product_category_name, count(*) as total_orders from sales.order_items soi
join products.products pp on pp.product_id = soi.product_id
group by pp.product_category_name 
order by total_orders desc


-- 6)Find top product in each category.
SELECT *
FROM (
    SELECT 
    p.product_category_name,
    oi.product_id,
    COUNT(*) AS total_orders,
    RANK() OVER (
    PARTITION BY p.product_category_name
    ORDER BY COUNT(*) DESC
) AS rank
FROM sales.order_items oi
JOIN products.products p 
ON oi.product_id = p.product_id
GROUP BY p.product_category_name, oi.product_id
) t
WHERE rank = 1
order by total_orders desc

-- 7)Lowest rated product categories

select pp.product_category_name, avg(cor.review_score) as avg_rating from customers.order_reviews cor
join sales.orders  so on so.order_id = cor.order_id
join sales.order_items soi on soi.order_id = so.order_id
join products.products pp on pp.product_id = soi.product_id
group by pp.product_category_name 
order by avg_rating asc




-- Delivery--------------------------------------------------------------------

--8) Find orders that were delivered late.
select order_id, order_delivered_customer_date, order_estimated_delivery_date from sales.orders
where order_delivered_customer_date > order_estimated_delivery_date

-- 9)Analyze average delivery time per state.
select cc.customer_state, avg(order_delivered_customer_date - order_delivered_carrier_date) as avg_delivery_time from sales.orders so
join customers.customers cc on cc.customer_id = so.customer_id
group by cc.customer_state
order by avg_delivery_time 



-- 10)Check if delivery delay affects review score.
select avg(cr.review_score) from sales.orders so
join customers.order_reviews cr on cr.order_id= so.order_id
where so.order_delivered_customer_date > so.order_estimated_delivery_date
-- OR
select cr.review_score, count(*) from sales.orders so
join customers.order_reviews cr on cr.order_id= so.order_id
where so.order_delivered_customer_date > so.order_estimated_delivery_date
group by cr.review_score









-- Customer Behavior----------------------------------------------------------

-- 11)Find repeat customers (who ordered more than once).
select cc.customer_unique_id, count(so.order_id) as total from customers.customers cc
join sales.orders so on so.customer_id = cc.customer_id
group by cc.customer_unique_id 
having count(so.order_id) > 1
order by total desc


--12) Identify customers who gave low ratings frequently.
SELECT 
    c.customer_unique_id,
    COUNT(*) AS low_rating_count
FROM customers.order_reviews r
JOIN sales.orders o 
ON r.order_id = o.order_id
JOIN customers.customers c 
ON o.customer_id = c.customer_id
WHERE r.review_score <= 2
GROUP BY c.customer_unique_id
HAVING COUNT(*) > 1
ORDER BY low_rating_count DESC;
-- OR
select cc.customer_unique_id,count(*) as total from customers.order_reviews cor
join sales.orders so on so.order_id = cor.order_id
join customers.customers cc on cc.customer_id = so.customer_id
where cor.review_score <=2
group by cc.customer_unique_id
having not count(*) = 1
order by total desc 



-- 13)Find customers with highest number of orders.
select cc.customer_unique_id, count(so.order_id) as total from customers.customers cc
join sales.orders so on so.customer_id = cc.customer_id
group by cc.customer_unique_id
order by total desc
limit 5





-- Seller Analysis---------------------------------------------------------

-- 14)Rank sellers based on total sales (use window function).
select seller_id, sum(price) as total_selling_amount, 
dense_rank() over(order by sum(price) desc) from sales.order_items 
group by seller_id
order by total_selling_amount desc 


-- 15)Top 3 sellers in each state

select * from 
(
select ss.seller_state, soi.seller_id, sum(soi.price) as total_selling_amount, 
dense_rank() over( partition by ss.seller_state order by sum(soi.price) desc)
as ranking from sales.order_items soi

join sellers.sellers ss on ss.seller_id = soi.seller_id
group by soi.seller_id, ss.seller_state

) t

where ranking <= 3 
order by ranking, total_selling_amount







-- Time Analysis--------------------------------------------------------

-- 16)Find monthly sales trend.
select
TO_CHAR(so.order_purchase_timestamp, 'MM') as monthh, 
sum(sop.payment_value) as total_sales 
from sales.orders so
join sales.order_payments sop on sop.order_id = so.order_id
group by monthh
order by monthh


-- 17)Find cumulative revenue over time (window function).
select 
monthh, total_sales, 
sum(total_sales) over(order by monthh) as cummulative_frequency from 
(
select
TO_CHAR(so.order_purchase_timestamp, 'YYYY-MM') as monthh, 
sum(sop.payment_value) as total_sales from sales.orders so
join sales.order_payments sop on sop.order_id = so.order_id
group by monthh
) t
order by monthh  




