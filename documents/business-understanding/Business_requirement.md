# Business Requirements

## 1. Overview

This document defines the business requirements of the project based on the identified Business Questions.

The Business Requirements describe the analytical capabilities that the platform must provide to support business analysis and decision-making. They serve as the foundation for defining Data Requirements, designing the Data Warehouse, developing the Analytics Platform, standardizing Business Metrics, and building Executive Dashboards in subsequent phases.

---

## 2. Project Scope

### 2.1. In Scope

This project focuses on building a data analytics platform to support Olist's business analysis, including:

- Customer segmentation based on purchasing behavior and business value.
- Customer value and retention analysis across geographic areas.
- Sales performance analysis by product, product category, geography, and time period.
- Seller performance and customer satisfaction analysis.
- Customer satisfaction analysis based on customer reviews.
- Standardization of Business Metrics for data analysis and visualization.
- Development of analytical datasets and dashboards to support business decision-making.

### 2.2. Out of Scope

The project does not cover the following:

- Development of an e-commerce transaction system.
- Real-time data analytics.
- Product recommendation systems or personalized customer experiences.
- Predictive customer churn modeling.
- Automated marketing campaign execution.
- Profit analysis, as the dataset does not provide sufficient operational cost information.

---

## 3. Business Requirements

| ID | Business Question | Business Requirement | Expected Business Outcome |
|---|---|---|---|
| **BR1** | BQ1 | The platform shall classify customers into meaningful customer segments based on Recency, Frequency, and Monetary (RFM) metrics. | Support targeted marketing and customer engagement strategies. |
| **BR2** | BQ1 | The platform shall provide the characteristics and distribution of each customer segment based on customer purchasing behavior and business value. | Help stakeholders understand customer profiles and segment distribution. |
| **BR3** | BQ2 | The platform shall identify high-value customer segments across different geographic areas. | Support geographic customer retention and localized marketing strategies. |
| **BR4** | BQ2 | The platform shall measure customer value and purchasing behavior across states and cities. | Enable stakeholders to prioritize geographic areas with high-value customers. |
| **BR5** | BQ3 | The platform shall identify high-performing products and product categories based on sales performance. | Support product portfolio and sales optimization decisions. |
| **BR6** | BQ3 | The platform shall compare product and category sales performance across different geographic areas. | Support localized product promotion and investment decisions. |
| **BR7** | BQ4 | The platform shall evaluate seller performance using standardized sales, order, and customer satisfaction metrics. | Support identification of sellers requiring performance improvement. |
| **BR8** | BQ4 | The platform shall identify sellers with significant business contribution and comparatively low customer satisfaction. | Support prioritization of seller performance improvement programs. |
| **BR9** | BQ5 | The platform shall provide sales performance metrics across different time periods. | Support sales planning, performance monitoring, and resource allocation. |
| **BR10** | BQ5 | The platform shall identify high- and low-performing periods based on revenue, order activity, and customer purchasing behavior. | Support promotional planning and identification of temporal business trends. |
| **BR13** | BQ7 | The platform shall identify geographic areas with high customer concentration, order activity, and revenue contribution. | Support localized marketing, seller development, and business expansion strategies. |
| **BR14** | BQ8 | The platform shall measure customer satisfaction across products, product categories, and sellers using customer review data. | Support identification of products and sellers associated with high or low customer satisfaction. |
| **BR15** | BQ8 | The platform shall identify areas where low customer satisfaction has a significant impact on business performance. | Support prioritization of product and seller improvement initiatives. |

---

## 4. Business Rules

The project follows the following business rules:

- Each customer is uniquely identified by **Customer Unique ID**.
- Each order is uniquely identified by **Order ID**.
- Each product is uniquely identified by **Product ID**.
- Each seller is uniquely identified by **Seller ID**.
- Revenue is calculated from payment values associated with successfully completed orders.
- Each order is counted only once in aggregated order-level business metrics.
- Customer purchasing behavior is analyzed using the **RFM model**.
- RFM metrics are calculated using a **rolling 12-month window** for each defined analysis snapshot date.
- RFM analysis follows a **one customer × one snapshot date** grain.
- Customer segmentation is based on the RFM metrics using the **Dynamic Quantiles** approach.
- Business metrics must use standardized definitions and calculation logic across the data platform.
- Sales performance must be analyzed using consistent time, product, seller, and geographic dimensions.
- Customer satisfaction is evaluated using standardized customer review metrics.
- All analytical results must be generated from standardized data stored in the Data Warehouse.
- Business metrics must be traceable to their underlying source data and transformation logic.

---

## 5. Future Enhancement

### 5.1. Business Understanding

The Business Requirements will be translated into Data Requirements to identify the necessary data entities, business attributes, relationships, metrics, and analytical dimensions required to answer each Business Question.

### 5.2. Cloud ETL Platform

The Business Requirements will guide the data ingestion, technical transformation, and loading processes implemented through Azure Data Factory to ensure that the collected data satisfies the analytical requirements.

### 5.3. Analytics Engineering

The Business Requirements will serve as the foundation for:

- Designing the multi-star Data Warehouse model.
- Building analytical dimensions and fact tables.
- Implementing the RFM analytical model.
- Standardizing Business Metrics.
- Implementing data quality tests.
- Building analytical data marts.
- Implementing ELT pipelines using dbt Core.
- Establishing data lineage and documentation.

### 5.4. Executive Dashboard

The Business Requirements will be translated into Executive Dashboards that:

- Visualize standardized Business Metrics.
- Enable analysis across relevant business dimensions.
- Identify significant Business Insights.
- Support comparison across time, geography, products, sellers, and customer segments.
- Provide actionable information for business decision-making.