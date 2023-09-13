select 
    date,
    employee_id as user_id,
    product_id,
    num_items 
from {{ source('production', 'enterprise_orders_base') }}
