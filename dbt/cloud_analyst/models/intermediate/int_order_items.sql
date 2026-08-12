WITH staging_order_items_data AS(
    SELECT * FROM {{ref("stg_order_items")}}
)


SELECT 
    *
FROM staging_order_items_data