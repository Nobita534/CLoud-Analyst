# Business Requirements

## 1. Overview

This document defines the business requirements of the project based on the identified Business Questions.

The Business Requirements describe the capabilities that the platform must provide to support business analysis and decision-making. They serve as the foundation for defining Data Requirements, designing the Data Warehouse, developing the Analytics Platform, and building Executive Dashboards in the subsequent phases.

---

## 2. Project Scope

### 2.1. In Scope

This project focuses on building a data analytics platform to support Olist's business analysis, including:

- Customer segmentation based on purchasing behavior.
- Identification of high-value customer segments.
- Sales performance analysis by product category.
- Seller performance evaluation.
- Standardization of Business Metrics for data analysis and visualization.

### 2.2. Out of Scope

The project does not cover the following:

- Development of an e-commerce transaction system.
- Real-time data analytics.
- Product recommendation systems or personalized customer experiences.
- Profit analysis, as the dataset does not provide sufficient operational cost information.

---

## 3. Business Requirements

| ID | Business Question | Business Requirement | Expected Business Outcome |
|----|-------------------|----------------------|---------------------------|
| **BR1** | BQ1 | The platform shall classify customers into meaningful customer segments based on purchasing behavior. | Support targeted marketing and customer engagement strategies. |
| **BR2** | BQ1 | The platform shall provide the characteristics and distribution of each customer segment. | Help stakeholders understand customer profiles and segment distribution. |
| **BR3** | BQ2 | The platform shall identify high-value customer segments across different states. | Support customer retention strategies at the state level. |
| **BR4** | BQ2 | The platform shall measure customer value and repeat purchase performance for each customer segment. | Enable optimization of customer retention programs. |
| **BR5** | BQ3 | The platform shall identify the highest-performing product categories in each state. | Support product portfolio optimization and sales strategies. |
| **BR6** | BQ3 | The platform shall compare sales performance across product categories. | Support investment and product development decisions. |
| **BR7** | BQ4 | The platform shall evaluate seller performance using standardized business metrics. | Support the identification of sellers requiring performance improvement. |
| **BR8** | BQ4 | The platform shall identify sellers that should be prioritized for performance improvement in each state. | Support prioritization of seller performance improvement programs. |

---

## 4. Business Rules

The project follows the following business rules:

- Each customer is uniquely identified by **Customer ID**.
- Revenue is calculated only from successfully completed payments.
- Each order is counted only once in aggregated business metrics.
- Customer segmentation is based on the **RFM model** using the **Dynamic Quantiles** approach.
- All Business Metrics must be consistently defined and calculated across the data platform.
- All analytical results must be generated from standardized data stored in the Data Warehouse.

---

## 5. Future Enhancement

### 5.1. Business Understanding

The Business Requirements will be translated into Data Requirements to identify the necessary data entities, business attributes, and relationships required to answer each Business Question.

### 5.2. Cloud ETL Platform

The Business Requirements will guide the data ingestion, technical transformation, and loading processes implemented through Azure Data Factory to ensure that the collected data satisfies business analytical needs.

### 5.3. Analytics Engineering

The Business Requirements will serve as the foundation for designing the Star Schema, building Analytics Data Marts, standardizing Business Metrics, and implementing ELT pipelines using dbt Core.

### 5.4. Executive Dashboard

The Business Requirements will be translated into Executive Dashboards that visualize Business Metrics, generate Business Insights, and support data-driven decision-making.