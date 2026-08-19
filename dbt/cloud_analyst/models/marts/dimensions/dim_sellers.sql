WITH int_seller_data AS (

    SELECT
        seller_id,
        seller_zip_code_prefix,
        seller_city,
        seller_state

    FROM {{ ref('int_seller') }} AS s
)

SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state

FROM int_seller_data