## Week 1 Analysis
1. How many users do we have?
# 130 users

``` sql
select count(user_guid) as user_count from stg_greenery__users
```

2. On average, how many orders do we receive per hour?
# 7.52 order/hr

``` sql
select avg(order_count) avg_order_per_hour
from(
    select DATE_TRUNC('hour', created_at__orders) as hour,
        count(order_guid) as order_count
    from stg_greenery__orders
    group by DATE_TRUNC('hour', created_at__orders)
    order by DATE_TRUNC('hour', created_at__orders))
```

3. On average, how long does an order take from being placed to being delivered?
# 3.89 days

```sql
select AVG(datediff('day', created_at__orders, delivered_at)) as days_avg
from stg_greenery__orders
where delivered_at is not null -- need to only look at orders that have been delievered
```

4. How many users have only made one purchase? Two purchases? Three+ purchases?
# 25 users have made only one purchase, 28 have made two, and 71 have made more than three purchases.

```sql
with order_count as (
    select user_guid, count(order_guid) as order_cnt
    from stg_greenery__orders
    group by user_guid
    order by order_cnt desc)
select
    SUM(CASE WHEN order_cnt = 1 THEN 1 ELSE 0 END) as one_purchase,
    SUM(CASE WHEN order_cnt = 2 THEN 1 ELSE 0 END) as two_purchases,
    SUM(CASE WHEN order_cnt >=3 THEN 1 ELSE 0 END) as three_plus_purchases
from order_count
```

5. On average, how many unique sessions do we have per hour?
# 16.33 unique sessions/hr

```sql
select avg(sessions_count) as avg_sessions_count
from (select
    DATE_TRUNC('hour', created_at__event) as event_hour,
    COUNT(distinct session_id) sessions_count
from stg_greenery__events
group by DATE_TRUNC('hour', created_at__event)
order by event_hour desc)
```
