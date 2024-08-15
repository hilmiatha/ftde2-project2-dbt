{{ config(
    materialized="table",
    schema="mart"
) }}


select
    concat(a.first_name, ' ', a.last_name) as actor_name,
    count(fa.actor_id) as number_of_roles
from {{ ref('dim_actor') }} as a
join {{ ref('dim_film_actor') }} as fa on a.actor_id = fa.actor_id
join {{ ref('dim_film') }} as f on fa.film_id = f.film_id
group by actor_name
order by number_of_roles desc
limit 1