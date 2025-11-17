{{
    config(
    materialized='incremental',
    on_schema_change='fail'
    )
}}

WITH src_ratings as
(
    select * from
        {{ ref('src_ratings') }}
)

select
    user_id,
    movie_id,
    rating,
    rating_timestamp
from src_ratings
where rating is not null

{% if is_incremental() %}
    and rating_timestamp > (select max(rating_timestamp) from {{ this }})
{% endif %}

-- src_rating (base table) = 5PM
-- New row got added at 6 PM
-- this = fct_ratings
-- 6PM > 5PM => true => only new rows will be added