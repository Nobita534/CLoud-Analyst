WITH int_orders_data AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        order_purchase_timestamp,
        order_approved_at,
        order_delivered_carrier_date,
        order_delivered_customer_date,
        order_estimated_delivery_date

    FROM {{ ref('int_orders') }}
),
int_customer_data AS(
    SELECT 
        customer_id,
        customer_unique_id
    FROM {{ref('int_customer')}}
)

SELECT
    order_id,
    order_status,
    customer_unique_id,

    {{ generate_date_key('order_purchase_timestamp') }}
        AS order_purchase_date_key,

    {{ generate_date_key('order_approved_at') }}
        AS order_approved_date_key,

    {{ generate_date_key('order_delivered_carrier_date') }}
        AS order_delivered_carrier_date_key,

    {{ generate_date_key('order_delivered_customer_date') }}
        AS order_delivered_customer_date_key,

    {{ generate_date_key('order_estimated_delivery_date') }}
        AS order_estimated_delivery_date_key

FROM int_orders_data
JOIN int_customer_data ON int_orders_data.customer_id = int_customer_data.customer_id