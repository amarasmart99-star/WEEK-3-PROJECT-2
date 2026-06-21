 SALES DATA ANALYSIS
 AnalystLab Africa Internship - Week 3
 Dataset: Kaggle Sample Sales Data


USE [Sales Data];

 SECTION 1: CORE SQL QUERIES


SELECT * FROM [Sales Data].[dbo].[Analyst Sales]
SELECT 
    (SELECT COUNT(*) FROM [Sales Data].[dbo].[Analyst Sales]) AS TotalRows,
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
     WHERE TABLE_NAME = 'Analyst Sales') AS TotalColumns;

     SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Analyst Sales'
ORDER BY ORDINAL_POSITION;
 Query 1: View all orders (SELECT, ORDER BY)
 Insight: Full dataset sorted by most recent order date
SELECT 
    ORDERNUMBER AS [Order number],
    CUSTOMERNAME AS [Customer name],
    ORDERDATE AS [Order date],
    CAST(SALES AS INT) AS [Sales]
FROM [Analyst Sales]
ORDER BY [Order date] DESC;

 Query 2: Orders with sales above $5000 (WHERE)
 Insight: Identifies high-value individual orders
SELECT 
    ORDERNUMBER AS [Order number],
    CUSTOMERNAME AS [Customer name],
    CAST(SALES AS INT) AS [Sales],
    PRODUCTLINE AS [Product line]
FROM [Analyst Sales]
WHERE SALES > 5000
ORDER BY [Sales] DESC;

 Query 3: Total sales per product line (GROUP BY, SUM)
 Insight: Shows which product categories generate the most revenue
SELECT 
    PRODUCTLINE AS [Product line],
    CAST(SUM(SALES) AS INT) AS [Total sales]
FROM [Analyst Sales]
GROUP BY PRODUCTLINE
ORDER BY [Total sales] DESC;

 Query 4: Product lines with total sales over $500,000 (HAVING)
 Insight: Filters only the top-performing product categories
SELECT 
    PRODUCTLINE AS [Product line],
    CAST(SUM(SALES) AS INT) AS [Total sales]
FROM [Analyst Sales]
GROUP BY PRODUCTLINE
HAVING SUM(SALES) > 500000
ORDER BY [Total sales] DESC;

 Query 5: Average order value (AVG)
 Insight: Shows the typical amount per order
SELECT CAST(AVG(SALES) AS INT) AS [Average order value]
FROM [Analyst Sales];

 Query 6: Total number of orders (COUNT)
 Insight: Shows overall order volume
SELECT COUNT(DISTINCT ORDERNUMBER) AS [Total orders]
FROM [Analyst Sales];


 SECTION 2: ADVANCED SQL CONCEPTS
 Query 7: Total sales by year and quarter
 Insight: Tracks revenue trends over time
SELECT 
    YEAR_ID AS [Year],
    QTR_ID AS [Quarter],
    CAST(SUM(SALES) AS INT) AS [Quarterly sales]
FROM [Analyst Sales]
GROUP BY YEAR_ID, QTR_ID
ORDER BY [Year], [Quarter];

 Query 8: Top 10 customers by total spending
 Insight: Identifies the most valuable customers
SELECT TOP 10 
    CUSTOMERNAME AS [Customer name],
    CAST(SUM(SALES) AS INT) AS [Total spent]
FROM [Analyst Sales]
GROUP BY CUSTOMERNAME
ORDER BY [Total spent] DESC;

 Query 9: Customers who only ordered once (Subquery)
 Insight: Identifies one-time buyers for re-engagement campaigns
SELECT 
    CUSTOMERNAME AS [Customer name],
    COUNT(DISTINCT ORDERNUMBER) AS [Order count]
FROM [Analyst Sales]
GROUP BY CUSTOMERNAME
HAVING COUNT(DISTINCT ORDERNUMBER) = 1;

 Query 10: Orders priced above the average sales (Subquery)
 Insight: Highlights premium orders above the overall average
SELECT 
    ORDERNUMBER AS [Order number],
    CUSTOMERNAME AS [Customer name],
    CAST(SALES AS INT) AS [Sales]
FROM [Analyst Sales]
WHERE SALES > (SELECT AVG(SALES) FROM [Analyst Sales])
ORDER BY [Sales] DESC;

 Query 11: Rank customers by total spending (Window Function - RANK)
 Insight: Assigns a clear rank to each customer based on revenue
SELECT 
    CUSTOMERNAME AS [Customer name],
    CAST(SUM(SALES) AS INT) AS [Total spent],
    RANK() OVER (ORDER BY SUM(SALES) DESC) AS [Spending rank]
FROM [Analyst Sales]
GROUP BY CUSTOMERNAME;

 Query 12: Rank orders within each product line (PARTITION BY)
 Insight: Shows top-selling orders within each product category
SELECT 
    PRODUCTLINE AS [Product line],
    ORDERNUMBER AS [Order number],
    CAST(SALES AS INT) AS [Sales],
    RANK() OVER (PARTITION BY PRODUCTLINE ORDER BY SALES DESC) AS [Rank in category]
FROM [Analyst Sales];

 Query 13: Row number for orders per customer (ROW_NUMBER)
 Insight: Numbers each order placed by a customer chronologically
SELECT 
    CUSTOMERNAME AS [Customer name],
    ORDERNUMBER AS [Order number],
    ORDERDATE AS [Order date],
    ROW_NUMBER() OVER (PARTITION BY CUSTOMERNAME ORDER BY ORDERDATE ASC) AS [Order sequence]
FROM [Analyst Sales];


SECTION 3: BUSINESS PROBLEM SOLVING

 Query 14: Revenue trend by year
Insight: Shows year-over-year sales growth or decline
SELECT 
    YEAR_ID AS [Year],
    CAST(SUM(SALES) AS INT) AS [Annual revenue]
FROM [Analyst Sales]
GROUP BY YEAR_ID
ORDER BY [Year] ASC;

 Query 15: Best selling product (by quantity)
 Insight: Identifies the most frequently ordered product
SELECT 
    PRODUCTCODE AS [Product code],
    SUM(QUANTITYORDERED) AS [Total quantity sold]
FROM [Analyst Sales]
GROUP BY PRODUCTCODE
ORDER BY [Total quantity sold] DESC;

 Query 16: Sales by territory/country
 Insight: Shows which regions generate the most revenue
SELECT 
    COUNTRY AS [Country],
    CAST(SUM(SALES) AS INT) AS [Total sales]
FROM [Analyst Sales]
GROUP BY COUNTRY
ORDER BY [Total sales] DESC;

 Query 17: Order status breakdown
 Insight: Shows how many orders are shipped, cancelled, on hold etc.
SELECT 
    STATUS AS [Status],
    COUNT(*) AS [Order count]
FROM [Analyst Sales]
GROUP BY STATUS
ORDER BY [Order count] DESC;

 Query 18: Deal size distribution
 Insight: Shows the proportion of small, medium, large deals
SELECT 
    DEALSIZE AS [Deal size],
    COUNT(*) AS [Number of orders],
    CAST(SUM(SALES) AS INT) AS [Total sales]
FROM [Analyst Sales]
GROUP BY DEALSIZE
ORDER BY [Total sales] DESC;

