{{ config(
    materialized='table'
)}}

with stores as (
    select * from {{ ref('stg_local_bike__stores') }}
),

sales_by_store as (
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
        sum(stock_quantity) as total_stock_quantity,
        sum(stock_total_value) as total_stock_value
    from {{ ref('int_inventory_status') }}
    group by store_id
)

select
    st.store_id,
    st.store_name,
    st.store_city,
    st.store_state,
    coalesce(sk.total_stock_quantity, 0) as total_stock_quantity,
    coalesce(sk.total_stock_value, 0) as total_stock_value,
    coalesce(v.total_store_orders, 0) as total_store_orders,
    coalesce(v.total_store_revenue, 0) as total_store_revenue
from stores st
left join stock_by_store sk on st.store_id = sk.store_id
left join sales_by_store v on st.store_id = v.store_id