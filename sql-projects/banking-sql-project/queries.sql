select * from accounts
select * from branches
select * from cards
select * from customers 
select * from loans
select * from merchants
select * from transactions
 

-- Which city has the highest number of customers?
SELECT CITY, COUNT(*) AS TOTAL_CUSTOMERS FROM CUSTOMERS 
GROUP BY CITY 
ORDER BY TOTAL_CUSTOMERS DESC
LIMIT 1

-- WHICH CITY HOLDS THE TOTAL HIGHEST DEPOSITS
select cust.city, sum(acco.balance_usd) as total_deposits from customers cust
join accounts acco on cust.customer_id = acco.customer_id 
group by cust.city 
order by total_deposits desc
limit 5


-- WHICH CUSTOMERS ARE HIGH-VALUE CUSTOMERS
select customer_id,sum(balance_usd) as total_balance from accounts 
group by customer_id
order by total_balance desc 
limit 5

-- Top 3 Customers per City
select * from (
select s.first_name, s.last_name, s.city, sum(a.balance_usd),
dense_rank() over (partition by s.city order by sum(a.balance_usd) desc) as rnk
from customers s
join accounts a on a.customer_id = s.customer_id
group by s.first_name, s.last_name, s.city
) t
where rnk <= 3


-- which account type is most popular
select account_type, count(*) as mostly_prefer from accounts 
group by account_type 
order by mostly_prefer desc


-- what is the monthly transaction growth trend
select 
extract (month from transaction_date) as months, count(*) as total_transactions,
sum(amount_usd) as total_amount 
from transactions 
group by months 
order by total_amount desc


--Which merchants receive highest payments? 
select  merc.merchant_name, count(tran.amount_usd) as total_transaction, 
sum(tran.amount_usd) as total_payment from transactions tran
join merchants merc on merc.merchant_id = tran.merchant_id
group by merc.merchant_name
order by total_payment desc
limit 3

  
-- Which customers may be risky borrowers?
select c.first_name, c.last_name, c.credit_score as low_score, l.loan_amount from customers c
join loans l on l.customer_id = c.customer_id
where c.credit_score < 600
order by loan_amount desc

  
-- What is average loan amount by credit score segment?
select 
case 
when c.credit_score > 750 then 'excellent'
when c.credit_score > 700 then 'good'
when c.credit_score > 650 then 'fair'
else 'poor'
end segment,
avg(l.loan_amount) as average_loan
 from customers c
 join loans l on l.customer_id = c.customer_id
group by segment
order by average_loan desc

  
-- Which accounts are inactive? (No transactions)
select a.account_id from accounts a
left join transactions t on t.account_id = a.account_id
where t.account_id is null


-- Who are top spenders?
select c.first_name, c.last_name,t.account_id, sum(t.amount_usd) as total_spend from transactions t
join accounts a on a.account_id = t.account_id 
join customers c on c.customer_id = a.customer_id 
group by t.account_id,c.first_name, c.last_name 
order by total_spend desc
limit 5

  
-- Which day has highest transaction volume?
select 
DATE(transaction_date) as datee, sum(amount_usd) as amount_used from transactions
group by datee 
order by amount_used desc

  
-- latest day with highest transaction volume
select 
DATE(transaction_date) as datee, sum(amount_usd) as amount_used from transactions
group by datee 
having DATE(transaction_date) = ( select max(date(transaction_date)) as large_date from transactions)
order by amount_used desc


-- Customers with multiple products (account + card + loan)

select  c.customer_id, c.first_name from customers c
join loans l on l.customer_id = c.customer_id
join accounts a on a.customer_id = c.customer_id
join cards ca on ca.account_id = a.account_id
group by c.customer_id, c.first_name


-- What percentage of customers have loans?
select 
round(
count(distinct l.customer_id) * 100.0 / 
count(distinct c.customer_id), 2
) as total_percentage
from customers c
left join loans l
on l.customer_id = c.customer_id


-- Top 5 cities with poor credit scores
select city, round(avg(credit_score),2 ) as avg_credit_score from customers 
group by city 
order by avg_credit_score asc
limit 5

