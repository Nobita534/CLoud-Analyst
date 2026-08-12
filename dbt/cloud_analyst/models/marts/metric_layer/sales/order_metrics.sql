SELECT
    COUNT(order_id) AS total_orders
FROM {{ref('dim_orders')}}
WHERE order_status = 'delivered'