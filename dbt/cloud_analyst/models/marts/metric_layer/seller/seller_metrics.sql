WITH seller_order_sales AS (

    SELECT
        seller_id,
        order_id,
        SUM(price) AS order_sales

    FROM {{ ref('fact_order_items') }}

    GROUP BY
        seller_id,
        order_id

),

order_reviews AS (

    SELECT
        order_id,
        AVG(review_score) AS average_review_score

    FROM {{ ref('fact_review') }}

    GROUP BY order_id

),

seller_orders AS (

    SELECT
        sos.seller_id,
        sos.order_id,
        sos.order_sales,

        o.order_purchase_timestamp,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date,

        r.average_review_score

    FROM seller_order_sales sos

    INNER JOIN {{ ref('int_orders') }} o
        ON sos.order_id = o.order_id

    LEFT JOIN order_reviews r
        ON sos.order_id = r.order_id

    WHERE o.order_status = 'delivered'

)

SELECT
    s.seller_id,
    s.seller_state,

    COUNT(*) AS total_orders,
    SUM(so.order_sales) AS total_sales,

    COUNT(so.average_review_score) AS reviewed_orders,
    AVG(so.average_review_score) AS average_review_score,

    COUNT(so.average_review_score) * 100.0
        / NULLIF(COUNT(*), 0) AS review_coverage_rate,

    AVG(
        so.order_delivered_customer_date::date
        - so.order_purchase_timestamp::date
    ) AS average_delivery_days,

    AVG(
        CASE
            WHEN so.order_delivered_customer_date IS NOT NULL
                 AND so.order_estimated_delivery_date IS NOT NULL
            THEN CASE
                WHEN so.order_delivered_customer_date
                    <= so.order_estimated_delivery_date
                THEN 100.0
                ELSE 0.0
            END
        END
    ) AS on_time_delivery_rate

FROM seller_orders so

INNER JOIN {{ ref('dim_sellers') }} s
    ON so.seller_id = s.seller_id

GROUP BY
    s.seller_id,
    s.seller_state