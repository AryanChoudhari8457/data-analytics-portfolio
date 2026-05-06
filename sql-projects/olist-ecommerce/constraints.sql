alter table sales.orders add constraint fk_key_customer_id foreign key(customer_id)
references customers.customers(customer_id)



alter table sales.orders add primary key(order_id)

alter table customers.order_reviews add constraint fk_key_order_id_InOrderReviews foreign key(order_id)
references sales.orders(order_id)


alter table sales.order_items add constraint fk_key_order_id_InOrderItems foreign key (order_id)
references sales.orders(order_id)

alter table sales.order_items add constraint fk_key_product_id_InOrderItems foreign key (product_id)
references products.products(product_id)

alter table sales.order_items add constraint fk_key_seller_id_InOrderItems foreign key (seller_id)
references sellers.sellers(seller_id)

alter table sales.order_payments add constraint fk_key_order_id_InOrderPayments foreign key (order_id)
references sales.orders(order_id)


