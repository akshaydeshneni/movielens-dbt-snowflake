{{config(
    materialized='table'
)}}

with ratings as (
   select * from movielens.raw.ratings
)

select
    userId as user_id,
    movieId as movie_id,
    rating,
    to_timestamp_ltz(timestamp) as rating_timestamp
from ratings
