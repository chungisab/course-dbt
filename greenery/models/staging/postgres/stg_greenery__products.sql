{{
    config(
        materialized = 'view'
        , unique_key = 'product_guid'
    )
}}

with products_source as (
    select * from {{ source('src_greenery', 'products') }}
)

select product_id as product_guid
, name as product_name
, price
, inventory
from products_source
