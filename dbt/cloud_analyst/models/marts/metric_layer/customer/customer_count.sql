SELECT
    c.customer_id,
    oi.seller_id,
    o.order_id,
    COUNT(DISTINCT customer_unique_id) 
FROM {{ref('dim_customers')}} c
JOIN {{ref('dim_orders')}} o ON c.customer_id = o.customer_id
JOIN {{ref("fact_order_items")}} oi ON oi.order_id = o.order_id
GROUP BY
    c.customer_id,
    oi.seller_id,
    o.order_id