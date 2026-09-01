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

Cloud Analyst uses a hybrid **ETL + ELT** architecture.

Azure Data Factory is responsible for cloud data ingestion and pipeline orchestration, while PostgreSQL and dbt Core provide the analytical transformation and data modeling layer.

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

### ETL Workflow

**Source → Azure Data Factory → ADLS Gen2 / PostgreSQL Landing**

Azure Data Factory is used to simulate a cloud-based ingestion and orchestration workflow.

ADF is responsible for:

* source connections;
* dataset configuration;
* pipeline orchestration;
* schema handling;
* column mapping;
* data loading;
* scheduled execution.

The cloud ETL layer is intended to demonstrate how ingestion can be separated from downstream analytical transformation.

See [`pipelines/README.md`](pipelines/README.md) for pipeline documentation.

### ELT Workflow

**PostgreSQL Landing → dbt Core → Analytics Data Warehouse → Power BI**

Once data is available in PostgreSQL, dbt Core handles analytical transformation and business modeling.

The dbt project separates transformations into structured layers:

* **Staging** — source-level standardization and preparation.
* **Intermediate** — reusable transformations and business logic.
* **Marts** — analytics-ready models designed around business requirements.

The dbt project is located at [`dbt/cloud_analyst`](dbt/cloud_analyst/).

---

## 3. Technology Stack

| Layer                 | Technology                         | Purpose                                                               |
| --------------------- | ---------------------------------- | --------------------------------------------------------------------- |
| Data Source           | Olist Brazilian E-commerce Dataset | Raw transactional data                                                |
| Cloud ETL             | Azure Data Factory                 | Data ingestion, orchestration, and scheduling                         |
| Cloud Storage         | Azure Data Lake Storage Gen2       | Raw / landing data storage                                            |
| Data Warehouse        | PostgreSQL                         | Landing and analytical data storage                                   |
| Analytics Engineering | dbt Core                           | Data transformation, business logic, testing, and analytical modeling |
| BI                    | Power BI                           | Semantic modeling, metrics, analysis, and visualization               |
| Modeling              | Snowflake Schema                   | Analytical data model                                                 |

---

## 4. Business Understanding

The project starts from business requirements rather than directly from the dataset.

The business documentation is organized into:

* [Business Problem](documents/business-understanding/Business_problem.md)
* [Business Questions](documents/business-understanding/Business_question.md)
* [Business Requirements](documents/business-understanding/Business_requirement.md)
* [Data Requirements](documents/business-understanding/Data_requirement.md)
* [Metric Dictionary](documents/business-understanding/Metric_dictionary.md)
* [Metric Mapping to Business Questions](documents/business-understanding/Metric_mapping_Business_Question.md)

This documentation defines the analytical scope before data modeling and dashboard development.

---

## 5. Data Modeling

The analytical warehouse follows a **Snowflake Schema** designed around the project's business requirements.

The model covers transactional facts and supporting dimensions for:

* orders;
* order items;
* payments;
* customers;
* sellers;
* products;
* dates;
* RFM analysis.

Model documentation:

* [`Snowflake Schema – E-commerce Data Warehouse.dbml`](documents/modeling/Snowflake%20Schema%20%E2%80%93%20E-commerce%20Data%20Warehouse.dbml)
* [`Snowflake Schema – E-commerce Data Warehouse.png`](documents/modeling/Snowflake%20Schema%20%E2%80%93%20E-commerce%20Data%20Warehouse.png)

The model supports:

* sales analysis;
* customer analysis;
* product and seller analysis;
* time-based analysis;
* geographic analysis;
* RFM segmentation;
* Power BI reporting.

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

### Staging Layer

The staging layer prepares source data for downstream transformations.

Typical responsibilities include:

* column renaming;
* data type standardization;
* source-level cleaning;
* basic data validation.

### Intermediate Layer

The intermediate layer contains reusable transformation logic that combines or enriches staging models before analytical datasets are created.

### Marts Layer

The marts layer contains analytics-ready models designed to support business questions, metrics, and downstream Power BI reporting.

The dbt layer is intended to make business transformations:

* modular;
* reusable;
* testable;
* maintainable;
* traceable;
* easier to connect to downstream analytics.

---

## 7. Data Profiling & Exploratory Analysis

Before analytical modeling, the source data is examined through data profiling and exploratory data analysis.

The repository contains:

### Data Profiling

[`Data_Profiling.ipynb`](Notebook/analysis/Data_Profiling.ipynb)

Used to assess:

* dataset structure;
* data types;
* missing values;
* duplicate records;
* key relationships;
* basic data quality issues.

### Exploratory Data Analysis

[`EDA.ipynb`](Notebook/analysis/EDA.ipynb)

Used to explore:

* customer behavior;
* sales patterns;
* product performance;
* geographic distributions;
* payment behavior;
* relationships relevant to the project's business questions.

These notebooks support understanding the source data before implementing analytical transformations in dbt.

---

## 8. Power BI Analytics

The Power BI project is stored in [`analytics/powerbi`](analytics/powerbi/).

It contains:

* Power BI report definition;
* semantic model;
* `.pbip` project file.

The Power BI layer consumes analytics-ready data from the data warehouse rather than directly transforming the raw source dataset.

The dashboard is organized around the project's business questions and metrics, with emphasis on:

* Executive KPIs;
* Sales Analytics;
* Customer Analytics;
* Customer Segmentation;
* RFM Analysis.

This separation allows transformation logic to remain primarily in the analytical data layer while Power BI focuses on semantic modeling, metrics, visualization, and business analysis.

---

## 9. Repository Structure

