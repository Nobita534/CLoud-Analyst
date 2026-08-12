SELECT
    COUNT(DISTINCT CASE
        WHEN fop.payment_type = 'voucher'
        THEN fop.order_id
    END) * 100.0
    / NULLIF(COUNT(DISTINCT fop.order_id), 0)
        AS voucher_usage_rate

FROM {{ ref('fact_order_payments') }} AS fop

INNER JOIN {{ ref('dim_orders') }} AS o
    ON fop.order_id = o.order_id

WHERE o.order_status = 'delivered'