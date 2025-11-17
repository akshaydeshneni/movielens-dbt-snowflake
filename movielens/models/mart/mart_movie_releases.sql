{{
config(
    materialized='table'
)  }}

with fct_ratings as (
    select * from {{ ref('fct_ratings') }}
),
seed_dates as (
    select * from {{ ref('seed_movie_release_dates') }}
)

select
    fr.*,
    case when sd.release_date is not null then 'unknown' else 'known' end as release_info_available
from fct_ratings fr
join seed_dates sd 
on fr.movie_id = sd.movie_id