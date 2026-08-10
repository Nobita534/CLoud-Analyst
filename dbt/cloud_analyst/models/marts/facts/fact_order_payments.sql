WITH int_order_payments_data AS (

    SELECT
        payment_sequential,
        order_id,
        payment_type,
        payment_installments,
        payment_value

    FROM {{ ref('int_order_payments') }}

)

SELECT
    ROW_NUMBER() OVER (
        ORDER BY order_id, payment_sequential
    ) AS fact_payment_id,

    order_id,
    payment_type,
    payment_installments,
    payment_value

FROM int_order_payments_data