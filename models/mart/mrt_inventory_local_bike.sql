{{ config(
    materialized='table'
) }}

select
    stock_id,
    store_id,
    store_name,
    store_city,
    store_state,
    product_id,
    product_name,
    brand_id,
    category_id,
    model_year,
    list_price,
    stock_quantity,
    stock_total_value
from {{ ref('int_inventory_status') }}