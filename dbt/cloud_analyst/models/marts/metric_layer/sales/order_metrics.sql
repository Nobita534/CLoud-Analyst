SELECT
    o.customer_id,
    oi.seller_id,
    oi.product_id,
    order_delivered_customer_date_key,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM {{ref('dim_orders')}} o
JOIN {{ref('dim_customers')}} c ON o.customer_id = c.customer_id
JOIN {{ref('fact_order_items')}} oi ON oi.order_id = o.order_id
WHERE order_status = 'delivered'
GROUP BY
    o.customer_id,
    oi.seller_id,
    oi.product_id,
    order_delivered_customer_date_key