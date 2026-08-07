# Azure Data Factory Pipelines

## Overview

This directory contains the Azure Data Factory (ADF) pipelines used in the Cloud ETL Platform.

The pipelines are responsible for orchestrating the technical ETL process, including data ingestion, technical transformation, and loading data into the cloud storage and landing database.

---

## Pipeline Workflow

The ETL workflow follows the architecture below:

```text
Kaggle (Official Olist Dataset)
            │
    Kaggle API (One-time)
            │
            ▼
   Download Dataset (.zip)
            │
            ▼
     Extract CSV Files
            │
            ▼
       Data/raw (CSV)
            │
            ▼
Azure Data Factory
            │
     Get Metadata
            │
            ▼
       ForEach File
            │
            ▼
     Copy Activity
            │
            ▼
 Mapping Data Flow
    ├── Schema Validation
    ├── Data Type Standardization
    ├── Column Mapping
    ├── Basic Data Cleaning
    ├── Null Handling
    └── Data Validation
            │
            ▼
Azure Data Lake Storage Gen2 (Bronze)
            │
            ▼
      Copy Activity
            │
            ▼
PostgreSQL Landing Database
```

---

## Technical Responsibilities

The Azure Data Factory pipelines perform the following tasks:

- Read raw CSV files from the project data source.
- Validate the input schema.
- Standardize data types.
- Map source columns to the standardized schema.
- Perform basic data cleaning.
- Handle missing values.
- Validate transformed data.
- Load validated data into Azure Data Lake Storage Gen2 (Bronze Layer).
- Load the technical dataset into the PostgreSQL Landing Database.

---

## Directory Structure

```text
pipelines/
│
├── README.md
│
└── adf_pipelines/
    ├── factory/
    ├── linkedService/
    ├── dataset/
    ├── pipeline/
    └── publish_config.json
```

---

## Notes

- This directory contains only the Azure Data Factory orchestration layer.
- Business transformations (Star Schema, Data Mart, Business Metrics) are implemented separately using **dbt Core**.
- The Kaggle dataset download is performed only once during project initialization and is not part of the recurring ETL pipeline.