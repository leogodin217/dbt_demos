select 
    id as account_id,
    name as company_name,
    slogan as company_slogan,
    purpose as company_mission,
    date_added
from {{ source('production', 'companies_base') }}