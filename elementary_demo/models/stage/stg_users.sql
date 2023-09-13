select
    id as user_id,
    company_id as account_id,
    first_name,
    last_name,
    email,
    age,
    username,
    date_added
from {{ source('production', 'employees_base') }}
  