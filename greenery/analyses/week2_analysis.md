# Week 2 Analysis
What is our user repeat rate? 79.838700

```sql
with purchases as (select
    sum(case when total_orders = 1 then 1 else 0 end) as single_purchase,
    sum(case when total_orders > 1 then 1 else 0 end) as multi_purchase
from dim_users)

select 100*(multi_purchase/(single_purchase+multi_purchase))
from purchases
```

What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Explain the marts models you added. Why did you organize the models in the way you did?