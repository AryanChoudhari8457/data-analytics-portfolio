
-- CREATE VIEW OF THE REVENUE PER STATE
CREATE VIEW SALES.REVENUE_PER_STATE AS 
select customer_state, sum(sop.payment_value) as revenue
from customers.customers cc
join sales.orders so on cc.customer_id = so.customer_id
join sales.order_payments sop on so.order_id = sop.order_id
group by cc.customer_state
order by revenue desc



-- CREATE VIEW ON MOST_POPULAR_RPODUCT_CATEGORIES
CREATE VIEW PRODUCTS.MOST_POPULAR_RPODUCT_CATEGORIES AS
select pp.product_category_name, count(*) as total_orders from sales.order_items soi
join products.products pp on pp.product_id = soi.product_id
group by pp.product_category_name 
order by total_orders desc



-- CREATE VIEW ON AVERAGE_DELIVERY_TIME_PER_STATE
CREATE VIEW SALES.AVERAGE_DELIVERY_TIME_PER_STATE AS
select cc.customer_state, avg(order_delivered_customer_date - order_delivered_carrier_date) as avg_delivery_time from sales.orders so
join customers.customers cc on cc.customer_id = so.customer_id
group by cc.customer_state
order by avg_delivery_time 



-- CREATE VIEW ON CUSTOMERS_GAVE_LOW_RATINGS_FREQUENTLY
CREATE VIEW CUSTOMERS.CUSTOMERS_GAVE_LOW_RATINGS_FREQUENTLY AS
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



-- CREATE VIEW ON MONTHLY SALES TREND
CREATE VIEW SALES.MONTHLY_SALES_TREND AS 
select
TO_CHAR(so.order_purchase_timestamp, 'YYYY-MM') as monthh, 
sum(sop.payment_value) as total_sales 
from sales.orders so
join sales.order_payments sop on sop.order_id = so.order_id
group by monthh
order by monthh  



-- CREATE VIEW ON top 5 sellers based on total sales
CREATE VIEW SELLERS.TOP_5_SELLERS AS
SELECT seller_id, SUM(price) AS total_sales
FROM sales.order_items
GROUP BY seller_id
ORDER BY total_sales DESC
LIMIT 5;


