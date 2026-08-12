WITH int_order_reviews_data AS (

    SELECT
        review_id,
        order_id,
        review_comment_title,
        review_comment_message,
        review_score

    FROM {{ ref('int_order_reviews') }}

)

SELECT
    review_id,
    order_id,
    review_comment_title,
    review_comment_message,
    review_score

FROM int_order_reviews_data