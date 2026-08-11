WITH int_customer_data AS (

    SELECT
        customer_unique_id,
        customer_id,
        customer_zip_code_prefix,
        customer_city,
        customer_state

    FROM {{ ref('int_customer') }}

)

SELECT
    customer_unique_id,
    customer_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state

FROM int_customer_data