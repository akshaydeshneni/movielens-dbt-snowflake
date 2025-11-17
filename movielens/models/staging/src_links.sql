with links as (
    select * from {{ source('movielens', 'r_links')}}
)

select
    movieId as movie_id,
    imdbId as imdb_id,
    tmdbId as tmdb_id
from links