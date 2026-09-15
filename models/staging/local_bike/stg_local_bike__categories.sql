select
    category_id,
    TRIM(category_name) as category_name
from {{ source('local_bike_ae_final_case', 'lb_categories') }}