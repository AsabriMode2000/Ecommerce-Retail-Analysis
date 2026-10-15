use ECommerceRetailDB
-- SQL analysis

--main KPIs (TotalSales,TotalProfit,TotalOrders,TotalCustomers):
SELECT
    ROUND(SUM(sales), 2) AS TotalSales,
    ROUND(SUM(profit), 2) AS TotalProfit,
    COUNT(DISTINCT order_id) AS TotalOrders,
    COUNT(DISTINCT customer_id) AS TotalCustomers,
    SUM(quantity) AS TotalQuantity
FROM dbo.Orders;

--Profit margin:
SELECT
    ROUND(
        SUM(profit) * 100.0 / NULLIF(SUM(sales), 0),
        2
    ) AS ProfitMarginPercentage
FROM dbo.Orders;

--Average order value:
SELECT
    ROUND(
        SUM(sales) / NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS AverageOrderValue
FROM dbo.Orders;
---------------------------------------------------------------------------------------------
-- Monthly sales trend
SELECT
    YEAR(order_date) AS Year,
    MONTH(order_date) AS Month,
    FORMAT(order_date, 'yyyy-MM') AS YearMonth,
    ROUND(SUM(sales), 2) AS TotalSales,
    ROUND(SUM(profit), 2) AS TotalProfit
FROM dbo.Orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date),
    FORMAT(order_date, 'yyyy-MM')
ORDER BY
    Year,
    Month;

-- Sales and profit by category
SELECT
    category,
    ROUND(SUM(sales), 2) AS TotalSales,
    ROUND(SUM(profit), 2) AS TotalProfit,
    SUM(quantity) AS TotalQuantity
FROM dbo.Orders
GROUP BY category
ORDER BY TotalSales DESC;

--Sub-category analysis
SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS TotalSales,
    ROUND(SUM(profit), 2) AS TotalProfit,
    SUM(quantity) AS TotalQuantity
FROM dbo.Orders
GROUP BY sub_category
ORDER BY TotalSales DESC;

-- Loss-making subcategories
SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS TotalSales,
    ROUND(SUM(profit), 2) AS TotalProfit
FROM dbo.Orders
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY TotalProfit ASC;

-- Regional performance
SELECT
    region,
    ROUND(SUM(sales), 2) AS TotalSales,
    ROUND(SUM(profit), 2) AS TotalProfit,
    COUNT(DISTINCT order_id) AS TotalOrders,
    COUNT(DISTINCT customer_id) AS TotalCustomers
FROM dbo.Orders
GROUP BY region
ORDER BY TotalSales DESC;

-- Customer segment analysis
SELECT
    segment,
    ROUND(SUM(sales), 2) AS TotalSales,
    ROUND(SUM(profit), 2) AS TotalProfit,
    COUNT(DISTINCT order_id) AS TotalOrders
FROM dbo.Orders
GROUP BY segment
ORDER BY TotalSales DESC;

-- Top 10 products by sales
SELECT TOP 10
    product_name,
    ROUND(SUM(sales), 2) AS TotalSales,
    ROUND(SUM(profit), 2) AS TotalProfit
    FROM dbo.Orders
GROUP BY product_name
ORDER BY TotalSales DESC;

-- Top 10 products by profit
SELECT TOP 10
    product_name,
    ROUND(SUM(sales), 2) AS TotalSales,
    ROUND(SUM(profit), 2) AS TotalProfit
FROM dbo.Orders
GROUP BY product_name
ORDER BY TotalProfit DESC;

-- Worst 10 products by profit
SELECT TOP 10
    product_name,
    ROUND(SUM(sales), 2) AS TotalSales,
    ROUND(SUM(profit), 2) AS TotalProfit
FROM dbo.Orders
GROUP BY product_name
ORDER BY TotalProfit ASC;

-- Top customers
SELECT TOP 10
    customer_name,
    COUNT(DISTINCT order_id) AS TotalOrders,
    ROUND(SUM(sales), 2) AS TotalSales,
    ROUND(SUM(profit), 2) AS TotalProfit
FROM dbo.Orders
GROUP BY customer_name
ORDER BY TotalSales DESC;

-- Analyze discounts
SELECT
    discount,
    COUNT(*) AS Transactions,
    ROUND(SUM(sales), 2) AS TotalSales,
    ROUND(SUM(profit), 2) AS TotalProfit
FROM dbo.Orders
GROUP BY discount
ORDER BY discount;
----------------------------------------------
SELECT
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.20 THEN 'Low Discount'
        WHEN discount <= 0.40 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS DiscountGroup,

    COUNT(*) AS Transactions,
    ROUND(SUM(sales), 2) AS Sales,
    ROUND(SUM(profit), 2) AS Profit

FROM dbo.Orders

GROUP BY
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.20 THEN 'Low Discount'
        WHEN discount <= 0.40 THEN 'Medium Discount'
        ELSE 'High Discount'
    END

ORDER BY Profit DESC;

-----------------------------------------------------------------------------------------------------------------------

-- useful SQL views


-- vw_MonthlySales 
CREATE VIEW vw_MonthlySales AS

SELECT
    YEAR(order_date) AS Year,
    MONTH(order_date) AS MonthNumber,
    DATENAME(MONTH, order_date) AS MonthName,
    FORMAT(order_date, 'yyyy-MM') AS YearMonth,
    SUM(sales) AS TotalSales,
    SUM(profit) AS TotalProfit,
    COUNT(DISTINCT order_id) AS TotalOrders
FROM dbo.Orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date),
    DATENAME(MONTH, order_date),
    FORMAT(order_date, 'yyyy-MM');

SELECT *
FROM vw_MonthlySales
ORDER BY Year, MonthNumber;

-- ProductPerformance

CREATE VIEW vw_ProductPerformance AS

SELECT
    category,
    sub_category,
    product_name,
    SUM(sales) AS TotalSales,
    SUM(profit) AS TotalProfit,
    SUM(quantity) AS QuantitySold
FROM dbo.Orders
GROUP BY
    category,
    sub_category,
    product_name;