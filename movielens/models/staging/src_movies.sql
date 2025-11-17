WITH movies as
(
select 
* 
from 
movielens.raw.movies
)

select
movieId as movie_id,
title,
genres
from
movies