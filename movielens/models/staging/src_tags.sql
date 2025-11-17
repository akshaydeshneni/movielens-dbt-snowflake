{{config(
    materialized='table'
)}}

with tags as 
(
    select * from movielens.raw.tags
)

select
    userId as user_id,
    movieId as movie_id,
    tag,
    to_timestamp_ltz(timestamp) as tag_timestamp
from tags