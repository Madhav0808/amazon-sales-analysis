-- =============================================
-- Query 1: Top Categories by Average Rating
-- Goal: Find which product categories are rated highest by customers
-- =============================================

SELECT 
    category,
    ROUND(AVG(CAST(rating AS DECIMAL(3,1))), 2) AS avg_rating,
    COUNT(*) AS total_products
FROM amazon_sales
GROUP BY category
ORDER BY avg_rating DESC
LIMIT 8;

-- =============================================
-- Query 2: Discount Impact on Customer Ratings
-- Goal: Check if higher discounts lead to better or worse ratings
-- =============================================

SELECT 
    CASE 
        WHEN CAST(REPLACE(discount_percentage, '%', '') AS DECIMAL(5,2)) >= 50 
            THEN 'High Discount 50%+'
        WHEN CAST(REPLACE(discount_percentage, '%', '') AS DECIMAL(5,2)) >= 30 
            THEN 'Medium Discount 30-49%'
        ELSE 'Low Discount Under 30%'
    END AS discount_bucket,
    ROUND(AVG(CAST(rating AS DECIMAL(3,1))), 2) AS avg_rating,
    COUNT(*) AS total_products
FROM amazon_sales
GROUP BY discount_bucket
ORDER BY avg_rating DESC;

-- =============================================
-- Query 3: Top 3 Products per Category by Reviews
-- Goal: Rank products within each category using Window Function
-- =============================================

SELECT product_name, category, rating, rating_count, rnk
FROM (
    SELECT 
        product_name, 
        category, 
        rating,
        rating_count,
        RANK() OVER (
            PARTITION BY category 
            ORDER BY CAST(REPLACE(rating_count, ',', '') AS UNSIGNED) DESC
        ) AS rnk
    FROM amazon_sales
) ranked
WHERE rnk <= 3;



-- =============================================
-- Query 4: Price Segment Analysis
-- Goal: Understand how product pricing affects customer ratings
-- =============================================



SELECT 
    CASE
        WHEN CAST(REGEXP_REPLACE(actual_price, '[^0-9.]', '') AS DECIMAL(10,2)) <= 500 
            THEN 'Budget 0-500'
        WHEN CAST(REGEXP_REPLACE(actual_price, '[^0-9.]', '') AS DECIMAL(10,2)) <= 2000 
            THEN 'Mid-range 500-2000'
        ELSE 'Premium 2000+'
    END AS price_segment,
    ROUND(AVG(CAST(rating AS DECIMAL(3,1))), 2) AS avg_rating,
    COUNT(*) AS total_products
FROM amazon_sales
GROUP BY price_segment
ORDER BY avg_rating DESC;

-- =============================================
-- Query 5: Best Value Products
-- Goal: Find products with high rating AND high discount
-- =============================================

SELECT 
    product_name,
    category,
    rating,
    discount_percentage,
    REGEXP_REPLACE(actual_price, '[^0-9.]', '') AS actual_price
FROM amazon_sales
WHERE CAST(rating AS DECIMAL(3,1)) >= 4.0 
  AND CAST(REGEXP_REPLACE(discount_percentage, '[^0-9.]', '') AS DECIMAL(5,2)) >= 40
ORDER BY CAST(rating AS DECIMAL(3,1)) DESC
LIMIT 10;
