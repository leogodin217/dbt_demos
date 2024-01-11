
{# No unique key means the table will simply append whatever the query produces #}
{# This allows us to easily create duplicates from the command line #}

{{
  config(
    materialized = 'incremental',
    )
}}

{% set run_at_date = get_run_at_date() %}

select 
    user_id,
    account_id,
    first_name,
    last_name,
    email,
    age,
    username,
    {{ run_at_date }} as created_at,
    {{ run_at_date }} as updated_at
     
from {{ ref('stg_users') }} as accounts 
where date_added = {{ run_at_date }}