{{ config(
    materialized='table'
) }}

select
    order_created_at,
    staff_id,
    store_id,
    store_name,
    staff_last_name,
    is_active_staff,
    category_name,
    product_name,
    count(distinct order_id) as total_orders_handled,
    sum(item_quantity) as total_items_sold,
    sum(total_order_item_amount) as total_revenue_generated,
    safe_divide(sum(total_order_item_amount), count(distinct order_id)) as average_basket_amount,
    avg(discount) as average_discount_given
from {{ ref('int_order_items') }}
group by
    order_created_at,
    is_active_staff,
    category_name,
    product_name,
    staff_id,
    store_id,
    staff_last_name,
    store_name