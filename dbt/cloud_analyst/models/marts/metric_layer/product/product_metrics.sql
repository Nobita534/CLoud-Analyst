WITH delivered_order_items AS (

    SELECT
        oi.fact_item_id,
        oi.order_id,
        oi.product_id,
        oi.price,
        oi.freight_value,

        o.customer_id,
        o.order_purchase_date_key

    FROM {{ ref('fact_order_items') }} oi

    INNER JOIN {{ ref('dim_orders') }} o
        ON oi.order_id = o.order_id

    WHERE o.order_status = 'delivered'

),

order_product_metrics AS (

    SELECT
        doi.order_id,
        doi.product_id,
        c.customer_state,
        doi.order_purchase_date_key,

        COUNT(DISTINCT doi.fact_item_id) AS items_sold,
        SUM(doi.price) AS product_sales,
        SUM(doi.freight_value) AS freight_value

    FROM delivered_order_items doi

    INNER JOIN {{ ref('dim_customers') }} c
        ON doi.customer_id = c.customer_id

    GROUP BY
        doi.order_id,
        doi.product_id,
        c.customer_state,
        doi.order_purchase_date_key

),

order_reviews AS (

    SELECT
        order_id,
        AVG(review_score) AS order_review_score

    FROM {{ ref('fact_review') }}

    GROUP BY order_id

),

final AS (

    SELECT
        op.product_id,
        op.customer_state,
        op.order_purchase_date_key,

        SUM(op.items_sold) AS total_items_sold,
        COUNT(DISTINCT op.order_id) AS total_orders,
        SUM(op.product_sales) AS total_product_sales,
        SUM(op.freight_value) AS total_freight_value,

        COUNT(r.order_id) AS reviewed_orders,
        AVG(r.order_review_score) AS average_review_score,

        100.0 * COUNT(r.order_id)
            / NULLIF(COUNT(DISTINCT op.order_id), 0)
            AS review_coverage_rate

    FROM order_product_metrics op

    LEFT JOIN order_reviews r
        ON op.order_id = r.order_id

    GROUP BY
        op.product_id,
        op.customer_state,
        op.order_purchase_date_key

)

SELECT *
FROM final