select
    staff_id,
    trim(first_name) as staff_first_name,
    trim(last_name) as staff_last_name,
    trim(phone) as staff_phone,
    lower(email) as staff_email,
    safe_cast(active as bool) as is_active_staff, 
    store_id,
    safe_cast(manager_id as integer) as manager_id
from {{ source('local_bike_ae_final_case', 'lb_staffs') }}