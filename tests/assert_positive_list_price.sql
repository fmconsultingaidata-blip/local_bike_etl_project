-- tests/assert_positive_list_price.sql

select
    order_item_id,
    order_id,
    list_price
from {{ ref('stg_local_bike__order_items') }}
where list_price <= 0 
   or list_price is null