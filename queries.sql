-- Special Query 1: Total Orders per Week
SELECT 
    DATE_TRUNC('week', sale_date) AS week_start,
    COUNT(salesid) AS total_orders
FROM sales
GROUP BY DATE_TRUNC('week', sale_date)
ORDER BY week_start;

-- Special Query 2: Total Revenue per Hour of Day
SELECT 
    DATE_PART('hour', sale_date) AS hour_of_day,
    COUNT(salesid) AS total_orders,
    SUM(price) AS total_revenue
FROM sales
GROUP BY DATE_PART('hour', sale_date)
ORDER BY hour_of_day;

-- Special Query 3: Top 10 Days with Highest Sales
SELECT 
    DATE(sale_date) AS sale_day,
    SUM(price) AS total_sales
FROM sales
GROUP BY DATE(sale_date)
ORDER BY total_sales DESC
LIMIT 10;

-- Query 4: Top 10 Customers by Rewards Points
SELECT 
    customerid,
    first_name,
    last_name,
    rewards_points
FROM customers
ORDER BY rewards_points DESC
LIMIT 10;

-- Query 5: Total Sales by Employee
SELECT 
    e.employeeid,
    e.first_name,
    e.last_name,
    SUM(s.price) AS total_sales
FROM employees e
JOIN sales s ON e.employeeid = s.employeeid
GROUP BY e.employeeid, e.first_name, e.last_name
ORDER BY total_sales DESC;

-- Query 6: List of all Customers
SELECT customerid, first_name, last_name, rewards_points
FROM customers
ORDER BY customerid;

-- Query 7: Customers with at least one Order
SELECT DISTINCT c.customerid, c.first_name, c.last_name
FROM customers c
JOIN sales s ON c.customerid = s.custid
ORDER BY c.customerid;

-- Query 8: Employee Login Check
SELECT employeeid, first_name, last_name, username, level
FROM employees
ORDER BY employeeid;

-- Query 9: Inventory Items with Low Stock (less than 10)
SELECT itemid, item, quantity
FROM inventory
WHERE quantity < 10
ORDER BY quantity ASC;

-- Query 10: Average Price of Menu Items
SELECT m.menuid, m.item, AVG(s.price) AS avg_price
FROM menu m
JOIN sales s ON m.menuid = s.menuid
GROUP BY m.menuid, m.item
ORDER BY avg_price DESC;

-- Query 11: Menu With Prices
SELECT m.menuid, m.item, AVG(s.price) AS avg_price
FROM menu m
JOIN sales s ON m.menuid = s.menuid
GROUP BY m.menuid, m.item
ORDER BY avg_price DESC;

-- Query 12: Daily Sales Summary
SELECT DATE(sale_date) AS day, COUNT(salesid) AS total_orders, SUM(price) AS revenue
FROM sales
GROUP BY DATE(sale_date)
ORDER BY day;