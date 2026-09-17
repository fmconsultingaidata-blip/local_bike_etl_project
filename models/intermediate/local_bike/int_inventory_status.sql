with stocks as (
    select * from {{ ref('stg_local_bike__stocks') }}
),

products as (
    select 
        product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        list_price
    from {{ ref('stg_local_bike__products') }}
),

stores as (
    select 
        store_id,
        store_name,
        store_city,
        store_state
    from {{ ref('stg_local_bike__stores') }}
)

, categories as (
    select 
        category_id,
        category_name
    from {{ ref('stg_local_bike__categories') }}
)

select
    s.stock_id,
    s.store_id,
    st.store_name,
    st.store_city,
    st.store_state,
    s.product_id,
    p.product_name,
    p.brand_id,
    p.category_id,
    ct.category_name,
    p.model_year,
    p.list_price,
    s.stock_quantity,
    (s.stock_quantity * p.list_price) as stock_total_value
from stocks s
left join products p on s.product_id = p.product_id
left join stores st on s.store_id = st.store_id
left join categories ct on p.category_id = ct.category_id