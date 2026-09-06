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

voucher_payments AS (

    SELECT
        order_id,

        SUM(
            CASE
                WHEN payment_type = 'voucher' THEN payment_value
                ELSE 0
            END
        ) AS voucher_payment_value,

        BOOL_OR(payment_type = 'voucher') AS used_voucher

    FROM {{ ref('fact_order_payments') }}

    GROUP BY order_id

),

final AS (

    SELECT
        o.order_id,
        o.customer_id,
        o.customer_unique_id,
        o.order_purchase_date_key,

        p.order_payment_value AS total_revenue,
        COALESCE(vp.voucher_payment_value, 0) AS voucher_payment_value,
        COALESCE(vp.used_voucher, FALSE) AS used_voucher

    FROM delivered_orders o

    INNER JOIN order_payments p
        ON o.order_id = p.order_id

    LEFT JOIN voucher_payments vp 
        ON o.order_id = vp.order_id

)

SELECT *
FROM final