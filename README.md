# Cloud Analyst — Olist E-commerce Analytics Platform

> An end-to-end data platform project that combines **Business Analytics, Cloud ETL, Analytics Engineering, and Business Intelligence** using the Olist Brazilian e-commerce dataset.

## 1. Project Overview

**Cloud Analyst** transforms raw Olist e-commerce data into an analytics-ready data warehouse and Power BI dashboard.

The project is designed around a business-first workflow:

**Business Problem → Business Questions → Business Requirements → Data Requirements → Metrics → Data Platform → Analytics → Dashboard**

The main analytical focus is **sales performance, customer behavior, customer segmentation, RFM analysis, and voucher usage**.

### Business Questions

The project is designed to answer the following business questions:

1. **BQ1 — Customer Segmentation**  
   Which customer segments should be prioritized for marketing and customer engagement based on purchasing behavior and business value?

2. **BQ2 — Customer Value by Geography**  
   Which customer segments generate the highest business value across different geographic areas?

3. **BQ3 — Product Performance by Geography**  
   Which product categories and products contribute the most to sales performance across different geographic areas?

4. **BQ4 — Seller Performance**  
   Which sellers have the greatest impact on sales performance and customer satisfaction, and which sellers require performance improvement?

5. **BQ5 — Sales Performance Over Time**  
   How does sales performance change across different time periods, and which periods contribute most to business revenue?

6. **BQ6 — Payment Behavior**  
   Which payment methods are most commonly used by customers, and how do payment behaviors vary across different customer segments?

7. **BQ7 — Geographic Performance**  
   Which geographic areas have the highest sales activity and customer concentration?

8. **BQ8 — Customer Satisfaction**  
   How does customer satisfaction vary across product categories and sellers?

Detailed business documentation is available in [`documents/business-understanding`](documents/business-understanding/).

---

## 2. Architecture

Cloud Analyst uses a hybrid **ETL + ELT** architecture. Technical ingestion is handled by Azure Data Factory, while downstream business transformation is organized with dbt.

```text
Business Problem → Questions → Requirements → Metrics
                              │
                              ▼
Source Dataset → Azure Data Factory → ADLS Gen2 / PostgreSQL Landing
                                             │
                                             ▼
                                          dbt Core
                                             │
                              ┌──────────────┼──────────────┐
                              ▼              ▼              ▼
                           Staging      Intermediate      Marts
                              │              │              │
                              └──────────────┴──────────────┘
                                             │
                                             ▼
                                   Analytics Data Warehouse
                                             │
                                             ▼
                                   Power BI Semantic Model
                                             │
                                             ▼
                                   Dashboard & Analysis
```

### ETL workflow

**Source → Azure Data Factory → ADLS Gen2 / PostgreSQL Landing**

ADF is responsible for data ingestion and pipeline orchestration, including source connections, datasets, schema handling, column mapping, and loading.

See [`pipelines/README.md`](pipelines/README.md) for pipeline documentation.

### ELT workflow

**PostgreSQL Landing → dbt Core → Analytics Data Warehouse → Power BI**

dbt separates analytical transformations into structured layers:

- **Staging** — source-level standardization and preparation.
- **Intermediate** — reusable business transformations.
- **Marts** — analytics-ready models designed around business requirements.

The dbt project is located at [`dbt/cloud_analyst`](dbt/cloud_analyst/).

---

## 3. Technology Stack

| Layer | Technology | Purpose |
|---|---|---|
| Data Source | Olist Brazilian E-commerce Dataset | Raw transactional data |
| Cloud ETL | Azure Data Factory | Ingestion and orchestration |
| Cloud Storage | Azure Data Lake Storage Gen2 | Data lake / landing storage |
| Data Transformation | PySpark / Databricks | Technical data processing |
| Analytics Engineering | dbt Core | Business transformation and analytical modeling |
| Data Warehouse | PostgreSQL | Landing and analytical storage |
| BI | Power BI | Semantic modeling, metrics, and visualization |
| Modeling | Snowflake Schema | Analytical data model |

---

## 4. Business Understanding

The project starts from business requirements rather than directly from the dataset.

The business documentation is organized into:

- [Business Problem](documents/business-understanding/Business_problem.md)
- [Business Questions](documents/business-understanding/Business_question.md)
- [Business Requirements](documents/business-understanding/Business_requirement.md)
- [Data Requirements](documents/business-understanding/Data_requirement.md)
- [Metric Dictionary](documents/business-understanding/Metric_dictionary.md)
- [Metric Mapping to Business Questions](documents/business-understanding/Metric_mapping_Business_Question.md)

This documentation defines the analytical scope before data modeling and dashboard development.

---

## 5. Data Modeling

The analytical warehouse follows a **Snowflake Schema** designed around the project's business requirements.

The model covers transactional facts and supporting dimensions for orders, order items, payments, customers, sellers, products, dates, and RFM analysis.

Model documentation:

- [`Snowflake Schema – E-commerce Data Warehouse.dbml`](documents/modeling/Snowflake%20Schema%20%E2%80%93%20E-commerce%20Data%20Warehouse.dbml)
- [`Snowflake Schema – E-commerce Data Warehouse.png`](documents/modeling/Snowflake%20Schema%20%E2%80%93%20E-commerce%20Data%20Warehouse.png)

The model supports:

- sales analysis;
- customer analysis;
- product and seller analysis;
- time-based analysis;
- RFM segmentation;
- Power BI reporting.

---

## 6. Analytics Engineering with dbt

The dbt project follows a modular transformation structure:

```text
dbt/cloud_analyst/
├── models/
│   ├── staging/
│   ├── intermediate/
│   └── marts/
├── analyses/
├── macros/
├── seeds/
├── snapshots/
├── tests/
├── dbt_project.yml
└── packages.yml
```

