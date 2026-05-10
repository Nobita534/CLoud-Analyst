# Olist Ecommerce Data Pipeline & Star Schema Modeling (Azure)

## 📌 Tổng quan dự án

Dự án này xây dựng một luồng **ETL/ELT** toàn diện để xử lý và phân tích dữ liệu thương mại điện tử từ Olist (Brazil). Mục tiêu chính là chuyển đổi dữ liệu thô từ các nguồn phân tán thành một kho dữ liệu (Data Warehouse) chuẩn hóa theo mô hình **Star Schema**, sẵn sàng cho các phân tích chuyên sâu về doanh thu và vận hành.

## 🛠 Công nghệ sử dụng

- **Data Ingestion:** Azure Data Factory (ADF).
- **Data Processing:** Azure Databricks, PySpark (Spark SQL & DataFrame API).
- **Storage & Governance:** Azure Data Lake Storage (ADLS) Gen2, Unity Catalog.
- **Data Format:** Delta Lake.
- **Modeling:** Star Schema (Fact & Dimension Tables).

## 🏗 Kiến trúc dữ liệu (Medallion Architecture)

Dự án áp dụng kiến trúc Medallion để đảm bảo chất lượng dữ liệu qua từng giai đoạn:

1.  **Bronze Layer:** Lưu trữ dữ liệu thô (Raw Data) được Ingest từ GitHub/Kaggle thông qua Azure Data Factory.
2.  **Silver Layer:**
    - Làm sạch dữ liệu: Loại bỏ trùng lặp (`dropDuplicates`), chuẩn hóa chuỗi (`lower`, `trim`).
    - Ép kiểu dữ liệu: Chuyển đổi các cột thời gian và tiền tệ về đúng định dạng `timestamp` và `double`.
    - Tính toán logic: Tính số ngày giao hàng thực tế (`delivery_days`) để phục vụ phân tích hiệu suất vận chuyển.
3.  **Gold Layer:**
    - Thiết kế mô hình đa chiều (Star Schema) tối ưu cho truy vấn.
    - Tạo bảng **Fact Sales** tập trung các chỉ số đo lường (Price, Freight, Total Amount).
    - Xây dựng 7 bảng **Dimension** (Customers, Sellers, Products, Orders, Payments, Reviews, Date) để cung cấp ngữ cảnh phân tích đa chiều.

## 📊 Mô hình dữ liệu (Data Model)

Dưới đây là cấu trúc Star Schema được thiết kế để tối ưu hóa hiệu suất báo cáo:

[Star Schema](./documents/star_schema_image.png)

### Các bảng chính:

- **Fact Sales:** Lưu trữ chi tiết từng giao dịch, bao gồm các khóa ngoại nối với các bảng Dimension và các chỉ số doanh thu.
- **Dim Date:** Bảng lịch chuẩn giúp đồng bộ hóa các phân tích theo Năm, Quý, Tháng, Thứ.
- **Dim Orders:** Quản lý trạng thái đơn hàng và các mốc thời gian quan trọng.
- **Dim Products:** Chứa thông tin danh mục và thuộc tính vật lý của sản phẩm (thể tích, trọng lượng).

## 🚀 Các tính năng nổi bật trong Code

- **Unity Catalog Integration:** Quản lý dữ liệu tập trung, đảm bảo tính bảo mật và quản trị dữ liệu.
- **Performance Optimization:** Sử dụng các tính năng của Delta Lake như `optimizeWrite` và `autoCompact` để tăng tốc độ ghi/đọc dữ liệu.
- **Analytical Ready:** Dữ liệu tại tầng Gold đã được xử lý các lỗi logic (như đơn hàng trùng, khóa ngày `order_date_key` dạng Int) để sẵn sàng sử dụng ngay.

## 📂 Cấu trúc Repository

- `/adf_pipelines`: Chứa file cấu hình JSON của các luồng Ingest dữ liệu.
- `/notebooks`: Chứa mã nguồn PySpark xử lý tầng Silver và Gold.
- `/documents`: Sơ đồ mô hình dữ liệu (ERD).
