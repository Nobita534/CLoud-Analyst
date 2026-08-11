with source as (

    select *
    from {{ source('olist', 'olist_order_reviews_dataset') }}
    where order_id is not null and review_score is not null

)

select
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
from source
