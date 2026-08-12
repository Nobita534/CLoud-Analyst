WITH date_data AS (

    SELECT
        generate_series(
            DATE '2016-01-01',
            DATE '2018-12-31',
            INTERVAL '1 day'
        )::date AS full_date

)

SELECT
    CAST(TO_CHAR(full_date, 'YYYYMMDD') AS INTEGER) AS date_key,
    full_date,
    EXTRACT(YEAR FROM full_date)::INTEGER AS year,
    EXTRACT(MONTH FROM full_date)::INTEGER AS month,
    EXTRACT(QUARTER FROM full_date)::INTEGER AS quarter,
    TRIM(TO_CHAR(full_date, 'Day')) AS day_name,
    TRIM(TO_CHAR(full_date, 'Month')) AS month_name

FROM date_data