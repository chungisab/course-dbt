{{
    config(
        materialized = 'view'
        , unique_key = 'promo_guid'
    )
}}

with promos_source as (
    select * from {{ source('src_greenery', 'promos') }}
)

select promo_id as promo_guid
, discount
, status as promo_status
from promos_source
