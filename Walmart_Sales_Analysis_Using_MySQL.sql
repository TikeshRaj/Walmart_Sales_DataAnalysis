-- 1.Data Wrangling: 
-- This is the first step where inspection of data is done to make sure NULL values
-- And missing values are detected and data replacement methods are used to replace, missing or NULL values.
SELECT *
FROM sales_walmart
;
 
-- Create Copy of the DataSet 
CREATE TABLE sales
LIKE sales_walmart 
;

-- Insert All the values Into sales table from sales_walmart table
INSERT sales
SELECT *
FROM sales_walmart;

SELECT *
FROM sales;

-- Remove duplicates 
-- Using Dense_rank() with partions assign unique value as '1', if any duplicate data find then it assign value as '2'
SELECT *,
  DENSE_RANK() OVER (
  PARTITION BY "Invoice ID",City,"Product line",`Date` ) AS row_num
FROM sales
ORDER BY row_num DESC
;
-- With CTE function check is there any duplicate values are present.
WITH duplicate_CTE AS
(
SELECT *,
DENSE_RANK() OVER (
PARTITION BY "Invoice ID",City,"Product line",`Date` ) AS row_num
FROM sales
ORDER BY row_num DESC
)
SELECT *
FROM duplicate_CTE 
WHERE row_num > 1
;

-- 2.Feature Engineering:
-- This will help use generate some new columns from existing ones.
-- Add a new column named "time_of_day" to give insight of sales in the Morning, Afternoon and Evening. 
-- This will help answer the question on which part of the day most sales are made.

SELECT `Time`
FROM sales
;

SELECT `Time`,
CASE
	WHEN `Time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
    WHEN `Time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
    ELSE
		"Evening"
END AS Time_of_Date
FROM sales
;

ALTER TABLE sales ADD COLUMN Time_of_Day VARCHAR(10);

UPDATE sales 
SET Time_of_Day = 
CASE
	WHEN `Time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
    WHEN `Time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
    ELSE
		"Evening"
END
;

SELECT * 
FROM sales;

-- Add a new column named "day_name" that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). 
-- This will help answer the question on which week of the day each branch is busiest.

SELECT `Date`,
DAYNAME(`Date`) AS Day_names
FROM sales;

ALTER TABLE sales ADD COLUMN Day_name VARCHAR(10);

UPDATE sales 
SET Day_name = DAYNAME(`Date`);

SELECT * 
FROM sales;

-- Add a new column named "month_name" that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). 
-- Help determine which month of the year has the most sales and profit.

SELECT `Date`,
MONTHNAME(`Date`)
FROM sales;

ALTER TABLE sales ADD COLUMN Month_Name VARCHAR(10);

UPDATE sales
SET Month_Name = MONTHNAME(`Date`);

SELECT *
FROM sales;

-- ------------------------------------------------------------------------
-- Exploratory Data Analysis (EDA)
-- --------------------- Generic Question ------------------------------------------ 
-- 1.How many unique cities does the data have?
SELECT *
FROM sales;

SELECT DISTINCT City
FROM sales;

-- 2.Which city is each branch?
SELECT DISTINCT City,Branch
FROM sales;
-- ------------------------------------------------------------------------
-- -------------------------- Product ------------------------------------- 
-- 1.How many unique product lines does the data have?
SELECT COUNT(DISTINCT `Product line`) AS Count_ProductLine
FROM sales;

-- 2.What is the most common payment method?
SELECT Payment,
COUNT(Payment) AS Count
FROM sales
GROUP BY Payment
ORDER BY Count DESC
;

-- 3.What is the most selling product line?
SELECT `Product line`,
COUNT(`Product line`) AS Count
FROM sales
GROUP BY `Product line`
ORDER BY Count DESC
;
-- Another Method Using "LIMIT 1"
SELECT  `Product line`,
COUNT(`Product line`) AS Count
FROM sales
GROUP BY `Product line`
ORDER BY Count DESC
LIMIT 1
;


-- 4.What is the total revenue by month?
SELECT 
	Month_Name AS `Month`,
    SUM(Total) AS Total_Revenue
FROM sales
GROUP BY `Month`
ORDER BY Total_Revenue
;

-- 5.What month had the largest Cost of goods sold (COGS)?
SELECT 
Month_Name AS `Month`,
SUM(cogs) AS COGS
FROM sales
GROUP BY `Month`
ORDER BY COGS DESC
LIMIT 1
;

-- 6.What product line had the largest revenue?
SELECT `Product line` AS Product, 
SUM(Total) AS Revenue
FROM sales
GROUP BY Product
ORDER BY Revenue DESC
LIMIT 1
;

