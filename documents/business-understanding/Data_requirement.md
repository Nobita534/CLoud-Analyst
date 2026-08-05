# Data Requirement

## 1. Overview

This document defines the data requirements needed to satisfy each Business Requirement of the project. It identifies the required business metrics, dimensions, measures, business attributes, and source tables that will be used throughout the Analytics Engineering process.

The information documented in this file serves as the foundation for designing the Data Warehouse, building dbt models, defining the Business Metric Layer, and developing Business Intelligence dashboards.

---

## 2. Data Requirements

### BR1. Customer Segmentation

**Business Requirement**

> The platform shall classify customers into meaningful customer segments based on purchasing behavior.

| Category | Required Data |
|----------|---------------|
| **Business Metrics** | Purchase Frequency, Recency, Total Revenue |
| **Dimensions** | Customer, Date |
| **Measures** | Payment Value |
| **Business Attributes** | Customer ID, Customer Unique ID, Order Purchase Timestamp |
| **Source Tables** | customers, orders, order_payments |

---

### BR2. Customer Segment Characteristics

**Business Requirement**

> The platform shall provide the characteristics and distribution of each customer segment.

| Category | Required Data |
|----------|---------------|
| **Business Metrics** | Number of Customers, Voucher Usage Rate |
| **Dimensions** | Customer Segment, State |
| **Measures** | Payment Value |
| **Business Attributes** | Customer State, Payment Type |
| **Source Tables** | customers, orders, order_payments |

---

### BR3. High-value Customer Segments by State

**Business Requirement**

> The platform shall identify high-value customer segments across different states.

| Category | Required Data |
|----------|---------------|
| **Business Metrics** | Total Revenue |
| **Dimensions** | Customer Segment, State |
| **Measures** | Payment Value |
| **Business Attributes** | Customer State |
| **Source Tables** | customers, orders, order_payments |

---

### BR4. Customer Value & Repeat Purchase Performance

**Business Requirement**

> The platform shall measure customer value and repeat purchase performance for each customer segment.

| Category | Required Data |
|----------|---------------|
| **Business Metrics** | Total Revenue, Purchase Frequency, Repeat Purchase Rate |
| **Dimensions** | Customer Segment, Date |
| **Measures** | Payment Value |
| **Business Attributes** | Customer Unique ID, Order Purchase Timestamp |
| **Source Tables** | customers, orders, order_payments |

---

### BR5. Product Category Performance

**Business Requirement**

> The platform shall identify the highest-performing product categories in each state.

| Category | Required Data |
|----------|---------------|
| **Business Metrics** | Total Revenue, Total Orders |
| **Dimensions** | Product Category, State |
| **Measures** | Payment Value |
| **Business Attributes** | Product Category Name, Customer State |
| **Source Tables** | customers, orders, order_items, order_payments, products, product_translation |

---

### BR6. Product Category Comparison

**Business Requirement**

> The platform shall compare sales performance across product categories.

| Category | Required Data |
|----------|---------------|
| **Business Metrics** | Total Revenue, Total Orders |
| **Dimensions** | Product Category |
| **Measures** | Payment Value |
| **Business Attributes** | Product Category Name |
| **Source Tables** | orders, order_items, order_payments, products, product_translation |

---

### BR7. Seller Performance Evaluation

**Business Requirement**

> The platform shall evaluate seller performance using standardized business metrics.

| Category | Required Data |
|----------|---------------|
| **Business Metrics** | Total Revenue, Total Orders, Average Review Score |
| **Dimensions** | Seller, Date |
| **Measures** | Payment Value, Review Score |
| **Business Attributes** | Seller ID, Order Purchase Timestamp |
| **Source Tables** | sellers, orders, order_items, order_payments, order_reviews |

---

### BR8. Seller Performance Improvement by State

**Business Requirement**

> The platform shall identify sellers that should be prioritized for performance improvement in each state.

| Category | Required Data |
|----------|---------------|
| **Business Metrics** | Total Revenue, Total Orders, Average Review Score |
| **Dimensions** | Seller, State |
| **Measures** | Payment Value, Review Score |
| **Business Attributes** | Seller State, Customer State |
| **Source Tables** | sellers, customers, orders, order_items, order_payments, order_reviews |

---

## 3. Data Quality Considerations

The required data should satisfy the following quality requirements before being integrated into the Data Warehouse:

- Business entities should be uniquely identified using standardized primary keys.
- Relationships between tables should preserve referential integrity.
- Business metrics should be calculated using consistent business definitions.
- Missing values should be handled according to predefined business rules.
- Data types should be standardized before being loaded into the Data Warehouse.

---

