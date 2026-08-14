SELECT
    COUNT(DISTINCT customer_unique_id)
FROM {{ref("fact_customer_rfm")}}