WITH int_order_items_data AS (

    SELECT
        order_item_id,
        order_id,
        product_id,
        seller_id,
        price,
        freight_value

    FROM {{ ref('int_order_items') }}

)

SELECT
    ROW_NUMBER() OVER (
        ORDER BY order_id, order_item_id
    ) AS fact_item_id,

    order_id,
    product_id,
    seller_id,
    price,
    freight_value

FROM int_order_items_data