WITH customer_rfm AS (

    SELECT
        customer_id,
        analysis_date_key,
        monetary,
        frequency,
        recency

    FROM {{ ref('fact_customer_rfm') }}

),

rfm_scored AS (

    SELECT
        customer_id,
        analysis_date_key,
        monetary,
        frequency,
        recency,

        NTILE(5) OVER (
            PARTITION BY analysis_date_key
            ORDER BY recency DESC
        ) AS r_score,

        NTILE(5) OVER (
            PARTITION BY analysis_date_key
            ORDER BY frequency ASC
        ) AS f_score,

        NTILE(5) OVER (
            PARTITION BY analysis_date_key
            ORDER BY monetary ASC
        ) AS m_score

    FROM customer_rfm

),

rfm_with_total_score AS (

    SELECT
        customer_id,
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

-- Step 4: Customer Segmentation
customer_segmented AS (

    SELECT
        *,

        CASE
            WHEN r_score >= 4
                AND f_score >= 4
                AND m_score >= 4
                THEN 'VIP'

            WHEN r_score >= 4
                AND f_score >= 4
                AND m_score < 4
                THEN 'Loyal'

            WHEN r_score >= 4
                AND f_score BETWEEN 2 AND 3
                THEN 'Potential Loyalist'

            WHEN r_score <= 2
                AND (f_score >= 3 OR m_score >= 3)
                THEN 'At Risk'

            ELSE 'Others'
        END AS customer_segment

    FROM rfm_with_total_score

)

SELECT *
FROM customer_segmented