# 🛒 Walmart Sales Data Analysis

## 📌 About
This project aims to explore Walmart sales data to understand top-performing branches and products, sales trends of different products, and customer behavior. The goal is to analyze sales strategies and optimize them for better performance. The dataset was obtained from the Kaggle Walmart Sales Forecasting Competition.

> "In this recruiting competition, job-seekers are provided with historical sales data for 45 Walmart stores located in different regions. Each store contains many departments, and participants must project the sales for each department in each store. To add to the challenge, selected holiday markdown events are included in the dataset. These markdowns are known to affect sales, but it is challenging to predict which departments are affected and the extent of the impact." - *Kaggle Walmart Sales Forecasting Competition*

## 🎯 Purposes of the Project
The primary objective of this project is to gain insights into Walmart's sales data to understand the various factors affecting sales across different branches.

## 📊 About the Data
The dataset contains sales transactions from three different Walmart branches located in **Mandalay, Yangon, and Naypyitaw**. The data includes **17 columns** and **1000 rows**:

### **Columns Description:**
| Column | Description | Data Type |
|--------|-------------|------------|
| invoice_id | Invoice of the sales made | VARCHAR(30) |
| branch | Branch at which sales were made | VARCHAR(5) |
| city | The location of the branch | VARCHAR(30) |
| customer_type | The type of the customer | VARCHAR(30) |
| gender | Gender of the customer making purchase | VARCHAR(10) |
| product_line | Product line of the product sold | VARCHAR(100) |
| unit_price | The price of each product | DECIMAL(10, 2) |
| quantity | The amount of the product sold | INT |
| VAT | The amount of tax on the purchase | FLOAT(6, 4) |
| total | The total cost of the purchase | DECIMAL(10, 2) |
| date | The date on which the purchase was made | DATE |
| time | The time at which the purchase was made | TIMESTAMP |
| payment_method | The total amount paid | DECIMAL(10, 2) |
| cogs | Cost Of Goods Sold | DECIMAL(10, 2) |
| gross_margin_percentage | Gross margin percentage | FLOAT(11, 9) |
| gross_income | Gross Income | DECIMAL(10, 2) |
| rating | Rating | FLOAT(2, 1) |

---

## 📌 Analysis List

### **1️⃣ Product Analysis**
- Analyze different product lines, identify best-performing ones, and determine those needing improvement.

### **2️⃣ Sales Analysis**
- Identify sales trends to measure the effectiveness of current sales strategies and suggest modifications.

### **3️⃣ Customer Analysis**
- Understand customer segments, purchasing trends, and the profitability of each segment.

---

## 🛠️ Approach Used

### **1️⃣ Data Wrangling**
- Inspect and clean the dataset to remove or replace NULL values.
- Build a structured database.
- Create tables and insert the cleaned data.
- Ensure no NULL values exist by setting **NOT NULL** constraints in the database schema.

### **2️⃣ Feature Engineering**
- Create new columns for deeper insights:
  - **time_of_day**: Categorize sales as Morning, Afternoon, or Evening.
  - **day_name**: Extract the weekday (Mon, Tue, etc.) of the transaction.
  - **month_name**: Extract the month (Jan, Feb, etc.) to identify seasonal trends.

### **3️⃣ Exploratory Data Analysis (EDA)**
- Perform statistical and visual analysis to answer the key business questions.

---

## 📌 Business Questions to Answer

### **Generic Questions**
- How many unique cities are in the dataset?
- Which city corresponds to each branch?

### **Product Analysis**
- How many unique product lines exist?
- What is the most common payment method?
- Which product line has the highest sales?
- What is the total revenue per month?
- Which month had the highest **COGS**?
- Which product line generated the highest revenue?
- Which city had the highest revenue?
- Which product line had the highest VAT?
- Which product lines performed above average ("Good") vs. below average ("Bad")?
- Which branch sold more than the average number of products?
- What is the most common product line by gender?
- What is the average rating per product line?

### **Sales Analysis**
- What are the number of sales per time of day on each weekday?
- Which customer type generates the most revenue?
- Which city has the highest tax percentage (VAT)?
- Which customer type pays the most VAT?

### **Customer Analysis**
- How many unique customer types exist?
- How many unique payment methods exist?
- What is the most common customer type?
- Which customer type purchases the most?
- What is the gender distribution of customers?
- What is the gender distribution per branch?
- What time of day receives the most customer ratings?
- What time of day receives the most customer ratings per branch?
- Which day of the week has the highest average ratings?
- Which day of the week has the highest average ratings per branch?

---

## 📌 Revenue & Profit Calculations

### **Key Formulas**

💰 **Cost of Goods Sold (COGS)**
\[ COGS = unit\_price \times quantity \]

💰 **VAT Calculation**
\[ VAT = 5\% \times COGS \]

💰 **Total Revenue**
\[ total\_sales = VAT + COGS \]

💰 **Gross Profit**
\[ gross\_income = total\_sales - COGS \]

💰 **Gross Margin Percentage**
\[ Gross Margin \% = \frac{gross\ income}{total\ revenue} \times 100 \]

### **Example Calculation (First Row in Dataset)**

Given:
- **Unit Price** = 45.79
- **Quantity** = 7

📌 **Calculations**
- **COGS** = 45.79 × 7 = **320.53**
- **VAT** = 5% × 320.53 = **16.03**
- **Total Sales** = 16.03 + 320.53 = **336.56**
- **Gross Margin Percentage** = (16.03 / 336.56) × 100 ≈ **4.76%**

---
