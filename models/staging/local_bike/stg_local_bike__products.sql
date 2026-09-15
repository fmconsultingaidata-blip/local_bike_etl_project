select
    product_id,
    trim(product_name) as product_name,
    brand_id,
    category_id,
    model_year,
    list_price
from {{ source('local_bike_ae_final_case', 'lb_products') }}