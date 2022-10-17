{{
    config(
        materialized = 'table'
    )
}}

select p.product_guid, p.product_name, p.price, p.inventory,
count(page_url) as url_count
from {{ ref('stg_greenery__products') }} p
left join {{ ref('stg_greenery__events') }} e on p.product_guid = e.product_guid
group by 1, 2, 3, 4
order by 2