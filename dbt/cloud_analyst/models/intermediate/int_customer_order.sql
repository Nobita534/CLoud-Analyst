WITH orders AS (

    SELECT
        order_id,
        customer_id,
        order_purchase_timestamp,
        order_status

    FROM {{ ref('int_orders') }}

),

customers AS (

    SELECT
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix,
        customer_city,
        customer_state

    FROM {{ ref('int_customer') }}

)

SELECT
    o.order_id,

    o.customer_id,

    c.customer_unique_id,

    o.order_purchase_timestamp,
    o.order_status,

    c.customer_zip_code_prefix,
    c.customer_city,
    c.customer_state

FROM orders o

INNER JOIN customers c
    ON o.customer_id = c.customer_id