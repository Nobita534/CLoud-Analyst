WITH int_orders_data AS (

    SELECT
        order_id,
        customer_id,
        order_purchase_timestamp,
        order_status

    FROM {{ ref('int_orders') }}

),

int_customer_data AS (

    SELECT
        customer_id,
        customer_unique_id

    FROM {{ ref('int_customer') }}

),

int_order_payments_data AS (

    SELECT
        order_id,
        payment_value

    FROM {{ ref('int_order_payments') }}

),

customer_orders AS (

    SELECT
        c.customer_unique_id,
        o.order_id,
        o.order_purchase_timestamp,
        o.order_status

    FROM int_orders_data o

    INNER JOIN int_customer_data c
        ON o.customer_id = c.customer_id

    WHERE o.order_status = 'delivered'

),

customer_payments AS (

    SELECT
        co.customer_unique_id,
        co.order_id,
        co.order_purchase_timestamp,
        COALESCE(p.payment_value, 0) AS payment_value

    FROM customer_orders co

    LEFT JOIN int_order_payments_data p
        ON co.order_id = p.order_id

),

snapshot_dates AS (

    SELECT
        DATE '2016-12-31' AS snapshot_date

    UNION ALL

    SELECT
        DATE '2017-12-31'

    UNION ALL

    SELECT
        DATE '2018-12-31'

),

customer_snapshot AS (

    SELECT DISTINCT
        s.snapshot_date,
        c.customer_unique_id

    FROM snapshot_dates s

    CROSS JOIN (
        SELECT DISTINCT
            customer_unique_id

        FROM customer_orders
    ) c

),

rfm_metrics AS (

    SELECT
        cs.snapshot_date,
        cs.customer_unique_id,

        COUNT(DISTINCT cp.order_id) AS frequency,

        COALESCE(
            SUM(cp.payment_value),
            0
        ) AS monetary,

        (
            cs.snapshot_date
            - MAX(
                cp.order_purchase_timestamp::date
            )
        ) AS recency

    FROM customer_snapshot cs

    LEFT JOIN customer_payments cp
        ON cs.customer_unique_id = cp.customer_unique_id

        -- Rolling 12-month window
        AND cp.order_purchase_timestamp::date
            > cs.snapshot_date - INTERVAL '12 months'

        AND cp.order_purchase_timestamp::date
            <= cs.snapshot_date

    GROUP BY
        cs.snapshot_date,
        cs.customer_unique_id

),

final AS (

    SELECT
        ROW_NUMBER() OVER (
            ORDER BY
                snapshot_date,
                customer_unique_id
        ) AS customer_rfm_id,

        customer_unique_id,

        {{generate_date_key('snapshot_date')}} AS "analysis_date_key",

        frequency,

        monetary,

        recency

    FROM rfm_metrics

    -- Chỉ giữ customer có ít nhất một order
    -- trong rolling window
    WHERE frequency > 0

)

SELECT *
FROM final