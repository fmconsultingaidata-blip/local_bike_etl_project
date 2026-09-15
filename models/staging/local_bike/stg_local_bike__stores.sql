select
    store_id,
    trim(store_name) as store_name,
    trim(phone) as store_phone,
    lower(email) as store_email,
    trim(street) as store_street,
    trim(city) as store_city,
    trim(state) as store_state,
    safe_cast(zip_code as string) as store_zip_code
from {{ source('local_bike_ae_final_case', 'lb_stores') }}