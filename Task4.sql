CREATE DATABASE EcommerceDB2;
USE EcommerceDB2;

SELECT c.name AS customer_name, 
       SUM(p.amount_paid) AS total_paid
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY c.customer_id
HAVING total_paid > 50000;

SELECT c.name AS customer_name,
       COUNT(o.order_id) AS total_orders,
       SUM(o.total_amount) AS total_order_value
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING SUM(o.total_amount) IS NOT NULL;

SELECT p.name AS product_name,
       AVG(oi.price_at_purchase) AS average_selling_price,
       SUM(oi.quantity) AS total_quantity_sold
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
HAVING SUM(oi.quantity) >= 1;

SELECT price_group.price_range,
       COUNT(*) AS product_count
FROM (
    SELECT 
      CASE 
        WHEN price < 1000 THEN 'Below 1000'
        WHEN price BETWEEN 1000 AND 5000 THEN '1000-5000'
        WHEN price BETWEEN 5001 AND 20000 THEN '5001-20000'
        ELSE 'Above 20000'
      END AS price_range
    FROM Products
) AS price_group
GROUP BY price_group.price_range;

