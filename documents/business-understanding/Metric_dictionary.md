# Metric Dictionary

## 1. Overview

### 1.1. Purpose

This document defines the business metrics and Key Performance Indicators (KPIs) used throughout the analytics platform.

It provides standardized metric definitions, calculation logic, required fields, and ownership to ensure consistency across Analytics Engineering, Business Intelligence dashboards, and business reports.

---

## 2. Metric Dictionary

| Metric ID | Metric Name | Metric Type | Business Requirement | Definition | Formula | Required Fields | Owner |
|-----------|-------------|-------------|----------------------|------------|---------|-----------------|-------|
| **KPI-01** | Total Revenue | KPI | BR3, BR4, BR5, BR6, BR7, BR8 | Total payment value received from successfully completed orders. | `SUM(payment_value)` | payment_value | Sales Team |
| **KPI-02** | Purchase Frequency | KPI | BR1, BR4 | Number of orders placed by a customer within a specific time period. | `COUNT(DISTINCT order_id)` grouped by `customer_unique_id`, Year, Month | customer_unique_id, order_id, order_purchase_timestamp | Marketing Team |
| **KPI-03** | Recency | KPI | BR1 | Number of days since the customer's most recent purchase until the analysis date. | `Analysis Date - MAX(order_purchase_timestamp)` | analysis_date, order_purchase_timestamp | Marketing Team |
| **KPI-04** | Customer Count | Basic Metric | BR2 | Total number of unique customers. | `COUNT(customer_unique_id)` | customer_unique_id | Marketing Team |
| **KPI-05** | Voucher Usage Rate | Ratio | BR2 | Percentage of orders paid using vouchers. | `COUNT(payment_type = 'voucher') / COUNT(payment_type) × 100` | payment_type | Marketing Team |
| **KPI-06** | Repeat Purchase Rate | KPI | BR4 | Percentage of customers who make two or more purchases during the analysis period. | `COUNT(Customer with ≥ 2 Orders) / COUNT(customer_unique_id) × 100` | customer_unique_id, order_id, order_purchase_timestamp | Marketing Team |
| **KPI-07** | Total Orders | Basic Metric | BR5, BR6, BR7, BR8 | Total number of completed orders. | `COUNT(DISTINCT order_id)` | order_id | Sales Team |
| **KPI-08** | Average Review Score | KPI | BR7, BR8 | Average customer review score given to completed orders. | `AVG(review_score)` | review_score | Sales Team |