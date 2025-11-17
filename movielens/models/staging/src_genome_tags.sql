with genome_tags as (
    select * from movielens.raw.genome_tags
)

select
    tagId as tag_id,
    tag
from
    genome_tags