# DBT Project: Transformed Models - fact tables and data marts.

## Project Progress
- ✅ Setup dbt + Snowflake
- ✅ Configure dbt_project.yml and packages
- ✅ Create source and staging tables
- ✅ Transformed models (fact tables, data marts)
- ⬜ Macro functions
- ⬜ Generic and singular tests
- ⬜ Deploy models using Airflow

### create the fact table 
==> which is a dimensional, table that represent numeric events that connected to other tables 

inside the marts create : int_order_items.sql add 

```sql
-- Transform models (fact tables, data marts)
select
    line_item.order_item_key,
    line_item.part_key,
    line_item.line_number,
    line_item.extended_price,
    orders.order_key,
    orders.customer_key,
    orders.order_date,
    {{ discounted_amount('line_item.extended_price', 'line_item.discount_percentage') }} as item_discount_amount
from
    {{ ref('stg_tpch_orders') }} as orders
join
    {{ ref('stg_tpch_line_items') }} as line_item
        on orders.order_key = line_item.order_key
order by
    orders.order_date
```
<!-- create marts models -->
 then run `dbt run -s +int_order_items+` without ++ it was generating error or `dbt run ` only. 

