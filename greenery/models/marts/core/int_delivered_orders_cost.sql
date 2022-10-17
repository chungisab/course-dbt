{{
    config(
        materialized = 'table'
    )
}}

select user_guid, sum(order_total_cost) as delivered_orders_total_cost
from {{ ref('stg_greenery__orders') }} o
where order_status = 'delivered'
group by user_guid
