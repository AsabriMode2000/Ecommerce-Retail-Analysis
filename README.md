# E-Commerce Retail Sales Analysis

## Project Overview

This project is an end-to-end retail analytics project built to evaluate **sales performance, profitability, customer behavior, product performance, regional performance, discount impact, and sales trends**.

The workflow covers the complete analytics lifecycle:

**Raw Dataset → Google Colab / Python → Data Cleaning & EDA → Microsoft SQL Server → SQL Analysis → Power BI → Interactive Dashboard**

The final Power BI report contains four analytical pages:

1. **Executive Overview**
2. **Product & Profitability**
3. **Customer & Geography**
4. **Sales Trends**

---

## Dataset

**Dataset:** Sample Superstore  
**Business type:** Fictional U.S. retail superstore  
**Period:** 2014–2017  
**Transaction rows:** 9,994  
**Distinct orders:** 5,009  
**Customers:** 793  
**Source fields:** 21

Main fields used in the analysis include:

- Order ID
- Order Date
- Ship Date
- Ship Mode
- Customer ID
- Customer Name
- Segment
- Country
- City
- State
- Region
- Product ID
- Category
- Sub-Category
- Product Name
- Sales
- Quantity
- Discount
- Profit

> **Dataset note:** The KPI values in this README correspond to the standard 9,994-row Sample Superstore dataset. If the source file is changed, filtered, or deduplicated differently, refresh the figures from the Power BI report before publishing.

---

## Tools & Technologies

| Tool | Purpose |
|---|---|
| **Python / pandas** | Data cleaning, transformation, validation, feature engineering, and exploratory analysis |
| **Google Colab** | Python analysis environment |
| **Microsoft SQL Server** | Storage and relational analysis of the cleaned dataset |
| **SQL Server Management Studio (SSMS)** | Database management, SQL querying, validation, and views |
| **Power BI Desktop** | Data modeling, DAX measures, interactive visualization, and dashboard development |
| **DAX** | KPI calculations and time-intelligence analysis |
| **Git / GitHub** | Project documentation and portfolio publishing |

---

## Business Questions

The analysis was designed to answer the following questions:

- What are total sales, total profit, profit margin, orders, customers, and average order value?
- How are sales and profit changing over time?
- Which categories and sub-categories generate the most sales and profit?
- Which products generate high revenue but weak or negative profit?
- Which products are the largest loss-makers?
- Which customer segments contribute the most sales and profit?
- Who are the highest-value customers by sales and by profit?
- Which regions and states perform best and worst?
- Are higher discounts associated with weaker profitability?
- How does the latest year's performance compare with the previous year?

---

## Data Preparation

The raw dataset was cleaned and prepared in **Google Colab** using **Python and pandas**.

Key preparation steps included:

- Inspecting the dataset structure and data types
- Checking missing values
- Detecting and handling duplicate rows
- Converting order and shipping dates to date types
- Validating `Sales`, `Profit`, `Quantity`, and `Discount`
- Standardizing column names
- Creating Year, Month, Quarter, and Year-Month fields
- Calculating shipping duration
- Validating critical transaction fields
- Exporting the cleaned dataset to CSV for Microsoft SQL Server

Example workflow:

```python
import pandas as pd

df = pd.read_excel("Sample - Superstore.xls", sheet_name="Orders")

df.columns = (
    df.columns
      .str.strip()
      .str.lower()
      .str.replace(" ", "_")
      .str.replace("-", "_")
)

df["order_date"] = pd.to_datetime(df["order_date"])
df["ship_date"] = pd.to_datetime(df["ship_date"])

df["year"] = df["order_date"].dt.year
df["month"] = df["order_date"].dt.month
df["quarter"] = "Q" + df["order_date"].dt.quarter.astype(str)
df["year_month"] = df["order_date"].dt.to_period("M").astype(str)
df["shipping_days"] = (df["ship_date"] - df["order_date"]).dt.days

df.to_csv("superstore_cleaned.csv", index=False)
```

---

## Microsoft SQL Server Analysis

The cleaned CSV was imported into **Microsoft SQL Server** and analyzed using SQL.

The SQL work covered:

