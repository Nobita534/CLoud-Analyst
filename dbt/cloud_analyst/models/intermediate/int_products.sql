WITH staging_product_data AS(
    SELECT 
        product_id,
        product_category_name
    FROM {{ref("stg_products")}}
)

SELECT 
    * 
FROM staging_product_data