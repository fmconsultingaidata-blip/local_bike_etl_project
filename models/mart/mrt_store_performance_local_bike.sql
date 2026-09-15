{{ config(
    materialized='table'
) }}

with sales_by_store as (
    select
        store_id,
        count(distinct order_id) as total_store_orders,
        sum(total_order_amount) as total_store_revenue
    from {{ ref('int_orders_summary') }}
    group by store_id
),

stock_by_store as (
    select
        store_id,
        store_name,
        store_city,
        store_state,
        sum(stock_quantity) as total_stock_quantity,
        sum(stock_total_value) as total_stock_value
    from {{ ref('int_inventory_status') }}
    group by store_id, store_name, store_city, store_state
)

select
    s.store_id,
    s.store_name,
    s.store_city,
    s.store_state,
    s.total_stock_quantity,
    s.total_stock_value,
    coalesce(v.total_store_orders, 0) as total_store_orders,
    coalesce(v.total_store_revenue, 0) as total_store_revenue
from stock_by_store s
left join sales_by_store v on s.store_id = v.store_id