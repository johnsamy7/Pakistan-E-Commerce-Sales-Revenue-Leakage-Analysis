#  Pakistan E-Commerce: End-to-End Analytics & BI Dashboard

An end-to-end data analytics project combining data cleaning, exploratory data analysis (EDA), advanced SQL querying, and interactive Power BI dashboards to analyze transaction trends, revenue leakage, customer behavior, and payment risk.

---

##  Project Summary

Using the Pakistan's Largest E-commerce Dataset (over 1M raw records from July 2016 to August 2018), this project tracks the full lifecycle of e-commerce operations:

- **Python (Jupyter Notebook)**: Cleaned, parsed, and validated raw transactional records
- **SQL (T-SQL / MS SQL Server)**: Structured advanced analytical queries for aggregation, customer segmentation, window functions, and MoM growth metrics
- **Power BI**: Built executive-level dashboards to visualize sales performance, payment channels, promotional impact, and customer lifetime value

---

##  Data Cleaning & Pipeline

The raw dataset contained **1,048,575 rows** and **26 columns** with empty entries, corrupted status labels, and formatting artifacts. The cleaning pipeline executed the following steps:

### Cleaning Process:
1. **Removed Unnecessary Columns & Empty Rows**
   - Dropped empty metadata columns (Unnamed: 21 through Unnamed: 25)
   - Removed `sales_commission_code` (>137k missing entries)
   - Eliminated empty trailing records

2. **Null & Text Normalization**
   - Replaced `\N` string tokens with null values
   - Filled missing category names with 'Others'
   - Fixed `#REF!` Excel errors in business status fields

3. **Consolidated Duplicate Statuses**
   - Merged duplicate refund labels (`order_refunded` and `refund` into `refunded`)
   - Ensured accurate financial reporting

4. **Type Casting & Anomaly Removal**
   - Cast transaction dates, customer IDs, and quantities into proper datetime and integer formats
   - Filtered out test orders, negative amounts, and zero-priced items

### Output:
- **Clean Dataset**: 582,008 records exported as `cleaned_ecommerce_data.csv` for SQL staging and Power BI modeling

---

##  Key Business Insights

### 1. Revenue & Fulfillment Health

| Metric | Value |
|--------|-------|
| **Gross Booked Volume** | ~$4.88B across 582K orders |
| **Settled/Realized Revenue** | ~$1.57B |
| **Revenue Leakage Rate** | 67.7% |
| **Canceled Orders** | ~$2.83B (34.4% of total volume) |
| **Refunds** | ~$412M (11.5% of total volume) |
| **High-Value Orders** (≥$2,000) | $4.60B+ of all platform sales |

**Key Takeaway**: Significant revenue leakage through cancellations and refunds requires operational improvements in order fulfillment and customer satisfaction.

---

### 2. Category & Product Demand

| Category | Total Sales | Units Ordered | Avg. Discount |
|----------|-------------|----------------|---------------|
| **Mobiles & Tablets** | $2.33B+ | 126K+ | $2,358 |
| **Appliances** | $656.8M | 58k+ | $1,029 |
| **Entertainment** | $538.9M | 27k+ | $2,730 |

**Promotional Impact**: Entertainment and Mobiles & Tablets showed the highest average discount dependency (~$2,730 and ~$2,358 per order respectively) to convert high-ticket sales.

**Key Takeaway**: Electronics dominate the platform, but heavy discounting is required to drive conversions in competitive categories.

---

### 3. Payment Method Risk & Performance

#### Revenue by Payment Channel:
| Payment Method | Revenue | Market Share | Cancel Rate |
|-----------------|---------|--------------|-------------|
| **Payaxis** | $1.14B | 23.4% | Low |
| **Cash on Delivery (COD)** | $1.06B | 21.8% | Low |
| **Easypay** | $916.1M | 18.8% | High |
| **Bank Alfalah** | $688.2M | 14.11% | **95.6%** |
| **Easypay MA** | $108.8M | 2.23% | **91.6%** |

**High Cancellation Channels**: Digital payment gateways such as Bank Alfalah (95.6% cancel rate) and Easypay MA (91.6% cancel rate) suffered from severe cancellation rates, highlighting operational friction in digital checkout verification.

**Key Takeaway**: Alternative payment methods (Payaxis, COD) are more reliable; digital gateways require UX/technical improvements.

---

### 4. Seasonality & Customer Growth

#### Annual Performance:
| Year | Orders | Sales | Peak Month |
|------|--------|-------|-----------|
| **2017** (Peak) | 289,643 | $2.14B | November |
| **2016-2018** | 582,008 | $4.87B | November |

#### Seasonality Patterns:
- **Q4 Super Surges**: November consistently drove peak sales across all years
  - November 2016: +173.6% MoM growth, reaching $268.3M (aligns with mega-sale events like Black Friday/11.11)
- **Top 10 VIP Customers**: Generated $183.41M across 2,778 orders
  - **Top Customer** (ID: 111057): $31.3M+ lifetime spend

**Key Takeaway**: Q4 mega-sale events are critical revenue drivers; VIP customer retention programs could unlock significant value.

---

##  Power BI Dashboards

### 1. **Executive Sales & Channel Dashboard**
- Total sales ($4.88B) and order volume (582K)
- Sales breakdown by product category
- Discount-to-sales correlation analysis
- Payment method market share and performance metrics

### 2. **Customer & Trend Dashboard**
- Monthly revenue trajectories (July 2016 – August 2018)
- Top VIP customers by order volume and total spend
- Customer segmentation and lifetime value analysis

---

##  Tech Stack

| Component | Technologies |
|-----------|---------------|
| **Data Processing** | Python (pandas, numpy, matplotlib, seaborn, plotly) |
| **Database & Analytics** | T-SQL, MS SQL Server (CTEs, Window Functions: DENSE_RANK, LAG, Conditional Aggregations) |
| **Business Intelligence** | Power BI Desktop |

---

##  Project Structure

```
Pakistan-E-Commerce-Sales-Revenue-Leakage-Analysis/
├── README.md                          # Project documentation
├── cleaned_ecommerce_data.csv         # Clean dataset (582,008 records)
├── notebooks/
│   └── data_cleaning_eda.ipynb        # Python data cleaning & EDA
├── sql/
│   └── analytics_queries.sql          # T-SQL analytical queries
├── dashboards/
│   ├── Executive_Sales_Dashboard.pbix # Power BI dashboard
│   └── Customer_Trend_Dashboard.pbix  # Customer analytics dashboard
└── data/
    └── raw_ecommerce_data.csv         # Raw dataset (1,048,575 records)
```

---

##  Key Recommendations

1. **Reduce Revenue Leakage**: Investigate cancellation drivers in digital payment gateways and optimize order fulfillment
2. **Optimize Discounting**: Develop targeted promotional strategies for high-discount-dependent categories
3. **Improve Digital Payments**: Address technical/UX barriers in Bank Alfalah and Easypay MA checkout flows
4. **Capitalize on Seasonality**: Plan inventory, marketing, and staffing for Q4 mega-sale events
5. **VIP Retention**: Implement loyalty programs and personalized engagement for top 10% customers

---

**Last Updated**: August 2026
