{{ config(
    materialized='table'
) }}

select
    staff_id,
    store_id,
    staff_last_name,
    count(distinct order_id) as total_orders_handled,
    sum(item_quantity) as total_items_sold,
    sum(total_order_item_amount) as total_revenue_generated,
    safe_divide(sum(total_order_item_amount), count(distinct order_id)) as average_basket_amount,
    avg(discount) as average_discount_given
from {{ ref('int_order_items') }}
group by
    staff_id,
    store_id,
    staff_last_name