- Dataset validation
- Overall business KPIs
- Monthly and yearly sales trends
- Category and sub-category performance
- Regional performance
- Customer segment analysis
- Top customers
- Top products by sales and profit
- Loss-making products
- Discount-level profitability
- Reusable SQL reporting views

Example KPI query:

```sql
SELECT
    ROUND(SUM(sales), 2) AS TotalSales,
    ROUND(SUM(profit), 2) AS TotalProfit,
    COUNT(DISTINCT order_id) AS TotalOrders,
    COUNT(DISTINCT customer_id) AS TotalCustomers,
    SUM(quantity) AS TotalQuantity
FROM dbo.superstore_cleaned;
```

Example product-profitability query:

```sql
SELECT TOP 10
    product_name,
    ROUND(SUM(sales), 2) AS TotalSales,
    ROUND(SUM(profit), 2) AS TotalProfit
FROM dbo.superstore_cleaned
GROUP BY product_name
ORDER BY TotalProfit ASC;
```

---

## Power BI Data Model

A dedicated **DateTable** was created and related to the transaction table through `order_date`.

Relationship:

```text
DateTable[Date]  1 ───────── *  superstore_cleaned[order_date]
```

This supports consistent date filtering and time-intelligence calculations.

### Main DAX Measures

```DAX
Total Sales =
SUM(superstore_cleaned[sales])

Total Profit =
SUM(superstore_cleaned[profit])

Total Orders =
DISTINCTCOUNT(superstore_cleaned[order_id])

Total Customers =
DISTINCTCOUNT(superstore_cleaned[customer_id])

Total Quantity =
SUM(superstore_cleaned[quantity])

Profit Margin % =
DIVIDE([Total Profit], [Total Sales], 0)

Average Order Value =
DIVIDE([Total Sales], [Total Orders], 0)

Sales LY =
CALCULATE(
    [Total Sales],
    SAMEPERIODLASTYEAR(DateTable[Date])
)

Sales YoY % =
DIVIDE(
    [Total Sales] - [Sales LY],
    [Sales LY],
    0
)

Profit LY =
CALCULATE(
    [Total Profit],
    SAMEPERIODLASTYEAR(DateTable[Date])
)

Profit YoY % =
DIVIDE(
    [Total Profit] - [Profit LY],
    [Profit LY],
    0
)
```

Additional measures used in the report include:

- Profitable Products
- Loss-Making Products
- Average Sales per Customer
- Average Profit per Customer
- Average Orders per Customer
- Customer Profit Margin %
- Sales YTD
- Profit YTD

---

## KPI Summary

| KPI | Result |
|---|---:|
| **Total Sales** | **$2,297,200.86** |
| **Total Profit** | **$286,397.02** |
| **Profit Margin** | **12.47%** |
| **Distinct Orders** | **5,009** |
| **Customers** | **793** |
| **Quantity Sold** | **37,873** |
| **Average Order Value** | **$458.61** |
| **2017 Sales YoY Growth** | **20.36%** |
| **2017 Profit YoY Growth** | **14.24%** |

---

## Dashboard Pages

### 1. Executive Overview

Provides a high-level view of business performance through:

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
- Interactive filters for Year, Region, Category, and Segment

### 2. Product & Profitability

Focuses on product-level profitability and discount behavior:

- Sales and Profit by Sub-Category
- Top 10 Products by Sales
- Top 10 Products by Profit
- Bottom 10 Loss-Making Products
- Sales vs Profit
- Discount vs Profit
- Profit by Discount Level
- Product Performance Table
- Profitable vs Loss-Making Products
- Region, Category, and Sub-Category filtering

### 3. Customer & Geography

Analyzes customer and geographic performance:

- Top Customers by Sales
- Top Customers by Profit
- Sales by Customer Segment
- Profit by Customer Segment
- Sales by Region
- Profit by Region
- Regional Profit Margin
- State-level performance
- Customer Performance Detail
- Interactive geographic analysis

### 4. Sales Trends

Provides time-based performance analysis:

- Total Sales
- Total Profit
- Sales YoY %
- Profit YoY %
- Monthly Sales Trend
- Monthly Profit Trend
- Quarterly Sales
- Yearly Sales
- Yearly Profit
- YTD measures

---

## Key Business Insights

### 1. Overall Performance

