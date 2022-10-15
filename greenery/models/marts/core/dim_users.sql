{{
    config(
        materialized = 'table'
    )
}}

select *
from {{ ref('stg_greenery__users') }} u
left join {{ ref('stg_greenery__addresses') }} a