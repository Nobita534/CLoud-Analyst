with payment_rows as (
    select
        order_id,
        payment_value
    from {{ ref('int_order_payments') }}
),

order_payment_summary as (
    select
        order_id,
        sum(payment_value) as order_payment_value
    from payment_rows
    group by order_id
)

select *
from order_payment_summary