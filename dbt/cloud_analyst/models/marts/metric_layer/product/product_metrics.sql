SELECT
    p.product_category_name,

    COUNT(DISTINCT oi.order_id) AS total_orders,

    SUM(oi.price) AS total_product_sales,

    SUM(oi.freight_value) AS total_freight_value

FROM {{ ref('fact_order_items') }} AS oi

INNER JOIN {{ ref('dim_products') }} AS p
    ON oi.product_id = p.product_id

INNER JOIN {{ ref('dim_orders') }} AS o
    ON oi.order_id = o.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    p.product_category_name