WITH int_products_data AS (

    SELECT
        product_id,
        product_category_name

    FROM {{ ref('int_products') }}

)

SELECT
    product_id,
    product_category_name

FROM int_products_data