-- 7.What is the city with the largest revenue?
SELECT City,
SUM(Total) AS Revenue
FROM sales
GROUP BY City
ORDER BY Revenue DESC
LIMIT 1
;

-- 8.What product line had the largest value-added tax(VAT)?
SELECT 
`Product line` AS Product,
AVG(`Tax 5%`) AS value_added_tax
FROM sales
GROUP BY Product
ORDER BY value_added_tax DESC
-- LIMIT 1
;

-- 10.Which branch sold more products than average product sold?
SELECT 
Branch,
SUM(Quantity) AS Product_sold
FROM sales 
GROUP BY Branch
HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM sales )
;

-- 11.What is the most common product line by gender?
SELECT 
`Product line`,
Gender ,
COUNT(Gender) AS Gender_Count
FROM sales
GROUP BY `Product line`, Gender 
ORDER BY Gender_Count DESC
;

-- 12.What is the average rating of each product line?
SELECT
`Product line`,
ROUND(AVG(Rating),2) AS AVG_Rating
FROM sales
GROUP BY `Product line`
ORDER BY AVG_Rating DESC
;

-- ------------------------------------------------------------------------
-- --------------------- Sales --------------------------------------------
-- 1.Number of sales made in each time of the day per weekday?
SELECT 
Day_name,
Time_of_Day,
COUNT(*) AS  Number_of_Sales
FROM sales
GROUP BY Day_name,Time_of_Day
ORDER BY Number_of_Sales DESC
;

-- 2.Which of the customer types brings the most revenue?
SELECT
`Customer type`,
SUM(Total) AS Revenue
FROM sales
GROUP BY `Customer type`
ORDER BY Revenue DESC
;

-- 3.Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT City,
ROUND(SUM(`Tax 5%`),2) AS Tax_percent
FROM sales
GROUP BY City
ORDER BY Tax_percent DESC
LIMIT 1
;

-- 4.Which customer type pays the most in VAT?
SELECT `Customer type`,
ROUND(SUM(`Tax 5%`),2) AS Tax_percent
FROM sales
GROUP BY `Customer type`
ORDER BY Tax_percent DESC
LIMIT 1
;

-- ---------------------------------------------------------------------------
-- --------------------- Customer --------------------------------------------
-- 1.How many unique customer types does the data have?
SELECT COUNT(DISTINCT `Customer type`) AS COUNT
FROM sales;

-- 2.How many unique payment methods does the data have?
SELECT COUNT(DISTINCT Payment) AS COUNT
FROM sales;

-- 3.What is the most common customer type?
SELECT `Customer type`,
COUNT(*) AS Customer_Count
FROM sales
GROUP BY `Customer type`
ORDER BY Customer_Count
LIMIT 1
;

-- 4.Which customer type buys the most?
SELECT `Customer type`,
SUM(Quantity) AS Buys
FROM sales
GROUP BY `Customer type`
ORDER BY Buys DESC
LIMIT 1
;

-- 5.What is the gender of most of the customers?
SELECT Gender ,
COUNT(`Customer type`) AS Customer
FROM sales
GROUP BY Gender
ORDER BY Customer DESC 
LIMIT 1
;

-- 6.What is the gender distribution per branch?
SELECT `Branch`, `Gender`, COUNT(*) AS Customer_Count
FROM sales
GROUP BY `Branch`, `Gender`
ORDER BY `Branch`, Customer_Count DESC;

-- 7.Which time of the day do customers give most ratings?
SELECT `Time_of_Day`, 
COUNT(`Rating`) AS Total_Ratings
FROM sales
GROUP BY `Time_of_Day`
ORDER BY Total_Ratings DESC
LIMIT 1;

-- 8.Which time of the day do customers give most ratings per branch?
SELECT `Time_of_Day`,
Branch, 
COUNT(`Rating`) AS Total_Ratings
FROM sales
GROUP BY `Time_of_Day`,Branch
ORDER BY Branch, Total_Ratings DESC
;

-- 9.Which day fo the week has the best avg ratings?
SELECT `Day_name`, ROUND(AVG(`Rating`),2) AS Avg_Rating
FROM sales
GROUP BY `Day_name`
ORDER BY Avg_Rating DESC
LIMIT 1;


-- 10.Which day of the week has the best average ratings per branch?
SELECT Branch, `Day_name`, ROUND(AVG(`Rating`),2) AS Avg_Rating
FROM sales
GROUP BY Branch, `Day_name`
ORDER BY Branch, Avg_Rating DESC
LIMIT 1;

