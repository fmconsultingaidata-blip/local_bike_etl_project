with order_items as (
    select * from {{ ref('int_order_items') }}
)

select
    order_id,
    customer_id,
    store_id,
    staff_id,
    order_created_at,
    order_required_at,
    order_shipped_at,
    order_status,
    order_status_label,
    count(order_item_id) as total_items_count,
    sum(item_quantity) as total_quantity,
    sum(total_order_item_amount) as total_order_amount,
    date_diff(order_shipped_at, order_created_at, day) as shipping_delay_days
from order_items
group by
    order_id,
    customer_id,
    store_id,
    staff_id,
    order_created_at,
    order_required_at,
    order_shipped_at,
    order_status,
    order_status_label