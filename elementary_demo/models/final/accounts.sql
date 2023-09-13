
{# No unique key means the table will simply append whatever the query produces #}
{# This allows us to easily create duplicates from the command line #}

{{
  config(
    materialized = 'incremental',
    )
}}

{% set execution_date = get_execution_date() %}

select 
    account_id,
    company_name,
    company_slogan,
    company_mission,
    {{ execution_date }} as created_at,
    {{ execution_date }} as updated_at
     
from {{ ref('stg_companies') }} 
where date_added = {{ execution_date }} 