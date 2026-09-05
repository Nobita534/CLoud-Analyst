WITH customer_rfm AS (

    SELECT
        customer_unique_id,
        analysis_date_key,
        monetary,
        frequency,
        recency

    FROM {{ ref('fact_customer_rfm') }}

),

percentile_thresholds AS (

    SELECT
        analysis_date_key,

        PERCENTILE_CONT(0.20) WITHIN GROUP (
            ORDER BY recency::double precision
        ) AS r_p20,

        PERCENTILE_CONT(0.40) WITHIN GROUP (
            ORDER BY recency::double precision
        ) AS r_p40,

        PERCENTILE_CONT(0.60) WITHIN GROUP (
            ORDER BY recency::double precision
        ) AS r_p60,

        PERCENTILE_CONT(0.80) WITHIN GROUP (
            ORDER BY recency::double precision
        ) AS r_p80,

        PERCENTILE_CONT(0.20) WITHIN GROUP (
            ORDER BY monetary::double precision
        ) AS m_p20,

        PERCENTILE_CONT(0.40) WITHIN GROUP (
            ORDER BY monetary::double precision
        ) AS m_p40,

        PERCENTILE_CONT(0.60) WITHIN GROUP (
            ORDER BY monetary::double precision
        ) AS m_p60,

        PERCENTILE_CONT(0.80) WITHIN GROUP (
            ORDER BY monetary::double precision
        ) AS m_p80

    FROM customer_rfm

    GROUP BY analysis_date_key

),

rfm_scored AS (

    SELECT
        rfm.customer_unique_id,
        rfm.analysis_date_key,
        rfm.monetary,
        rfm.frequency,
        rfm.recency,

        -- Lower Recency is better
        CASE
            WHEN rfm.recency <= p.r_p20 THEN 5
            WHEN rfm.recency <= p.r_p40 THEN 4
            WHEN rfm.recency <= p.r_p60 THEN 3
            WHEN rfm.recency <= p.r_p80 THEN 2
            ELSE 1
        END AS r_score,

        -- Frequency uses actual order-count thresholds
        CASE
            WHEN rfm.frequency = 1 THEN 1
            WHEN rfm.frequency = 2 THEN 2
            WHEN rfm.frequency = 3 THEN 3
            WHEN rfm.frequency = 4 THEN 4
            WHEN rfm.frequency >= 5 THEN 5
        END AS f_score,

        -- Higher Monetary is better
        CASE
            WHEN rfm.monetary <= p.m_p20 THEN 1
            WHEN rfm.monetary <= p.m_p40 THEN 2
            WHEN rfm.monetary <= p.m_p60 THEN 3
            WHEN rfm.monetary <= p.m_p80 THEN 4
            ELSE 5
        END AS m_score

    FROM customer_rfm rfm

    INNER JOIN percentile_thresholds p
        ON rfm.analysis_date_key = p.analysis_date_key

),

rfm_with_total_score AS (

    SELECT
        customer_unique_id,
        analysis_date_key,
        monetary,
        frequency,
        recency,
        r_score,
        f_score,
        m_score,

        r_score + f_score + m_score AS rfm_score

    FROM rfm_scored

),

customer_segmented AS (

    SELECT
        *,

        CASE
            WHEN r_score >= 4
                AND f_score >= 4
                AND m_score >= 4
                THEN 'VIP'

            WHEN r_score >= 3
                AND f_score >= 3
                THEN 'Active Repeat Customer'

            WHEN r_score >= 4
                AND f_score = 2
                THEN 'Potential Loyalist'

            WHEN r_score >= 4
                AND f_score = 1
                THEN 'Recent One-time Customer'

            WHEN r_score <= 2
                AND f_score >= 2
                THEN 'At Risk'

            WHEN r_score <= 2
                AND f_score = 1
                AND m_score >= 4
                THEN 'High-Value Lapsed Customer'

            ELSE 'Others'
        END AS customer_segment


    FROM rfm_with_total_score

)

SELECT *
FROM customer_segmented