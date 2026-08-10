WITH staging_geolocation_data AS(
    SELECT * FROM {{ref("stg_geolocation")}}
)

SELECT
    *
FROM staging_geolocation_data