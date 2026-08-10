WITH staging_product_category_name_translation_data AS(
    SELECT * FROM {{ref("stg_product_category_translation")}}
)

SELECT
    *
FROM staging_product_category_name_translation_data