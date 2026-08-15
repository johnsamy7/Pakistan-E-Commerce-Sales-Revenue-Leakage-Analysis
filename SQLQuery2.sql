--  Total sales, total quantity, and order count grouped by status, sorted by sales descending

SELECT 
    status,
    SUM(grand_total) AS total_sales,
    SUM(qty_ordered) AS total_quantity,
    COUNT(*) AS total_orders
FROM cleaned_ecommerce_data
GROUP BY status
ORDER BY total_sales DESC;

-- Average grand_total and discount by payment method (>100 orders)

SELECT 
    payment_method,
    AVG(grand_total) AS avg_grand_total,
    AVG(discount_amount) AS avg_discount
FROM cleaned_ecommerce_data
GROUP BY payment_method
HAVING COUNT(*) > 100;

-- Top 5 categories by total quantity ordered

SELECT TOP 5
    category_name_1,
    SUM(qty_ordered) AS total_qty_ordered
FROM cleaned_ecommerce_data
GROUP BY category_name_1
ORDER BY total_qty_ordered DESC;

--Orders where grand_total exceeds overall average

SELECT *
FROM cleaned_ecommerce_data
WHERE grand_total > (SELECT AVG(grand_total) FROM cleaned_ecommerce_data);

--5. Total discount, average discount, and discounted order count per category

SELECT 
    category_name_1,
    SUM(discount_amount) AS total_discount,
    AVG(discount_amount) AS avg_discount,
    COUNT(*) AS discounted_order_count
FROM cleaned_ecommerce_data
WHERE discount_amount > 0
GROUP BY category_name_1;

--6. Number of distinct SKUs and total orders per category

SELECT 
    category_name_1,
    COUNT(DISTINCT sku) AS distinct_sku_count,
    COUNT(*) AS total_orders
FROM cleaned_ecommerce_data
GROUP BY category_name_1;


--7. Customers with >5 orders, total spending, and average order value

SELECT 
    Customer_ID,
    COUNT(*) AS total_orders,
    SUM(grand_total) AS total_spending,
    AVG(grand_total) AS avg_order_value
FROM cleaned_ecommerce_data
GROUP BY Customer_ID
HAVING COUNT(*) > 5
ORDER BY total_spending DESC;

--8. SKUs whose average price exceeds overall average price

SELECT 
    sku,
    AVG(price) AS avg_sku_price
FROM cleaned_ecommerce_data
GROUP BY sku
HAVING AVG(price) > (SELECT AVG(price) FROM cleaned_ecommerce_data);


--9. Order count and total sales by spending classification

SELECT 
    CASE 
        WHEN grand_total < 500 THEN 'Low'
        WHEN grand_total BETWEEN 500 AND 1999 THEN 'Medium'
        ELSE 'High'
    END AS order_class,
    COUNT(*) AS order_count,
    SUM(grand_total) AS total_sales
FROM cleaned_ecommerce_data
GROUP BY 
    CASE 
        WHEN grand_total < 500 THEN 'Low'
        WHEN grand_total BETWEEN 500 AND 1999 THEN 'Medium'
        ELSE 'High'
    END;

--10. Categories with total sales greater than average total sales across categories

WITH CategorySales AS (
    SELECT 
        category_name_1,
        SUM(grand_total) AS category_total_sales
    FROM cleaned_ecommerce_data
    GROUP BY category_name_1
)
SELECT 
    category_name_1,
    category_total_sales
FROM CategorySales
WHERE category_total_sales > (SELECT AVG(category_total_sales) FROM CategorySales);

--11. Rank orders by grand_total within each category
SELECT 
    item_id,
    category_name_1,
    grand_total,
    RANK() OVER (PARTITION BY category_name_1 ORDER BY grand_total DESC) AS order_rank_in_category
FROM cleaned_ecommerce_data;

--12. Rank payment methods by total sales amount

SELECT 
    payment_method,
    SUM(grand_total) AS total_sales,
    DENSE_RANK() OVER (ORDER BY SUM(grand_total) DESC) AS sales_rank
FROM cleaned_ecommerce_data
GROUP BY payment_method;

--13. Running total of grand_total per customer

SELECT 
    Customer_ID,
    item_id,
    grand_total,
    SUM(grand_total) OVER (PARTITION BY Customer_ID ORDER BY item_id) AS running_total_sales
FROM cleaned_ecommerce_data;

--14. Identify highest-value order for each customer

WITH RankedCustomerOrders AS (
    SELECT 
        Customer_ID,
        item_id,
        grand_total,
        ROW_NUMBER() OVER (PARTITION BY Customer_ID ORDER BY grand_total DESC) AS rn
    FROM cleaned_ecommerce_data
)
SELECT 
    Customer_ID,
    item_id,
    grand_total AS highest_order_value
FROM RankedCustomerOrders
WHERE rn = 1;

--15. Order grand_total vs. category average and absolute difference

SELECT 
    item_id,
    category_name_1,
    grand_total,
    AVG(grand_total) OVER (PARTITION BY category_name_1) AS category_avg_grand_total,
    grand_total - AVG(grand_total) OVER (PARTITION BY category_name_1) AS diff_from_category_avg
FROM cleaned_ecommerce_data;


--16. Total sales and total orders per year (newest to oldest)

SELECT 
    Year,
    SUM(grand_total) AS total_sales,
    COUNT(*) AS total_orders
FROM cleaned_ecommerce_data
GROUP BY Year
ORDER BY Year DESC;


--17. Monthly total sales and order count grouped by Year and Month

SELECT 
    Year,
    Month,
    SUM(grand_total) AS total_sales,
    COUNT(*) AS total_orders
FROM cleaned_ecommerce_data
GROUP BY Year, Month
ORDER BY Year ASC, Month ASC;

--18. First and latest order dates for each customer
SELECT 
    Customer_ID,
    MIN(created_at) AS first_order_date,
    MAX(created_at) AS latest_order_date
FROM cleaned_ecommerce_data
GROUP BY Customer_ID;

--19. Monthly sales, previous month sales, and month-over-month growth percentage

WITH MonthlySales AS (
    SELECT 
        Year,
        Month,
        SUM(grand_total) AS current_month_sales
    FROM cleaned_ecommerce_data
    GROUP BY Year, Month
),
SalesWithLag AS (
    SELECT 
        Year,
        Month,
        current_month_sales,
        LAG(current_month_sales) OVER (ORDER BY Year, Month) AS previous_month_sales
    FROM MonthlySales
)
SELECT 
    Year,
    Month,
    current_month_sales,
    previous_month_sales,
    ROUND(
        ((current_month_sales - previous_month_sales) * 100.0 / NULLIF(previous_month_sales, 0)), 
        2
    ) AS mom_growth_percentage
FROM SalesWithLag
ORDER BY Year ASC, Month ASC;

--20. Dense rank of months within each year by total sales

WITH MonthlySales AS (
    SELECT 
        Year,
        Month,
        SUM(grand_total) AS total_monthly_sales
    FROM cleaned_ecommerce_data
    GROUP BY Year, Month
)
SELECT 
    Year,
    Month,
    total_monthly_sales,
    DENSE_RANK() OVER (PARTITION BY Year ORDER BY total_monthly_sales DESC) AS month_sales_rank
FROM MonthlySales
ORDER BY Year ASC, month_sales_rank ASC;
























