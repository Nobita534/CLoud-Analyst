# Olist Ecommerce Data Pipeline & Star Schema Modeling

Dự án này mô phỏng một luồng dữ liệu end-to-end cho bài toán thương mại điện tử Olist (Brazil): lấy dữ liệu thô, làm sạch và chuẩn hóa, sau đó mô hình hóa thành kho dữ liệu kiểu **Star Schema** để phục vụ phân tích trên Power BI.

Mục tiêu của dự án là biến dữ liệu rời rạc thành một cấu trúc dễ hiểu, dễ mở rộng, và dễ báo cáo cho các câu hỏi như:

- Tệp khách hàng đang được chia thành những phân khúc nào theo RFM?
- Phân khúc nào chiếm tỷ trọng lớn nhất trong tập khách hàng?
- Voucher đang tác động mạnh nhất lên phân khúc nào?
- Voucher có đang được dùng hiệu quả để kéo nhóm khách hàng tiềm năng quay lại không?

## 1. Bức tranh tổng quan

Luồng xử lý của dự án đi theo 3 lớp chính:

1. **Bronze / Raw**: lưu dữ liệu gốc từ bộ Olist.
2. **Silver**: làm sạch, chuẩn hóa kiểu dữ liệu, tạo các trường trung gian cần thiết.
3. **Gold**: thiết kế mô hình phân tích gồm fact và dimension để dùng cho BI / dashboard.

Nói ngắn gọn: dữ liệu đi từ “thô” đến “sẵn sàng phân tích”.

## 2. Công nghệ sử dụng

- **Azure Data Factory**: ingest và điều phối luồng dữ liệu.
- **Azure Databricks / PySpark**: xử lý dữ liệu ở Silver và Gold.
- **ADLS Gen2 + Unity Catalog**: lưu trữ và quản trị dữ liệu.
- **Delta Lake**: định dạng lưu trữ tối ưu cho phân tích.
- **Power BI**: trực quan hóa và khai thác dữ liệu ở tầng cuối.

## 3. Kiến trúc dữ liệu

Dự án áp dụng tư duy **Medallion Architecture** để tách rõ vai trò của từng tầng.

### Bronze / Raw

Đây là dữ liệu đầu vào chưa xử lý, giữ gần với nguồn gốc nhất có thể. Tầng này hữu ích cho việc truy vết và tái xử lý khi cần.

### Silver

Tầng Silver tập trung vào chất lượng dữ liệu:

- loại bỏ trùng lặp;
- chuẩn hóa chuỗi;
- ép kiểu dữ liệu;
- tạo các cột dẫn xuất như thời gian giao hàng;
- chuẩn bị dữ liệu cho mô hình hóa ở Gold.

### Gold

Tầng Gold là tầng phục vụ phân tích. Dữ liệu được thiết kế lại theo **Star Schema** để tối ưu truy vấn và dễ dùng trong dashboard.

Các bảng chính ở Gold gồm:

- **Fact Orders**: thông tin giao dịch chính và các chỉ số tổng hợp;
- **Fact Order Items**: chi tiết từng dòng hàng;
- **Fact Order Payments**: chi tiết thanh toán;
- **Fact RFM**: bộ chỉ số khách hàng theo mô hình RFM;
- **Dim Customers**: thông tin khách hàng;
- **Dim Sellers**: thông tin người bán;
- **Dim Products**: thông tin sản phẩm;
- **Dim Date**: bảng thời gian chuẩn để phân tích theo ngày, tháng, quý, năm.

## 4. Business question

Trọng tâm của dự án không chỉ là “xử lý dữ liệu”, mà là trả lời các câu hỏi kinh doanh xoay quanh **CRM insights**, **RFM segmentation** và **voucher optimization**.

Các nhóm câu hỏi chính gồm:

- phân khúc khách hàng nào đang đóng góp nhiều nhất vào tập khách hàng;
- khách hàng mới, khách hàng trung thành và nhóm có nguy cơ rời bỏ đang phân bố ra sao;
- voucher đang tạo ảnh hưởng mạnh ở phân khúc nào;
- tỷ lệ sử dụng voucher hiện tại có đủ tốt để hỗ trợ chiến lược giữ chân khách hàng hay không;
- phân tích RFM để hiểu hành vi mua lặp lại và mức độ giá trị của từng nhóm khách hàng.

