SELECT
    SUM(payment_value) AS total_revenue
FROM {{ref('fact_order_payments')}} fop
JOIN {{ref('dim_orders')}} o ON fop.order_id = o.order_id
WHERE o.order_status = 'delivered'