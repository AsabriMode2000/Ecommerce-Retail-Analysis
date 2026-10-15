# E-Commerce Retail Sales Analysis

## Project Overview

This project analyzes retail transaction data to evaluate sales performance, profitability, customer behavior, product performance, regional performance, discount impact, and sales trends.

The project follows an end-to-end analytics workflow:

**Raw Dataset → Google Colab / Python → Data Cleaning & EDA → Microsoft SQL Server → SQL Analysis → Power BI → Interactive Dashboard**

## Tools & Technologies

- **Python / pandas** — data cleaning, transformation, validation, and exploratory analysis
- **Google Colab** — Python analysis environment
- **Microsoft SQL Server / SSMS** — data storage, SQL querying, validation, aggregation, and views
- **Power BI Desktop** — data modeling, DAX measures, visualization, and dashboard development
- **DAX** — KPI and time-intelligence calculations

## Business Questions

The analysis was designed to answer questions such as:

- What are total sales, profit, profit margin, orders, customers, and average order value?
- How are sales and profit changing over time?
- Which categories and sub-categories generate the highest sales and profit?
- Which products generate strong revenue but weak or negative profit?
- Which products are the largest loss-makers?
- Which customer segments contribute the most sales and profit?
- Who are the highest-value customers?
- Which regions and states perform best?
- Are higher discounts associated with weaker profitability?
- How does current performance compare with the previous year?

## Data Preparation

The dataset was cleaned and prepared in Google Colab using Python and pandas.

Key steps included:

- Inspecting data types and dataset structure
- Checking missing values
- Detecting and removing duplicate rows
- Converting order and shipping dates to proper date types
- Validating numeric fields such as sales, profit, quantity, and discount
- Creating time-based fields for year, month, quarter, and year-month
- Calculating shipping duration
- Exporting the cleaned dataset for Microsoft SQL Server

## SQL Analysis

The cleaned data was imported into **Microsoft SQL Server**.

SQL analysis included:

- Overall sales and profitability KPIs
- Monthly sales and profit trends
- Category and sub-category performance
- Regional performance
- Customer segment analysis
- Top products by sales and profit
- Loss-making products
- Top customers
- Discount-level profitability analysis
- Data validation queries
- Reusable SQL views for reporting

## Power BI Data Model

A dedicated date table was created and related to the transaction table using the order date.

### Main Measures

- Total Sales
- Total Profit
- Total Orders
- Total Customers
- Total Quantity
- Profit Margin %
- Average Order Value
- Sales LY
- Sales YoY %
- Profit LY
- Profit YoY %
- Profitable Products
- Loss-Making Products
- Average Sales per Customer
- Average Orders per Customer

## Dashboard Pages

### 1. Executive Overview

Provides a high-level view of business performance using:

- Total Sales
- Total Profit
- Profit Margin
- Total Orders
- Total Customers
- Average Order Value
- Sales YoY %
- Monthly Sales & Profit Trend
- Sales by Category
- Profit by Region
- Sales by Customer Segment

### 2. Product & Profitability

Focuses on product-level performance and profitability:

- Sales and Profit by Sub-Category
- Top Products by Sales
- Top Products by Profit
- Bottom Loss-Making Products
- Sales vs Profit
- Discount vs Profit
- Product Performance Table
- Profitable vs Loss-Making Products

### 3. Customer & Geography

Analyzes customers and geographic performance:

- Top Customers by Sales
- Top Customers by Profit
- Sales by Customer Segment
- Profit by Customer Segment
- Sales by Region
- Profit by Region
- Sales Performance by State
- Customer Performance Detail

### 4. Sales Trends

Provides time-based analysis:

- Total Sales
- Total Profit
- Sales YoY %
- Profit YoY %
- Monthly Sales Trend
- Monthly Profit Trend
- Quarterly Sales
- Yearly Sales
- Yearly Profit

## Key Business Insights

Replace the placeholders below with the values from the final Power BI dashboard.

1. **Overall Performance:** The business generated **[TOTAL SALES]** in sales and **[TOTAL PROFIT]** in profit, resulting in a **[PROFIT MARGIN]%** profit margin.
2. **Sales Trend:** Sales **[increased/decreased]** by **[YOY %]** compared with the previous year.
3. **Best Category:** **[CATEGORY]** generated the highest sales, while **[CATEGORY]** generated the highest profit.
4. **Profitability Risk:** **[SUB-CATEGORY / PRODUCT]** showed weak or negative profitability despite generating sales.
5. **Discount Impact:** Transactions with **[DISCOUNT GROUP]** discounts showed **[higher/lower]** profitability, indicating that discount strategy should be reviewed.
6. **Best Region:** **[REGION]** was the strongest region by **[sales/profit/profit margin]**.
7. **Customer Segment:** **[SEGMENT]** contributed the largest share of sales, while **[SEGMENT]** produced the strongest profitability.
8. **Top Customer:** **[CUSTOMER]** was the highest-value customer by sales, while **[CUSTOMER]** generated the highest profit.
9. **Loss-Making Products:** The analysis identified products with negative profit that should be reviewed for pricing, discounting, cost structure, or discontinuation.
10. **Management Recommendation:** Focus on high-margin categories and regions, review heavy discounting, and investigate high-revenue products that generate weak or negative profit.

## Dashboard Preview

Add exported dashboard screenshots here:

```text
images/
├── executive-overview.png
├── product-profitability.png
├── customer-geography.png
└── sales-trends.png
```

Example:

```markdown
![Executive Overview](images/executive-overview.png)
```

## Repository Structure

```text
ecommerce-retail-sales-analysis/
│
├── README.md
│
├── data/
│   └── README.md
│
├── notebooks/
│   └── ecommerce_retail_analysis.ipynb
│
├── sql/
│   ├── create_database.sql
│   ├── create_table.sql
│   ├── data_validation.sql
│   ├── kpi_analysis.sql
│   ├── product_analysis.sql
│   ├── customer_analysis.sql
│   └── views.sql
│
├── powerbi/
│   └── Ecommerce Retail Analysis.pbix
│
├── images/
│   ├── executive-overview.png
│   ├── product-profitability.png
│   ├── customer-geography.png
│   └── sales-trends.png
│
└── docs/
    └── dashboard.pdf
```

## Skills Demonstrated

- Data Cleaning
- Exploratory Data Analysis
- Python
- pandas
- SQL
- Microsoft SQL Server
- Data Validation
- Data Modeling
- DAX
- Power BI
- KPI Development
- Data Visualization
- Business Analysis
- Dashboard Design
- Business Insight Communication

## Author

**Mohamed Aboelftooh Sabry**
