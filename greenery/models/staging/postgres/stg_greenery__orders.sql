{{
    config(
        materialized = 'view'
        , unique_key = 'order_guid'
    )
}}

with orders_source as (
    select * from {{ source('src_greenery', 'orders') }}
)

select order_id as order_guid
, user_id as user_guid
, promo_id
, address_id as address_guid
, created_at as created_at__orders
, order_cost
, shipping_cost
, order_total as order_total_cost
, tracking_id
, shipping_service
, estimated_delivery_at
, delivered_at
, status as order_status
from orders_source