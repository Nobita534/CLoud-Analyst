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

final AS (

    SELECT
        doi.product_id,
        c.customer_state,
        doi.order_purchase_date_key,

        COUNT(DISTINCT doi.fact_item_id) AS total_items_sold,
        COUNT(DISTINCT doi.order_id) AS total_orders,

        SUM(doi.price) AS total_product_sales,
        SUM(doi.freight_value) AS total_freight_value

    FROM delivered_order_items doi

    INNER JOIN {{ ref('dim_customers') }} c
        ON doi.customer_id = c.customer_id

    GROUP BY
        doi.product_id,
        c.customer_state,
        doi.order_purchase_date_key

)

SELECT *
FROM final