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

-- Special Query 4: Inventory Items per Menu
SELECT 
    m.menu_name,
    COUNT(mi.inventoryid) AS total_inventory_items
FROM menu m
JOIN menuinventory mi ON m.menuid = mi.menuid
GROUP BY m.menu_name
ORDER BY total_inventory_items DESC;

-- Special Query 5: Find the lowest-sales day each week and its top-selling menu item.
WITH daily_sales AS (
    SELECT 
        DATE(sale_date) AS sale_day,
        DATE_TRUNC('week', sale_date) AS sale_week,
        SUM(price) AS total_sales
    FROM sales
    GROUP BY DATE(sale_date), DATE_TRUNC('week', sale_date)
),
lowest_day AS (
    SELECT DISTINCT ON (sale_week)
        sale_week,
        sale_day,
        total_sales
    FROM daily_sales
    ORDER BY sale_week, total_sales ASC
),
top_menu_item AS (
    SELECT 
        DATE(s.sale_date) AS sale_day,
        m.menu_name,
        COUNT(s.salesid) AS times_sold
    FROM sales s
    JOIN menu m ON s.menuid = m.menuid
    GROUP BY DATE(s.sale_date), m.menu_name
)
SELECT 
    l.sale_week,
    l.sale_day,
    l.total_sales AS lowest_sales,
    t.menu_name AS top_seller
FROM lowest_day l
JOIN top_menu_item t ON l.sale_day = t.sale_day
WHERE t.times_sold = (
    SELECT MAX(times_sold)
    FROM top_menu_item
    WHERE sale_day = l.sale_day
)
ORDER BY l.sale_week;
    


-- Query 6: Top 10 Customers by Rewards Points
SELECT 
    customerid,
    first_name,
    last_name,
    rewards_points
FROM customers
ORDER BY rewards_points DESC
LIMIT 10;

-- Query 7: Total Sales by Employee
SELECT 
    e.employeeid,
    e.first_name,
    e.last_name,
    SUM(s.price) AS total_sales
FROM employees e
JOIN sales s ON e.employeeid = s.employeeid
GROUP BY e.employeeid, e.first_name, e.last_name
ORDER BY total_sales DESC;

-- Query 8: List of all Customers
SELECT customerid, first_name, last_name, rewards_points
FROM customers
ORDER BY customerid;

-- Query 9: Customers with at least one Order
SELECT DISTINCT c.customerid, c.first_name, c.last_name
FROM customers c
JOIN sales s ON c.customerid = s.custid
ORDER BY c.customerid;

-- Query 10: Employee Login Check
SELECT employeeid, first_name, last_name, username, level
FROM employees
ORDER BY employeeid;

-- Query 11: Inventory Items with Low Stock (less than 10)
SELECT itemid, item, quantity
FROM inventory
WHERE quantity < 10
ORDER BY quantity ASC;

-- Query 12: Average Price of Menu Items
SELECT m.menuid, m.menu_name, AVG(s.price) AS avg_price
FROM menu m
JOIN sales s ON m.menuid = s.menuid
GROUP BY m.menuid, m.menu_name
ORDER BY avg_price DESC;