```text
Cloud-Analyst/
│
├── Data/                         # Source datasets
│
├── Notebook/
│   └── analysis/                 # Data profiling and exploratory analysis
│
├── pipelines/
│   ├── adf_pipelines/            # Azure Data Factory configuration
│   └── README.md                 # ETL pipeline documentation
│
├── dbt/
│   └── cloud_analyst/            # Analytics Engineering project
│       ├── models/
│       │   ├── staging/
│       │   ├── intermediate/
│       │   └── marts/
│       ├── analyses/
│       ├── macros/
│       └── tests/
│
├── analytics/
│   └── powerbi/                  # Power BI report and semantic model
│
├── documents/
│   ├── business-understanding/   # Business and metric documentation
│   ├── modeling/                 # Data model documentation
│   └── release.md                # Version 2.0 release documentation
│
└── README.md
```

---

## 10. Project Workflow

The recommended way to understand the project is to follow the dependency between business, data, and analytics layers:

1. **Understand the business problem**
   Start with [`Business_problem.md`](documents/business-understanding/Business_problem.md).

2. **Review business questions and requirements**
   Understand what analytical decisions the platform is expected to support.

3. **Review metrics**
   Examine definitions and calculation logic in the [Metric Dictionary](documents/business-understanding/Metric_dictionary.md).

4. **Profile and explore the source data**
   Review the data profiling and EDA notebooks under [`Notebook/analysis`](Notebook/analysis/).

5. **Review the data model**
   Open the [Snowflake Schema](documents/modeling/Snowflake%20Schema%20%E2%80%93%20E-commerce%20Data%20Warehouse.dbml).

6. **Review cloud ingestion and orchestration**
   Inspect [`pipelines/adf_pipelines`](pipelines/adf_pipelines).

7. **Review analytical transformation**
   Inspect [`dbt/cloud_analyst/models`](dbt/cloud_analyst/models).

8. **Review the BI layer**
   Open [`analytics/powerbi`](analytics/powerbi/).

This workflow makes it easier to understand not only *how* data is processed, but also *why* each data model, transformation, metric, and dashboard component exists.

---

## 11. Running the Project

The repository contains cloud-specific configuration, so complete reproduction requires access to the corresponding Azure, PostgreSQL, and Power BI environments.

At a high level:

### Step 1 — Prepare the Source Data

Place or access the Olist source dataset according to the project's configured data locations.

### Step 2 — Run the ETL Pipeline

Use the Azure Data Factory configuration under [`pipelines/adf_pipelines`](pipelines/adf_pipelines) to ingest source data into ADLS Gen2 and/or the PostgreSQL landing layer.

The ETL pipeline handles source ingestion and orchestration before analytical transformation begins.

### Step 3 — Configure PostgreSQL

Prepare the PostgreSQL environment used for landing and analytical storage.

Environment-specific credentials and connection information should be configured locally and are not committed to the repository.

### Step 4 — Run dbt Transformations

From [`dbt/cloud_analyst`](dbt/cloud_analyst/), configure the target profile and execute the dbt project.

Typical commands are:

```bash
dbt deps
dbt build
```

`dbt build` executes the project's analytical models and associated data tests.

### Step 5 — Refresh Power BI

Open the Power BI project under [`analytics/powerbi`](analytics/powerbi/), verify the semantic model connection, and refresh the report.

> **Note:** Environment-specific credentials, connection strings, and cloud resources are intentionally not included in the repository.

---

## 12. Version 2.0

Version 2.0 evolves the project from a cloud ETL exercise into a broader **business-driven analytics platform** combining:

* Business Understanding;
* Cloud ETL;
* Analytics Engineering;
* Data Warehouse Modeling;
* Business Intelligence.

The architecture was simplified to keep each technology focused on a clear responsibility:

```text
Azure Data Factory
        ↓
Ingestion & Orchestration

PostgreSQL
        ↓
Data Storage

dbt Core
        ↓
Analytical Transformation

Power BI
        ↓
Business Analytics
```

Key improvements include:

* standardized business documentation;
* Azure Data Factory ingestion and orchestration;
* PostgreSQL landing and analytical storage;
* modular dbt staging, intermediate, and mart layers;
* centralized analytical transformation logic;
* business-oriented metrics and analytical models;
* refactored Power BI dashboard;
* simplified data architecture;
* portfolio-oriented project documentation.

See [`documents/release.md`](documents/release.md) for the complete Version 2.0 release note.

---

## 13. Project Outcome

Cloud Analyst demonstrates an end-to-end workflow in which **business requirements drive data ingestion, data modeling, transformation, analytical metrics, and dashboard design**.

The project demonstrates practical understanding of:

* **Data Analytics** — business questions, metrics, data profiling, EDA, and customer analysis;
* **Data Engineering** — cloud ingestion, pipeline orchestration, scheduling, and data storage;
* **Analytics Engineering** — modular dbt transformations, testing, and analytical marts;
* **Business Intelligence** — semantic modeling, KPI design, Power BI reporting, and business analysis.

The project intentionally separates the responsibilities of each layer:

```text
ADF           → Ingestion & Orchestration
PostgreSQL    → Data Storage
dbt           → Transformation & Analytical Modeling
Power BI      → Analytics & Visualization
```

The dataset itself does not require large-scale distributed processing. Instead, the cloud ingestion layer is used to demonstrate how a scheduled and orchestrated ETL workflow can be designed separately from the analytical transformation layer.

The main lesson from the project is that a useful analytics platform is not defined by the number of technologies it uses. Each technology should have a clear responsibility, while the business definition, data model, transformation logic, metrics, and analytical output remain connected throughout the workflow.
