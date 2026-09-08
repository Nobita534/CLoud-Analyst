-- Assign each customer's full RFM monetary value to one representative location.
-- Delivered is the dataset status, not a delivery-as-of-snapshot assertion.
WITH customer_snapshots AS (
    SELECT DISTINCT
        customer_unique_id,
        analysis_date_key,
        TO_DATE(analysis_date_key::text, 'YYYYMMDD') AS snapshot_date
    FROM {{ ref('customer_metrics') }}
),

ranked_locations AS (
    SELECT
        cs.customer_unique_id,
        cs.analysis_date_key,
        o.order_id AS location_order_id,
        o.customer_state,
        o.customer_city,
        ROW_NUMBER() OVER (
            PARTITION BY cs.customer_unique_id, cs.analysis_date_key
            ORDER BY
                o.order_purchase_timestamp DESC NULLS LAST,
                o.order_id DESC NULLS LAST
        ) AS location_rank
    FROM customer_snapshots cs
    LEFT JOIN {{ ref('int_customer_order') }} o
        ON cs.customer_unique_id = o.customer_unique_id
        AND o.order_status = 'delivered'
        AND o.order_purchase_timestamp::date <= cs.snapshot_date
)

SELECT
    customer_unique_id || '_' || analysis_date_key::text AS customer_snapshot_key,
    customer_unique_id,
    analysis_date_key,
    location_order_id,
    customer_state,
    customer_city
FROM ranked_locations
WHERE location_rank = 1
