with orders_summary as (
    select * from {{ ref('int_orders_summary') }}
),

order_items as (
    select * from {{ ref('int_order_items') }}
),

-- On calcule le volume acheté par client et par marque
customer_brand_prefs as (
    select
        o.customer_id,
        oi.brand_id,
        sum(oi.item_quantity) as qty_per_brand,
        row_number() over (
            partition by o.customer_id 
            order by sum(oi.item_quantity) desc
        ) as brand_rank
    from order_items oi
    inner join orders_summary o on oi.order_id = o.order_id
    group by o.customer_id, oi.brand_id
),

-- On calcule le volume acheté par client et par catégorie
customer_category_prefs as (
    select
        o.customer_id,
        oi.category_id,
        sum(oi.item_quantity) as qty_per_category,
        row_number() over (
            partition by o.customer_id 
            order by sum(oi.item_quantity) desc
        ) as category_rank
    from order_items oi
    inner join orders_summary o on oi.order_id = o.order_id
    group by o.customer_id, oi.category_id
),

base_history as (
    select
        customer_id,
        min(order_created_at) as first_order_date,
        max(order_created_at) as last_order_date,
        count(distinct order_id) as total_orders_count,
        sum(total_items_count) as total_items_purchased,
        sum(total_order_amount) as total_orders_spent
    from orders_summary
    group by customer_id
)

select
    bh.customer_id,
    bh.first_order_date,
    bh.last_order_date,
    bh.total_orders_count,
    bh.total_items_purchased,
    bh.total_orders_spent,
    cb.brand_id as top_brand_id,
    cc.category_id as top_category_id
from base_history bh
left join customer_brand_prefs cb 
    on bh.customer_id = cb.customer_id 
   and cb.brand_rank = 1
left join customer_category_prefs cc 
    on bh.customer_id = cc.customer_id 
   and cc.category_rank = 1