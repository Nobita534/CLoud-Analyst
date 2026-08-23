# Cloud Analyst — Version 2.0 Release

**Theme:** Modern Data Platform & Analytics Engineering Enhancement  
**Release:** Version 2.0  
**Status:** Completed

---

## 1. Release Overview

Version 2 nâng cấp Cloud Analyst từ một **Cloud Data Pipeline** thành một **Modern Data Platform** kết hợp:

- Cloud ETL
- ELT
- Analytics Engineering
- Business Intelligence

Mục tiêu của Version 2 là chuẩn hóa Business Understanding, xây dựng Cloud ETL Platform, phát triển Analytics Engineering và hoàn thiện Dashboard & Portfolio.

---

## 2. What's New

### Phase 1 — Business Understanding Refactor

Chuẩn hóa business layer trước khi xây dựng và phân tích dữ liệu:

- Business Context, Problem và Objective
- Business Questions và Business Requirements
- Data Requirements
- Metric Dictionary

Business flow được chuẩn hóa theo:

**Business Problem → Business Question → Business Requirement → Data Requirement → Metrics**

---

### Phase 2 — Cloud ETL Platform

Xây dựng Cloud ETL Platform trên Azure Data Factory.

**ETL Workflow:**

**Source → Azure Data Factory → ADLS Gen2 → PostgreSQL Landing**

Các thành phần chính:

- Source Connection & Dataset
- Data Extraction
- Schema Validation
- Data Type Standardization
- Column Mapping
- Basic Data Cleaning & Validation
- Data Loading
- Pipeline Orchestration

---

### Phase 3 — Analytics Engineering

Phát triển Analytics Engineering layer bằng dbt Core.

Các cải tiến chính:

- Refactor Star Schema
- Xác định Fact và Dimension theo Business Requirements
- Xây dựng dbt Sources
- Staging Models
- Intermediate Models
- Mart Models
- Analytics Data Mart
- Business Metrics
- dbt Tests & Documentation

**ELT Workflow:**

**PostgreSQL Landing → dbt → Analytics Data Warehouse → Dashboard**

---

### Phase 4 — Executive Dashboard

Refactor Dashboard dựa trên Business Questions và Metric Dictionary.

Dashboard tập trung vào:

- Executive KPI
- Sales Analytics
- Customer Analytics
- Customer Segmentation
- RFM Analysis

Mục tiêu là kết nối **Business Metrics → Analysis → Dashboard**.

---

### Phase 5 — Documentation & Portfolio

Hoàn thiện project theo hướng Portfolio:

- Release Note
- CHANGELOG
- README
- Project Architecture
- ETL Workflow
- ELT Workflow
- Repository Structure
- Documentation
- Lesson Learned
- Demo Guide

---

## 3. Version 2 Architecture

Version 2 hoàn thiện data flow theo mô hình:

**Source**

↓

**Azure Data Factory**

↓

**ADLS Gen2 / PostgreSQL Landing**

↓

**dbt Core**

↓

**Analytics Data Warehouse**

↓

**Power BI**

Trong đó:

- **Azure Data Factory** — ETL & Technical Transformation
- **dbt Core** — ELT & Business Transformation
- **Power BI** — Business Metrics & Visualization

---

## 4. Key Outcomes

Version 2 chuyển project từ:

**Cloud Data Pipeline**

↓

**Modern Data Platform**

với khả năng thể hiện:

- Cloud Data Engineering
- Analytics Engineering
- Business Intelligence
- Data Analytics

---

## 5. Lessons Learned

### Business

Business Questions và Metrics cần được xác định trước khi thiết kế analytical data model.

### Data Engineering

ETL pipeline cần được thiết kế dựa trên yêu cầu của downstream analytics.

### Analytics Engineering

Business transformation nên được tách khỏi technical data processing và quản lý theo một workflow có cấu trúc.

### Data Analytics

Dashboard cần được xây dựng dựa trên Business Questions và Business Metrics thay vì chỉ tập trung vào visualization.

---

