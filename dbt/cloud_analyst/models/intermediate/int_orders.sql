WITH staging_orders_data AS(
    SELECT * FROM {{ref("stg_orders")}}
)

SELECT
    *,
    TO_CHAR(order_purchase_timestamp, 'YYYYMMDD')::INTEGER AS order_purchase_date_key,
    TO_CHAR(order_approved_at, 'YYYYMMDD')::INTEGER AS order_approved_at_date_key,
    TO_CHAR(order_delivered_carrier_date, 'YYYYMMDD')::INTEGER AS order_delivered_carrier_date_key,
    TO_CHAR(order_delivered_customer_date, 'YYYYMMDD')::INTEGER AS order_delivered_customer_date_key,
    TO_CHAR(order_estimated_delivery_date, 'YYYYMMDD')::INTEGER AS order_estimated_delivery_date_key
FROM staging_orders_data

