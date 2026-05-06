create index customers.customers_customer_id on customers.customers(customer_id)


create index customers.customers_customer_unique_id on customers.customers(customer_unique_id)


create index idx_sales_orders_customer_id on sales.orders(customer_id)


create index idx_sales_orders_order_id on sales.orders(order_id)