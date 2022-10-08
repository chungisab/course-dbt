{{
    config(
        materialized = 'view'
        , unique_key = 'event_guid'
    )
}}

with events_source as (
    select * from {{ source('src_greenery', 'events') }}
)

select event_id as event_guid
, session_id
, user_id as user_guid
, event_type
, page_url
, created_at as created_at__event
, order_id as order_guid
, product_id as product_guid
from events_source