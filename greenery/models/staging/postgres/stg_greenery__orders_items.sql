{{
    config(
        materialized = 'view'
        , unique_key = 'order_guid'
    )
}}

with order_items_source as (
    select * from {{ source('src_greenery', 'order_items') }}
)

select order_id as order_guid
, product_id as product_guid
, quantity
from order_items_source
