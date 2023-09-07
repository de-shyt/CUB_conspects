# Databases Internals



[TOC]



## 23-09-07

### Introduction

#### Overview

A **relational database** organizes data into structured tables (two-dimensional structures) with rows and columns, allowing for efficient storage, retrieval, and manipulation of data.

**Indexes** are data structures used in tables, improving the speed of data retrieval operations. They allow to add, remove, sort or get the rows without scanning the whole table. Common types used for implementing indexes are B-tree (balanced tree) and hash table.



**Basic concepts of transactions:**

- *Atomicity*. Transaction is treated as a single, indivisible unit of work  If a transaction fails at any point, it is rolled back to its previous state.
- *Consistency*. This means that the integrity constraints of the database (e.g., primary keys, foreign keys) should not be violated during a transaction.
- *Isolation*. Changes made by  one transaction should not be visible to other transactions until the first transaction is committed. This ensures that concurrent transactions do not interfere with each other.
- *Durability*. Once a transaction is committed, its changes should be permanent and survive system failures. The database should be able to recover to a consistent state after a crash.





#### SQL commands

**SQL** is a domain-specific language used to interact with relational databases. 

Example of creating tables:

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

-- Inserting some sample data into the "customers" table
INSERT INTO customers (customer_id, customer_name)
VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Charlie'),
    (4, 'David');

-- Inserting some sample data into the "orders" table
INSERT INTO orders (order_id, customer_id, order_date, total_amount)
VALUES
    (101, 1, '2023-01-05', 250.00),
    (102, 2, '2023-01-10', 120.50),
    (103, 1, '2023-01-15', 300.75),
    (104, 3, '2023-01-20', 450.20);
```

<img src="./pics for conspects/DB/23-09-07 1.png" alt="23-09-07 1" style="zoom:100%;" />





`JOIN` command is used to combine rows from two or more tables based on a related column between them. 

- `INNER JOIN` returns the rows that have matching values in both tables:

  ```sql
  SELECT orders.order_id, customers.customer_name
  FROM orders
  INNER JOIN customers ON orders.customer_id = customers.customer_id;
  ```

  ```shell
  | order_id | customer_name |
  |----------|---------------|
  | 101      | Alice         |
  | 102      | Bob           |
  | 103      | Alice         |
  | 104      | Charlie       |
  ```

- `LEFT JOIN` returns all rows from the left table and the matched rows from the right table. If there is no match in the right table, `NULL` value is used:

  ```sql
  SELECT customers.customer_name, orders.order_id
  FROM customers
  LEFT JOIN orders ON customers.customer_id = orders.customer_id;
  ```

  ```shell
  | customer_name | order_id |
  |---------------|----------|
  | Alice         | 101      |
  | Bob           | 102      |
  | Alice         | 103      |
  | Charlie       | 104      |
  | David         | NULL     |
  ```

- `RIGHT JOIN` (or `RIGHT OUTER JOIN`) returns all rows from the right table and the matched rows from the left table. If there is no match in the left table, NULL values are returned for columns from the left table:

  ```sql
  SELECT customers.customer_name, orders.order_id
  FROM customers
  RIGHT JOIN orders ON customers.customer_id = orders.customer_id;
  ```

  ```sql
  | customer_name | order_id |
  |---------------|----------|
  | Alice         | 101      |
  | Bob           | 102      |
  | Alice         | 103      |
  | Charlie       | 104      |
  ```

- `FULL OUTER JOIN` returns all rows when there is a match in either the left or right table. If there is no match, NULL values are returned for columns from the table with no match:

  ```sql
  SELECT customers.customer_name, orders.order_id
  FROM customers
  FULL OUTER JOIN orders ON customers.customer_id = orders.customer_id;
  ```

  ```sql
  | customer_name | order_id |
  |---------------|----------|
  | Alice         | 101      |
  | Bob           | 102      |
  | Alice         | 103      |
  | Charlie       | 104      |
  | David         | NULL     |
  ```





The `WHERE` clause is used to filter rows based on specified conditions:

```sql
SELECT orders.order_id, customers.customer_name
FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id
WHERE orders.order_date >= '2023-01-12';
```

```shell
| order_id | customer_name |
|----------|---------------|
| 103      | Alice         |
| 104      | Charlie       |
```







### SSD under cover /todo 