File mô tả bài toán nghiệp vụ nằm ở [documents/business/Business_question.md](documents/business/Business_question.md).

## 5. Mô hình dữ liệu

Star Schema của dự án được mô tả trong:

- [documents/modeling/star_schema.dbml](documents/modeling/star_schema.dbml)
- [documents/modeling/star_schema.png](documents/modeling/star_schema.png)

Mục đích của mô hình này là:

- giảm độ phức tạp khi truy vấn;
- gom dữ liệu đo lường vào fact;
- giữ ngữ cảnh phân tích trong dimension;
- giúp Power BI đọc dữ liệu rõ ràng và ổn định hơn.

## 6. Cấu trúc thư mục

```text
Cloud-Analyst/
    README.md

    Data/
        olist_*.csv

    Notebook/
        silver/
            Silver_Notebook.ipynb
        gold/
            Gold Notebook.ipynb

    pipelines/
        adf_pipelines/
            dataset/
            factory/
            linkedService/
            pipeline/
            publish_config.json

    analytics/
        powerbi/
            Dashboard CRM.pbip
            Dashboard CRM.Report/
            Dashboard CRM.SemanticModel/

    documents/
        business/
            Business_question.md
        modeling/
            star_schema.dbml
            star_schema.png

```

### Ý nghĩa từng nhóm

- **Data**: dữ liệu đầu vào gốc.
- **Notebook**: mã PySpark xử lý Silver và Gold.
- **pipelines**: cấu hình Azure Data Factory.
- **analytics**: báo cáo và semantic model Power BI.
- **documents**: tài liệu nghiệp vụ và mô hình hóa dữ liệu.

## 7. Những điểm nổi bật trong code

- **Unity Catalog Integration**: quản trị dữ liệu tập trung.
- **Delta optimization**: bật `optimizeWrite` và `autoCompact` để giảm small files.
- **Star Schema design**: chuẩn hóa theo mô hình phân tích.
- **RFM metrics**: thêm lớp phân tích khách hàng để phục vụ segmentation.
- **Date dimension**: tạo bảng lịch chuẩn với `date_key` dạng `yyyyMMdd`.

## 8. Cách đọc project theo đúng thứ tự

Nếu bạn mới mở repo này, nên đọc theo thứ tự sau:

1. Đọc [README.md](README.md) để hiểu bức tranh tổng quan.
2. Đọc [documents/business/Business_question.md](documents/business/Business_question.md) để hiểu bài toán.
3. Xem [documents/modeling/star_schema.dbml](documents/modeling/star_schema.dbml) để nắm mô hình dữ liệu.
4. Mở [Notebook/silver/Silver_Notebook.ipynb](Notebook/silver/Silver_Notebook.ipynb) để xem tầng làm sạch.
5. Mở [Notebook/gold/Gold Notebook.ipynb](Notebook/gold/Gold%20Notebook.ipynb) để xem tầng mô hình hóa.
6. Cuối cùng xem [analytics/powerbi](analytics/powerbi) để hiểu đầu ra báo cáo.

## 9. Cách chạy lại dự án

Phần này mang tính định hướng, vì môi trường Azure/Databricks của mỗi người có thể khác nhau.

### Bước 1: Chuẩn bị dữ liệu nguồn

- kiểm tra các file CSV trong [Data](Data);
- đảm bảo storage / access key / catalog đã được cấu hình đúng.

### Bước 2: Chạy ingestion bằng ADF

- mở cấu hình trong [pipelines/adf_pipelines](pipelines/adf_pipelines);
- kiểm tra linked service, dataset, pipeline;
- chạy pipeline ingest dữ liệu vào vùng đích.

### Bước 3: Chạy notebook Silver

- đọc dữ liệu từ tầng Silver / raw theo cấu hình hiện tại;
- làm sạch và chuẩn hóa dữ liệu.

### Bước 4: Chạy notebook Gold

- tạo dimension tables;
- tạo fact tables;
- tạo bảng RFM;
- ghi toàn bộ kết quả vào Unity Catalog.

### Bước 5: Mở Power BI

- kiểm tra semantic model;
- refresh report;
- xác nhận dashboard hiển thị đúng dữ liệu.
