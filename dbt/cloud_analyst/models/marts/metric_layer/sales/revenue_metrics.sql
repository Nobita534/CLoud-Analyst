WITH delivered_orders AS (

    SELECT
        order_id,
        customer_id,
        customer_unique_id,
        {{ generate_date_key('order_purchase_timestamp') }}
            AS order_purchase_date_key

    FROM {{ ref('int_customer_order') }}

    WHERE order_status = 'delivered'

),

order_payments AS (

    SELECT
        order_id,
        order_payment_value

    FROM {{ ref('int_order_payment_summary') }}

),

final AS (

    SELECT
        o.order_id,
        o.customer_id,
        o.customer_unique_id,
        o.order_purchase_date_key,

        p.order_payment_value AS total_revenue

    FROM delivered_orders o

    INNER JOIN order_payments p
        ON o.order_id = p.order_id

)

SELECT *
FROM final