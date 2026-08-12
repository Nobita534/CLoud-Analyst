WITH staging_order_payments_data AS(
    SELECT * FROM {{ref("stg_order_payments")}}
)

SELECT 
    *
FROM staging_order_payments_data