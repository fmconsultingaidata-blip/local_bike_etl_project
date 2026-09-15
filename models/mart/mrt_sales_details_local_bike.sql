{{ config(
    materialized='table'
) }}

select
    order_item_id,
    order_id,
    customer_id,
    store_id,
    staff_id,
    order_created_at,
    order_status,
    order_required_at,
    order_shipped_at,
    order_status_label,
    product_id,
    product_name,
    brand_id,
    category_id,
    model_year,
    item_quantity,
    list_price,
    discount,
    total_order_item_amount
from {{ ref('int_order_items') }}