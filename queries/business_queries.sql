-- 1. Total revenue overall
SELECT SUM(quantity * unit_price) AS total_revenue
FROM company_sales;

-- 2. Revenue by product category
SELECT product_category, SUM(quantity * unit_price) AS revenue
FROM company_sales
GROUP BY product_category
ORDER BY revenue DESC;

-- 3. Revenue by region
SELECT region, SUM(quantity * unit_price) AS revenue
FROM company_sales
GROUP BY region
ORDER BY revenue DESC;

-- 4. Monthly revenue trend
SELECT DATE_TRUNC('month', order_date) AS month,
       SUM(quantity * unit_price) AS revenue
FROM company_sales
GROUP BY month
ORDER BY month;

-- 5. Top 10 customers by lifetime value
SELECT customer_id, SUM(quantity * unit_price) AS lifetime_value
FROM company_sales
GROUP BY customer_id
ORDER BY lifetime_value DESC
LIMIT 10;

-- 6. Average Order Value (AOV)
SELECT AVG(quantity * unit_price) AS avg_order_value
FROM company_sales;

-- 7. Number of orders per payment method
SELECT payment_method, COUNT(order_id) AS total_orders
FROM company_sales
GROUP BY payment_method
ORDER BY total_orders DESC;

-- 8. Repeat purchase rate (customers with >1 order)
SELECT ROUND(
    (COUNT(DISTINCT CASE WHEN order_count > 1 THEN customer_id END) * 100.0) /
    COUNT(DISTINCT customer_id), 2
) AS repeat_purchase_rate
FROM (
    SELECT customer_id, COUNT(order_id) AS order_count
    FROM company_sales
    GROUP BY customer_id
) sub;

-- 9. Top product per region by revenue
SELECT region, product_category, SUM(quantity * unit_price) AS revenue
FROM company_sales
GROUP BY region, product_category
QUALIFY RANK() OVER (PARTITION BY region ORDER BY SUM(quantity * unit_price) DESC) = 1;

-- 10. Seasonal revenue (Quarterly)
SELECT EXTRACT(quarter FROM order_date) AS quarter,
       SUM(quantity * unit_price) AS revenue
FROM company_sales
GROUP BY quarter
ORDER BY quarter;
