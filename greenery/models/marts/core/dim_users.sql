{{
    config(
        materialized = 'table'
    )
}}

with orders_by_user as (
    select user_guid,
    count(distinct order_guid) as orders_count,
    sum(order_total_cost) as orders_total_cost
    from {{ ref('stg_greenery__orders') }}
    group by user_guid
),

order_items_by_user as (
    select u.user_guid,
    count(distinct oi.quantity) total_items
    from {{ ref('stg_greenery__users') }} u
    left join {{ ref('stg_greenery__orders') }} o on u.user_guid = o.user_guid
    left join {{ ref('stg_greenery__orders_items') }} oi on o.order_guid = oi.order_guid
    group by u.user_guid
),

sessions_by_user as (
    select u.user_guid,
    count(distinct e.session_id) as total_sessions
    from {{ ref('stg_greenery__users') }} u
    left join {{ ref('stg_greenery__events') }} e on u.user_guid = e.user_guid
    group by u.user_guid
)

select u.user_guid as user_id,
u.first_name,
u.last_name,
u.email,
a.address_guid as user_address_id,
a.address,
a.zipcode, 
a.state,
a.country,
coalesce(orders_count, 0) as total_orders,
coalesce(orders_total_cost, 0) as total_orders_cost,
coalesce(total_items, 0) as total_items,
coalesce(total_sessions, 0) as total_sessions
from {{ ref('stg_greenery__users') }} u
left join orders_by_user obu on u.user_guid = obu.user_guid
left join order_items_by_user oibu on u.user_guid = oibu.user_guid 
left join sessions_by_user sbu on u.user_guid = sbu.user_guid
left join {{ ref('stg_greenery__addresses') }} a on u.address_guid = a.address_guid