The business generated **$2.30M in sales** and **$286.40K in profit**, producing an overall **12.47% profit margin**.

This indicates that the business is profitable overall, but the gap between revenue and profit makes product mix, discounting, and regional profitability important areas for management attention.

### 2. Sales Growth

Sales increased from approximately **$609.21K in 2016 to $733.22K in 2017**, representing **20.36% year-over-year growth**.

Profit also increased to approximately **$93.44K in 2017**, about **14.24% above 2016**.

The business therefore ended the period with its strongest annual sales performance.

### 3. Category Performance

| Category | Sales | Profit | Profit Margin |
|---|---:|---:|---:|
| Technology | $836,154.03 | $145,454.95 | 17.40% |
| Furniture | $741,999.80 | $18,451.27 | 2.49% |
| Office Supplies | $719,047.03 | $122,490.80 | 17.04% |

**Technology** generated both the highest sales and highest total profit.

**Furniture**, however, generated more than **$741K in sales** while producing only about **$18.45K in profit**, making it the weakest category from a margin perspective.

### 4. Sub-Category Profitability Risk

The **Tables** sub-category is a major profitability concern.

- Sales: approximately **$206.97K**
- Profit: approximately **-$17.73K**
- Profit Margin: approximately **-8.56%**

Other loss-making sub-categories include **Bookcases** and **Supplies**.

This shows that strong sales do not automatically translate into healthy profitability.

### 5. Product-Level Performance

The **Canon imageCLASS 2200 Advanced Copier** is the strongest product in the dataset, generating approximately:

- **$61.60K in sales**
- **$25.20K in profit**

In contrast, the **Cubify CubeX 3D Printer Double Head Print** is the largest product-level loss-maker, generating a total loss of approximately **-$8.88K**.

The dashboard therefore highlights why management should evaluate products using both **sales and profit**, rather than sales alone.

### 6. Discount Impact

Discounting shows one of the clearest profitability patterns in the dataset.

Orders with discounts of **20% or less** remain substantially healthier, while profitability turns negative once discounts move above roughly **20%**.

Higher discount bands show increasingly negative margins, indicating that aggressive discounting is a major source of profit erosion.

This does not by itself prove that discounts cause every loss, but it provides a strong signal for further pricing and promotion analysis.

### 7. Regional Performance

| Region | Sales | Profit | Profit Margin |
|---|---:|---:|---:|
| West | $725,457.82 | $108,418.45 | 14.94% |
| East | $678,781.24 | $91,522.78 | 13.48% |
| Central | $501,239.89 | $39,706.36 | 7.92% |
| South | $391,721.91 | $46,749.43 | 11.94% |

The **West** is the strongest region by both total sales and total profit.

The **Central** region has the weakest profit margin at approximately **7.92%**, despite generating more sales than the South.

This makes Central a priority for deeper analysis of product mix, state performance, and discounting.

### 8. State-Level Risk

**Texas** is the largest state-level loss-maker in the dataset, with approximately **-$25.73K in profit**.

This indicates that geographic profitability should be assessed below the regional level because strong overall regional performance can hide weak states.

### 9. Customer Segment Performance

The **Consumer** segment contributes the largest share of total sales and the largest absolute profit.

However, the **Home Office** segment has a stronger profit rate relative to its sales than the Consumer segment.

This suggests that customer segments should be evaluated using both revenue contribution and profitability rather than revenue alone.

### 10. Customer-Level Insight

**Sean Miller** is the highest-sales customer at approximately **$25.04K in sales**, but generated approximately **-$1.98K in profit**.

Meanwhile, **Tamara Chand** is the most profitable customer, generating approximately **$8.98K in profit** from about **$19.05K in sales**.

This is a strong example of why customer value should be measured by **profitability**, not only by spending.

---

## Regional Profitability Observation

Filtering the product profitability analysis by region can change which products appear in the bottom-loss rankings.

A product may be profitable overall but unprofitable in a particular region because of differences in:

- Discount levels
- Product mix
- Customer mix
- Order volume
- Local pricing behavior

For this reason, product decisions should not be based only on company-wide totals. Regional context should be reviewed before changing pricing, discounting, or product strategy.

---

## Business Recommendations

