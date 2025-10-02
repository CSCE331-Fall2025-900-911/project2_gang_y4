

\copy sales (salesid, menuid, custid, employeeid, price, unit_price, sale_date, quantity) FROM 'salesPopulate.csv' DELIMITER ',' CSV HEADER;
SELECT * FROM sales;

\copy inventory (itemid, item, quantity, price, unit_price, order_date, "Size") FROM 'inventoryReal.csv' DELIMITER ',' CSV HEADER;
SELECT * FROM inventory;

\copy orders (orderid, itemid, item_name, quantity, unit_price, price, order_date) FROM 'orders.csv' DELIMITER ',' CSV HEADER;
SELECT * FROM orders;

\copy customers (last_name, first_name, rewards_points, username, password, customerid) FROM 'customers.csv' DELIMITER ',' CSV HEADER;
SELECT * FROM customers;