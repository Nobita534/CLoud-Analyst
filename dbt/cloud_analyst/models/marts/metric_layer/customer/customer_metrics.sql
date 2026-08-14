SELECT
    customer_id,
    analysis_date_key,
    monetary,
    frequency,
    recency
FROM {{ref('fact_customer_rfm')}}

