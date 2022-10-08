{{
    config(
        materialized = 'view'
        , unique_key = 'user_guid'
    )
}}

with users_source as (
    select * from {{ source('src_greenery', 'users') }}
)

select user_id as user_guid
, first_name
, last_name
, email
, phone_number
, created_at as created_at__user
, updated_at as updated_at__user
, address_id as address_guid
from users_source