select
    customer_id,
    trim(first_name) as customer_first_name,
    trim(last_name) as customer_last_name,
    trim(phone) as customer_phone,
    lower(email) as customer_email,
    trim(street) as customer_street,
    trim(city) as customer_city,
    trim(state) as customer_state,
    safe_cast(zip_code as string) as customer_zip_code
from {{ source('local_bike_ae_final_case', 'lb_customers') }}