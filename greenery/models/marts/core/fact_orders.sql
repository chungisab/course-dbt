{{
    config(
        materialized = 'table'
    )
}}

SELECT
  o.order_guid,
  o.created_at__orders as order_created_at,
  o.order_cost,
  o.shipping_cost,
  o.order_total_cost,
  zeroifnull(prom.discount) as promo_discount,
  o.order_status,
  o.shipping_service,
  oi.quantity,
  u.user_guid
FROM {{ ref('stg_greenery__orders') }} o
LEFT JOIN {{ ref('stg_greenery__orders_items') }} oi
  ON o.order_guid = oi.order_guid
LEFT JOIN {{ ref('stg_greenery__products') }} prod
ON oi.product_guid = prod.product_guid
LEFT JOIN {{ ref('stg_greenery__promos') }} prom
  ON o.promo_guid = prom.promo_guid
LEFT JOIN {{ ref('stg_greenery__users') }} u
  ON o.user_guid = u.user_guid
LEFT JOIN {{ ref('stg_greenery__addresses') }} a
  ON o.address_guid = a.address_guid

