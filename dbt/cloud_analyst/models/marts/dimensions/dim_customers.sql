WITH int_geolocation_data AS (

    SELECT
        geolocation_zip_code_prefix,
        MAX(geolocation_city) AS geolocation_city,
        MAX(geolocation_state) AS geolocation_state

    FROM {{ ref('int_geolocation') }}

    GROUP BY geolocation_zip_code_prefix

),

int_customer_data AS (

    SELECT
        c.customer_unique_id,
        c.customer_id,
        c.customer_zip_code_prefix,
        c.customer_city,
        c.customer_state

    FROM {{ ref('int_customer') }} AS c


)

SELECT *
FROM int_customer_data