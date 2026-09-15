{{ config(
    materialized='table'
) }}

with customers as (
    select * from {{ ref('stg_local_bike__customers') }}
),

customer_purchases as (
    select * from {{ ref('int_customer_purchases_history') }}
)

select
    c.customer_id,
    c.customer_first_name,
    c.customer_last_name,
    c.customer_phone,
    c.customer_email,
    c.customer_street,
    c.customer_city,
    c.customer_state,
    c.customer_zip_code,
    cp.first_order_date as first_order_date,
    cp.last_order_date as last_order_date,
    coalesce(cp.total_orders_count, 0) as total_orders_count,
    coalesce(cp.total_items_purchased, 0) as total_items_purchased,
    coalesce(cp.total_orders_spent, 0) as total_orders_spent,
    case
        when cp.total_orders_count is null or cp.total_orders_count = 0 then 'Prospect'
        when cp.last_order_date >= date_sub(current_date(), interval 1 year) then 'Active'
        else 'Churned'
    end as customer_status
from customers c
left join customer_purchases cp on c.customer_id = cp.customer_id