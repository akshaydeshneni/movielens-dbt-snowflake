select
    movie_id,
    tag_id,
    relevance
from
    {{ ref('fct_genome_scores') }}
where relevance <= 0