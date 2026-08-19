SELECT
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    order_delivered_customer_date_key,
    SUM(payment_value) AS total_revenue
FROM {{ref('fact_order_payments')}} fop
JOIN {{ref('dim_orders')}} o ON fop.order_id = o.order_id
JOIN {{ref('dim_customers')}} c ON c.customer_id = o.customer_id
JOIN {{ref('fact_order_items')}} oi ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY o.customer_id,
    c.customer_state,
    c.customer_city,
    oi.product_id,
    oi.seller_id,
    order_delivered_customer_date_key