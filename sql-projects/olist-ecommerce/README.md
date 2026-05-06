# olist-sql-project

# E-commerce Data Analysis using PostgreSQL

## Project Overview
This project analyzes the Olist e-commerce dataset using PostgreSQL.


## Dataset
- orders
- customers
- products
- sellers
- order_payments
- order_reviews
- order_items
- geolocation


## Database Design
Schemas:
- sales
- customers
- products
- sellers
- location


## Key Queries

### 1) Revenue per state
select customer_state, sum(sop.payment_value) as revenue
from customers.customers cc
join sales.orders so on cc.customer_id = so.customer_id
join sales.order_payments sop on so.order_id = sop.order_id
group by cc.customer_state
order by revenue desc

### 2)Analyze average delivery time per state.
select cc.customer_state, avg(order_delivered_customer_date - order_delivered_carrier_date) as avg_delivery_time from sales.orders so
join customers.customers cc on cc.customer_id = so.customer_id
group by cc.customer_state
order by avg_delivery_time 

### 3)Find monthly sales trend.
select
TO_CHAR(so.order_purchase_timestamp, 'YYYY-MM') as monthh, 
sum(sop.payment_value) as total_sales 
from sales.orders so
join sales.order_payments sop on sop.order_id = so.order_id
group by monthh
order by monthh

### 4)Find top 5 sellers based on total sales.
SELECT seller_id, SUM(price) AS total_sales
FROM sales.order_items
GROUP BY seller_id
ORDER BY total_sales DESC
LIMIT 5;


## Key Insights

1. The states **SP, RJ, and MG** generate the highest revenue, contributing approximately **37%, 13%, and 11%** respectively, indicating strong regional demand concentration.

2. The most demanded product category is **"cama_mesa_banho"**, while the least demanded category is **"seguros_e_servicos"**, highlighting significant variation in product popularity.

3. **Delivery delays negatively impact customer satisfaction**, as delayed orders tend to receive lower review scores.

4. Sales show a **seasonal trend**, with a noticeable drop in **December** followed by a significant increase in **January**, indicating post-holiday demand recovery.

5. The top-performing sellers based on total sales are (Id's):
   - 4869f7a5dfa277a7dca6462dcf3b52b2  
   - 53243585a1d6dc2643021fd1853d8905  
   - 4a3ca9315b744ce9f8e9374361493884  
   - fa1c13f2614d7b5c4749cbc52fecda94  
   - 7c67e1448b00f6e969d365cea6b010ab  

6. Customer analysis shows:
   - Highest spending customer (Id's): **0a0a92112bd4c708ca5fde585afaa872**  
   - Most frequent (highest orders) customer (Id's): **8d50f5eadf50201ccdcedfb9e2ac8455**


## Tools
- PostgreSQL
- pgAdmin

## Graphical ER Diagram
<img width="2816" height="1536" alt="olist_tables_diagram" src="https://github.com/user-attachments/assets/f1a3e1cd-bd53-41d1-8c6b-315d3ffb6303" />


