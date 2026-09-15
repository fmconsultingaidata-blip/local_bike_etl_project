select
    CONCAT(store_id, '_', product_id) AS stock_id,
    store_id,
    product_id,
    quantity as stock_quantity
from {{ source('local_bike_ae_final_case', 'lb_stocks') }}