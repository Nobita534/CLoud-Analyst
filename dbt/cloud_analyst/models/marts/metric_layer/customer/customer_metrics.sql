SELECT
    customer_unique_id || '_' || analysis_date_key::text AS customer_snapshot_key,
    customer_unique_id,
    analysis_date_key,

    recency,
    frequency,
    monetary,

    r_score,
    f_score,
    m_score,
    rfm_score,

    customer_segment

FROM {{ ref('int_customer_rfm_scored') }}