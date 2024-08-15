{{ config(
    materialized="table",
    schema="mart"
) }}

select 
    f.title as film_title,
    sum(fp.amount) as total_sales
from {{ ref('fact_payment') }} fp
join {{ ref('dim_rental') }} r on fp.rental_id = r.rental_id
join {{ ref('dim_inventory') }} i on r.inventory_id = i.inventory_id
join {{ ref('dim_film') }} f on i.film_id = f.film_id
group by f.title
order by total_sales desc
limit 1