# Amazon Sales Analysis — SQL + Python

## Project Overview
Analyzed 1,465+ Amazon product listings using SQL and Python to uncover pricing patterns, discount impact on customer ratings, and top-performing categories.

## Tools Used
- **SQL (MySQL)** — Data extraction & analysis
- **Python (Pandas, Matplotlib, Seaborn)** — Data cleaning & visualization
- **Google Colab** — Notebook environment

## Key Insights
- 📊 **OfficeProducts** category has the highest average customer rating
- 💰 **Higher discounts do NOT guarantee better ratings** — Low discount products rated slightly higher (4.15 vs 4.07)
- 🛒 **44.4% products are Mid-range (₹500–2000)** — Amazon's largest price segment
- ⭐ **Mid-range products** have the best average rating (4.10) across all price segments

## SQL Queries Covered
- Top categories by average rating
- Discount impact analysis using CASE WHEN
- Top 3 products per category using **RANK() Window Function**
- Price segment analysis using REGEXP_REPLACE
- Best value products (high rating + high discount)

## Python Analysis
- Data cleaning (price symbols, commas removed)
- Bar chart — Top categories by rating
- Scatter plot — Discount % vs Customer rating
- Pie chart — Product distribution by price segment

## Dataset
[Amazon Sales Dataset — Kaggle](https://www.kaggle.com/datasets/karkavelrajaj/amazon-sales-dataset) | 1,465 rows × 16 columns
