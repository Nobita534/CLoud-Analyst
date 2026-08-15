SELECT
    customer_id,
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