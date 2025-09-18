-- Remove duplicate rows (if any)
DELETE FROM company_sales a
USING company_sales b
WHERE a.order_id = b.order_id
AND a.ctid < b.ctid;

-- Handle NULL values (replace with defaults where logical)
UPDATE company_sales
SET region = 'Unknown'
WHERE region IS NULL;

UPDATE company_sales
SET product_category = 'Misc'
WHERE product_category IS NULL;

UPDATE company_sales
SET payment_method = 'Other'
WHERE payment_method IS NULL;

-- Ensure no negative prices or quantities
DELETE FROM company_sales
WHERE quantity <= 0 OR unit_price < 0;

-- Optional: Standardize text fields (convert to Title Case)
-- (PostgreSQL example, MySQL users can adapt with UPPER/LOWER)
UPDATE company_sales
SET region = INITCAP(region),
    product_category = INITCAP(product_category),
    payment_method = INITCAP(payment_method);

-- Verify cleaned dataset
SELECT COUNT(*) AS total_records, 
       COUNT(DISTINCT customer_id) AS unique_customers,
       MIN(order_date) AS first_order,
       MAX(order_date) AS last_order
FROM company_sales;
