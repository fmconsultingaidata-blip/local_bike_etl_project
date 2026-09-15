select
    brand_id,
    trim(brand_name) as brand_name
from {{ source('local_bike_ae_final_case', 'lb_brands') }}