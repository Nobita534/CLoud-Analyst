WITH staging_seller_data AS(
    SELECT * FROM {{ref("stg_sellers")}}
)

SELECT 
    * 
FROM staging_seller_data