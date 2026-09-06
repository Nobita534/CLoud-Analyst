# Data Requirements

## 1. Overview

This document translates approved Business Questions, Business Requirements,
and Metric Dictionary definitions into concrete data requirements.

Traceability flow:

*Business Question → Business Requirement → Metric Definition → Data Requirement*

Each data requirement defines the analytical grain, dimensions, required
fields, source entities, and business rules needed for implementation in dbt
and Power BI.

---

## 2. Data Requirement Traceability

| DR ID | BQ | BR | Required Metrics | Analytical Grain |
|---|---|---|---|---|
| DR-01 | BQ1 | BR1 | KPI-02, KPI-03, KPI-09 | One customer × one snapshot date |
| DR-02 | BQ1 | BR2 | KPI-02, KPI-03, KPI-04, KPI-06, KPI-09 | One customer segment × one snapshot date |
| DR-03 | BQ2 | BR3 | KPI-01, KPI-04, KPI-09 | Segment × customer geography × snapshot |
| DR-04 | BQ2 | BR4 | KPI-02, KPI-03, KPI-04, KPI-06, KPI-09 | Customer geography × segment × snapshot |
| DR-05 | BQ3 | BR5 | KPI-07, KPI-10, KPI-11, KPI-12 | Product × customer geography × purchase date |
| DR-06 | BQ3 | BR6 | KPI-07, KPI-10, KPI-11, KPI-12 | Product category × customer geography × purchase date |
| DR-07 | BQ4 | BR7 | KPI-07, KPI-08, KPI-10, KPI-13, KPI-14, KPI-15 | Seller × purchase period |
| DR-08 | BQ4 | BR8 | KPI-07, KPI-08, KPI-10, KPI-13, KPI-14, KPI-15 | Seller × geography × purchase period |
| DR-09 | BQ5 | BR9 | KPI-01, KPI-04, KPI-07, KPI-16, KPI-17 | Purchase period |
| DR-10 | BQ5 | BR10 | KPI-01, KPI-04, KPI-07, KPI-16, KPI-17 | Comparable purchase period |
| DR-11 | BQ7 | BR13 | KPI-01, KPI-04, KPI-07 | Customer geography × purchase period |
| DR-12 | BQ8 | BR14 | KPI-08, KPI-13 | Product/category/seller × purchase period |
| DR-13 | BQ8 | BR15 | KPI-07, KPI-08, KPI-10, KPI-13 | Product/category/seller × purchase period |

---

## 3. Required Data by Analytical Domain

### 3.1. Customer and RFM Analysis

| Category | Required Data |
|---|---|
| Dimensions | Customer, Customer Segment, Snapshot Date, Customer Geography |
| Required Fields | customer_unique_id, customer_id, order_id, order_status, order_purchase_timestamp, payment_value, snapshot_date |
| Derived Attributes | recency, frequency, monetary, r_score, f_score, m_score, customer_segment |
| Source Entities | customers, orders, order_payments |
| Business Rules | Delivered orders only; rolling 12-month window; one customer × one snapshot; payment aggregated to order-grain before calculating Monetary |

### 3.2. Product and Category Analysis

| Category | Required Data |
|---|---|
| Dimensions | Product, Product Category, Customer State, Customer City, Purchase Date |
| Required Fields | product_id, product_category_name, order_id, order_item_id, price, freight_value, customer_state, customer_city, order_purchase_timestamp, order_status |
| Source Entities | products, product_category_translation, order_items, orders, customers |
| Business Rules | Delivered orders only; use item price for product sales; do not assign the full order payment to every product |

### 3.3. Seller Performance Analysis

| Category | Required Data |
|---|---|
| Dimensions | Seller, Seller Geography, Customer Geography, Purchase Date |
| Required Fields | seller_id, order_id, order_item_id, price, review_score, order_purchase_timestamp, order_delivered_customer_date, order_estimated_delivery_date, seller_state |
| Source Entities | sellers, order_items, orders, order_reviews, customers |
| Business Rules | Aggregate to seller-order grain before seller aggregation; orders without reviews remain in sales/order denominators; review metrics only use available reviews |

### 3.4. Revenue and Time Analysis

| Category | Required Data |
|---|---|
| Dimensions | Purchase Date, Customer Geography |
| Required Fields | order_id, customer_unique_id, order_status, order_purchase_timestamp, payment_value |
| Source Entities | orders, customers, order_payments |
| Business Rules | One row per delivered order with a payment record; payment aggregated before joining; partial-year periods must use same-period comparison |

### 3.5. Customer Satisfaction Analysis

| Category | Required Data |
|---|---|
| Dimensions | Product, Product Category, Seller, Purchase Date |
| Required Fields | review_id, review_score, order_id, product_id, seller_id, order_purchase_timestamp |
| Source Entities | order_reviews, orders, order_items, products, sellers |
| Business Rules | Review is recorded at order-grain; product/seller analysis represents association with an order review, not a product-specific or seller-specific review |

---

## 4. Data Quality Requirements

- customer_unique_id must be used as the customer-level analytical key.
- order_id must remain unique in order-grain metric datasets.
- Payment data must be aggregated to one row per order before downstream joins.
- Product and seller sales must be calculated from order_items.price.
- RFM data must be unique by customer_unique_id + snapshot_date.
- Product metrics must conform to their declared composite grain.
- Seller metrics must be aggregated through seller-order grain.
- Date keys must have valid relationships with the date dimension.
- Missing source relationships must be reported and must not be silently removed.
- Metric calculations must follow the definitions in the Metric Dictionary.