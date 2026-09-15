with order_items as (
    select * from {{ ref('stg_local_bike__order_items') }}
),

orders as (
    select 
        order_id,
        customer_id,
        order_status,
        case order_status
            when 1 then 'Pending'
            when 2 then 'Processing'
            when 3 then 'Rejected'
            when 4 then 'Completed'
            else 'Unknown'
        end as order_status_label,
        order_created_at,
        order_required_at,
        order_shipped_at,
        store_id,
        staff_id
    from {{ ref('stg_local_bike__orders') }}
),

products as (
    select 
        product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        list_price as product_base_price
    from {{ ref('stg_local_bike__products') }}
)

select
    oi.order_item_id,
    oi.order_id,
    o.customer_id,
    o.store_id,
    o.staff_id,
    o.order_created_at,
    o.order_status,
    o.order_required_at,
    o.order_shipped_at,
    o.order_status_label,
    oi.product_id,
    p.product_name,
    p.brand_id,
    p.category_id,
    p.model_year,
    oi.item_quantity,
    oi.list_price,
    oi.discount,
    oi.total_order_item_amount
from {{ ref('stg_local_bike__order_items') }} oi
left join orders o on oi.order_id = o.order_id
left join products p on oi.product_id = p.product_id