This structure separates source preparation from reusable business logic and final analytical models.

The dbt layer is intended to make business transformations:

- modular;
- reusable;
- testable;
- easier to maintain;
- easier to connect to downstream BI.

---

## 7. Data Processing & Analysis

The repository also contains PySpark notebooks for technical transformation and exploratory analysis.

### Analysis

- [`Data_Profiling.ipynb`](Notebook/analysis/Data_Profiling.ipynb) — data quality and structure assessment.
- [`EDA.ipynb`](Notebook/analysis/EDA.ipynb) — exploratory data analysis.

### Silver

- [`Silver_Notebook.ipynb`](Notebook/silver/Silver_Notebook.ipynb) — cleaning, standardization, and preparation of data for analytical modeling.

### Gold

- [`Gold Notebook.ipynb`](Notebook/gold/Gold%20Notebook.ipynb) — creation of analytical fact and dimension datasets.

---

## 8. Power BI Analytics

The Power BI project is stored in [`analytics/powerbi`](analytics/powerbi/).

It contains:

- Power BI report definition;
- semantic model;
- `.pbip` project file.

The dashboard is organized around the project's business questions and metrics, with emphasis on:

- Executive KPIs;
- Sales Analytics;
- Customer Analytics;
- Customer Segmentation;
- RFM Analysis.

---

## 9. Repository Structure

```text
Cloud-Analyst/
│
├── Data/                         # Source and processed datasets
├── Notebook/
│   ├── analysis/                 # Profiling and EDA
│   ├── silver/                   # Technical transformation
│   └── gold/                     # Analytical dataset generation
├── pipelines/
│   ├── adf_pipelines/            # Azure Data Factory configuration
│   └── README.md
├── dbt/
│   └── cloud_analyst/            # Analytics Engineering project
│       ├── models/
│       ├── analyses/
│       ├── macros/
│       └── tests/
├── analytics/
│   └── powerbi/                  # Power BI report and semantic model
├── documents/
│   ├── business-understanding/   # Business and metric documentation
│   ├── modeling/                 # Data model documentation
│   └── release.md                # Version 2.0 release documentation
└── README.md
```

---

## 10. Project Workflow

The recommended way to understand the project is to follow the dependency between business, data, and analytics layers:

1. **Understand the business problem** — start with [`Business_problem.md`](documents/business-understanding/Business_problem.md).
2. **Review business questions and requirements** — read the business question and requirement documents.
3. **Review metrics** — understand definitions and calculation logic in the [Metric Dictionary](documents/business-understanding/Metric_dictionary.md).
4. **Review the data model** — open the [Snowflake Schema](documents/modeling/Snowflake%20Schema%20%E2%80%93%20E-commerce%20Data%20Warehouse.dbml).
5. **Review ingestion** — inspect [`pipelines/adf_pipelines`](pipelines/adf_pipelines).
6. **Review technical transformation** — inspect the Silver and Gold notebooks.
7. **Review analytical transformation** — inspect [`dbt/cloud_analyst/models`](dbt/cloud_analyst/models).
8. **Review the BI layer** — open [`analytics/powerbi`](analytics/powerbi).

This order makes it easier to understand not only *how* the data is processed, but also *why* each transformation exists.

---

## 11. Running the Project

The repository contains cloud-specific configuration, so a complete reproduction requires access to the corresponding Azure, PostgreSQL, and Power BI environments.

At a high level:

### Step 1 — Prepare the source data

Place or access the Olist source dataset according to the project's configured data locations.

### Step 2 — Run the ETL pipeline

Use the Azure Data Factory configuration under [`pipelines/adf_pipelines`](pipelines/adf_pipelines) to ingest data into the landing layer.

### Step 3 — Run technical transformations

Execute the required PySpark notebooks in the appropriate Databricks environment.

### Step 4 — Run dbt transformations

From [`dbt/cloud_analyst`](dbt/cloud_analyst/), configure the target profile and run the required dbt models and tests.

Typical commands are:

```bash
dbt deps
dbt build
```

### Step 5 — Refresh Power BI

Open the Power BI project under [`analytics/powerbi`](analytics/powerbi/), verify the semantic model, and refresh the report.

> **Note:** Environment-specific credentials, connection strings, and cloud resources are intentionally not included in the repository.

---

## 12. Version 2.0

Version 2.0 evolves the project from a cloud data pipeline into a broader **Modern Data Platform** combining:

- Business Understanding;
- Cloud ETL;
- Analytics Engineering;
- Data Warehouse Modeling;
- Business Intelligence.

Key improvements include:

- standardized business documentation;
- Azure Data Factory ETL platform;
- PostgreSQL landing and analytical storage;
- dbt staging, intermediate, and mart layers;
- business-oriented metrics and analytical models;
- refactored Power BI dashboard;
- portfolio-oriented project documentation.

See [`documents/release.md`](documents/release.md) for the complete Version 2.0 release note.

---

## 13. Project Outcome

Cloud Analyst demonstrates an end-to-end workflow in which **business requirements drive data modeling, data transformation, analytical metrics, and dashboard design**.

The project demonstrates practical understanding of:

- **Data Analytics** — business questions, metrics, EDA, and customer analysis;
- **Data Engineering** — cloud ingestion, orchestration, storage, and transformation;
- **Analytics Engineering** — modular dbt transformations and analytical marts;
- **Business Intelligence** — semantic modeling, KPI design, and Power BI reporting.

The main lesson from the project is that a useful analytics platform is not only a collection of pipelines and dashboards: the business definition, data model, transformation logic, and analytical output must remain connected throughout the workflow.