1. **Control aggressive discounting**  
   Introduce approval rules or tighter limits for discounts above 20%, especially for products and states already producing losses.

2. **Review Furniture profitability**  
   Investigate pricing and discount strategy for Tables and Bookcases. Furniture generates strong revenue but a very weak overall margin.

3. **Investigate loss-making products individually**  
   Products such as the Cubify CubeX 3D Printer should be reviewed for price, discount, supplier cost, and continued inclusion in the product portfolio.

4. **Prioritize profitable Technology products**  
   Technology is the strongest category, with Copiers and products such as the Canon imageCLASS 2200 Advanced Copier generating significant profit.

5. **Use the West as a performance benchmark**  
   Review the West region's product mix and pricing practices and determine which successful approaches can be transferred to weaker regions.

6. **Investigate the Central region and loss-making states**  
   Focus specifically on states with negative profit and identify whether discount policy, product mix, or customer behavior is driving the losses.

7. **Measure customer value using profit as well as sales**  
   High-spending customers are not always profitable. Retention and loyalty efforts should prioritize profitable customers rather than ranking customers only by revenue.

8. **Plan for seasonal demand**  
   Sales are strongest toward the end of the year. Inventory, staffing, and promotional planning should account for these seasonal peaks.

---

## Project Deliverables

The completed project consists of:

- Cleaned retail transaction dataset
- Google Colab Python analysis notebook
- Microsoft SQL Server database
- SQL analysis queries and reporting views
- Power BI semantic model
- DAX measures
- Four-page interactive Power BI dashboard
- Business findings and recommendations
- GitHub project documentation

---

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
│   ├── sales_analysis.sql
│   ├── product_analysis.sql
│   ├── customer_analysis.sql
│   └── views.sql
│
├── powerbi/
│   └── Ecommerce_Retail_Sales_Analysis.pbix
│
├── images/
│   ├── executive-overview.png
│   ├── product-profitability.png
│   ├── customer-geography.png
│   └── sales-trends.png
│
└── docs/
    └── Ecommerce_Retail_Sales_Dashboard.pdf
```

---

## How to Reproduce the Project

### 1. Prepare the data

Open the analysis notebook in Google Colab and run the cleaning and transformation steps.

Export:

```text
superstore_cleaned.csv
```

### 2. Load the data into SQL Server

Create the project database:

```sql
CREATE DATABASE ECommerceRetailDB;
```

Import `superstore_cleaned.csv` into the database and verify the row counts, dates, and numeric fields.

### 3. Run the SQL analysis

Execute the SQL files in the `sql/` folder to reproduce:

- KPI analysis
- Sales trends
- Product analysis
- Customer analysis
- Regional analysis
- Reporting views

### 4. Open the Power BI report

Open:

```text
powerbi/Ecommerce_Retail_Sales_Analysis.pbix
```

Refresh the model if the SQL Server connection is available.

### 5. Explore the report

Use the interactive slicers for:

- Year
- Region
- Category
- Sub-Category
- Segment

to compare performance across different areas of the business.

---

## Skills Demonstrated

- Data Cleaning
- Data Transformation
- Exploratory Data Analysis
- Python
- pandas
- Google Colab
- SQL
- Microsoft SQL Server
- SSMS
- SQL Views
- Data Validation
- Relational Data Analysis
- Data Modeling
- DAX
- Time Intelligence
- Power BI
- KPI Development
- Data Visualization
- Dashboard Design
- Customer Analysis
- Product Profitability Analysis
- Regional Analysis
- Business Analysis
- Business Insight Communication
- Data Storytelling

---

## Limitations

- The Sample Superstore dataset represents a **fictional business**, so findings should be treated as portfolio analysis rather than recommendations for a real company.
- The data covers **2014–2017**, so it is not intended to reflect current retail market conditions.
- Profit and discount relationships identify **associations**, not proof of causation.
- The dataset does not provide a complete cost breakdown, supplier costs, marketing spend, inventory carrying costs, or other operational expenses.
- Findings can change when filters are applied; regional and product-level context should therefore be reviewed before drawing conclusions.

---

## Author

**Mohamed Aboelftooh Sabry**

Data Analytics Portfolio Project  
**Python | pandas | Microsoft SQL Server | Power BI | DAX**
