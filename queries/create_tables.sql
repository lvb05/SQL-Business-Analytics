
-- CREATE DATABASE business_analytics;
-- Switch to the database (PostgreSQL / MySQL syntax may differ)

-- Drop table if it already exists
DROP TABLE IF EXISTS company_sales;

-- Create the main sales table
CREATE TABLE company_sales (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    region VARCHAR(50),
    product_category VARCHAR(50),
    order_date DATE,
    quantity INT CHECK (quantity > 0),
    unit_price DECIMAL(10,2) CHECK (unit_price >= 0),
    payment_method VARCHAR(30)
);

-- Optional: Indexes to improve query performance
CREATE INDEX idx_region ON company_sales(region);
CREATE INDEX idx_product_category ON company_sales(product_category);
CREATE INDEX idx_order_date ON company_sales(order_date);
CREATE INDEX idx_customer ON company_sales(customer_id);
