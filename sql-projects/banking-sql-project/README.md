#  Banking SQL Project

##  Overview

This project is based on a large-scale **synthetic banking dataset** designed to simulate real-world banking operations.
It focuses on performing data analysis using SQL to extract meaningful business insights.

The dataset includes customers, accounts, transactions, loans, and merchants, making it ideal for practicing **advanced SQL queries and database design**.

---

##  Dataset Summary

* Total Records: **1.26 Million+**
* Customers: 50,000
* Accounts: 75,000
* Transactions: 1,000,000
* Loans: 30,000
* Merchants: 5,000
* Branches: 500

---

##  Tools & Technologies

* PostgreSQL
* SQL (Joins, Aggregations, Window Functions)
* CSV Dataset

---

##  Database Structure

The project consists of the following tables:

* `customers`
* `accounts`
* `cards`
* `transactions`
* `loans`
* `merchants`
* `branches`

Relationships are maintained using **Primary Keys and Foreign Keys**.

---

##  Project Structure

```
banking-sql-project/
│── dataset/
│── schema.sql
│── constraints.sql
│── indexes.sql
│── queries.sql
│── README.md
```

---

##  Key Features

* Designed normalized relational database schema
* Implemented Primary & Foreign Key constraints
* Optimized performance using indexes
* Executed analytical SQL queries on large dataset

---

##  Key SQL Concepts Used

* Joins (INNER JOIN, LEFT JOIN)
* Aggregate Functions (SUM, AVG, COUNT)
* GROUP BY & HAVING
* Subqueries
* Window Functions (RANK, ROW_NUMBER, LAG, LEAD)
* CASE statements
* Data filtering and transformation

---

##  Business Insights
1) Top cities with highest customer concentration are: <br>
(1) South Michael <br>
(2) New Michael <br>
(3) Smithmouth

2) Top 5 customers hold significantly higher balances compared to others.
"CUSEPV1YW0Y2JL9" <br>
"CUSN2LWQV1UR1PY" <br>
"CUS3JY2UIFZ7123" <br>
"CUSM3X4B2DTTNOO" <br>
"CUSHMODKKCZTNRF" <br>

3) Customers with Good credit score (>700) receive highest average loans.
   
5) ~16,335 customers have credit score < 600

6) 45.17% customers have loans

7) "Checking" accounts are the most preferred by customers

---

##  Sample Queries

### 1) Top 3 city has the highest number of customers?
 SELECT CITY, COUNT(*) AS TOTAL_CUSTOMERS FROM CUSTOMERS <br>
 GROUP BY CITY <br>
 ORDER BY TOTAL_CUSTOMERS DESC <br>
 LIMIT 3

<img width="389" height="156" alt="Screenshot 2026-04-30 203043" src="https://github.com/user-attachments/assets/af7fcea1-70fa-4e33-8304-82449da9535b" />

---
### 2) Top 5 customers by balance/deposits
 select cust.city, sum(acco.balance_usd) as total_deposits from customers cust <br>
 join accounts acco on cust.customer_id = acco.customer_id <br>
 group by cust.city <br>
 order by total_deposits desc <br>
 limit 5

<img width="365" height="204" alt="Screenshot 2026-04-30 203109" src="https://github.com/user-attachments/assets/4ae6aa4b-a539-407f-b605-788c489a25cd" />

---
### 3) Loan Customer Percentage
select <br>
round(  <br>
count(distinct l.customer_id) * 100.0 / <br>
count(distinct c.customer_id), 2 <br>
) as total_percentage <br>
from customers c <br>
left join loans l <br>
on l.customer_id = c.customer_id <br>

<img width="236" height="118" alt="Screenshot 2026-04-30 203415" src="https://github.com/user-attachments/assets/1e487e4f-f984-4179-bbde-73205f73de99" />


---

## note

This dataset is fully **synthetic** and does not contain any real personal or financial information.

---

## Conclusion

This project demonstrates strong SQL fundamentals along with real-world data analysis skills, making it suitable for **data analyst and database roles**.



<img width="1254" height="720" alt="Screenshot 2026-04-20 203041" src="https://github.com/user-attachments/assets/dca3da7f-9077-4c9b-af17-3aaf605f227e" />

