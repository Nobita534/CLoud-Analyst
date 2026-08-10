WITH staging_order_reviews_data AS(
    SELECT
        review_id,
        order_id,
        review_comment_title,
        review_comment_message,
        review_score
    FROM {{ref("stg_order_reviews")}}
    WHERE order_id IS NOT NULL
)

SELECT 
    *
FROM staging_order_reviews_data