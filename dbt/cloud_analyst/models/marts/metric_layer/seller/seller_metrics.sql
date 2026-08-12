WITH review_metrics AS (

    SELECT
        order_id,
        AVG(review_score) AS average_review_score

    FROM {{ ref('fact_review') }}

    GROUP BY order_id

),

seller_sales AS (

    SELECT
        oi.seller_id,
        oi.order_id,
        oi.price

    FROM {{ ref('fact_order_items') }} AS oi

    INNER JOIN {{ ref('dim_orders') }} AS o
        ON oi.order_id = o.order_id

    WHERE o.order_status = 'delivered'
    AND EXISTS (
        SELECT 1
        FROM {{ref('fact_review')}} r
        WHERE r.order_id = oi.order_id
    )

)

SELECT
    s.seller_id,
    s.seller_state,

    COUNT(DISTINCT ss.order_id) AS total_orders,

    SUM(ss.price) AS total_sales,

    AVG(rm.average_review_score) AS average_review_score

FROM seller_sales AS ss

INNER JOIN {{ ref('dim_sellers') }} AS s
    ON ss.seller_id = s.seller_id

LEFT JOIN review_metrics AS rm
    ON ss.order_id = rm.order_id

GROUP BY
    s.seller_id,
    ss.order_id,
    s.seller_state