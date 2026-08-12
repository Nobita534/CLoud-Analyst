WITH staging_product_data AS(
    SELECT 
        product_id,
        COALESCE(product_category_name, 'Unknown') AS product_category_name
    FROM {{ref("stg_products")}}
)

SELECT 
    * 
FROM staging_product_data