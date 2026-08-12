WITH int_seller_data AS (

    SELECT
        seller_id,
        seller_zip_code_prefix,
        seller_city,
        seller_state

    FROM {{ ref('int_seller') }} AS s
    INNER JOIN {{ref("int_geolocation")}} AS g ON s.seller_zip_code_prefix = geolocation_zip_code_prefix

)

SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state

FROM int_seller_data