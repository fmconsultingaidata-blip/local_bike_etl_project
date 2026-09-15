{{ config(
    materialized='table'
) }}

select
    staff_id,
    store_id,
    count(distinct order_id) as total_orders_handled,
    sum(item_quantity) as total_items_sold,
    sum(total_order_item_amount) as total_revenue_generated,
    safe_divide(sum(total_order_item_amount), count(distinct order_id)) as average_basket_amount,
    avg(discount) as average_discount_given
from {{ ref('mrt_sales_details_local_bike') }}
group by
    staff_id,
    store_id