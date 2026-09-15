select
    order_id,
    customer_id,
    order_status,
    order_date as order_created_at,
    required_date as order_required_at,
    SAFE_CAST(shipped_date as date) as order_shipped_at,
    store_id,
    staff_id
from {{ source('local_bike_ae_final_case', 'lb_orders') }}