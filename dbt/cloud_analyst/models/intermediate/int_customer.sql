WITH staging_customer_data AS (
    SELECT * FROM {{ref("stg_customers")}}
)

SELECT
    *
FROM staging_customer_data


