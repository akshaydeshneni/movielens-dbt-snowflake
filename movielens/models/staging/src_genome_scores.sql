with genome_scores as (
    select * from movielens.raw.genome_scores
)

select
    movieId as movie_id,
    tagId as tag_id,
    relevance
from genome_scores