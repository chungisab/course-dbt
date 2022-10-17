{{
    config(
        materialized = 'table'
    )
}}

select p.promo_guid, p.discount, p.promo_status,
SUM(order_total_cost)*((100-discount)/100) as discounted_cost
from {{ ref('stg_greenery__promos') }} p
left join {{ ref('stg_greenery__orders') }} o on p.promo_guid = o.promo_guid
group by 1, 2, 3
