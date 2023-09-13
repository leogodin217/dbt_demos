
{# No unique key means the table will simply append whatever the query produces #}
{# This allows us to easily create duplicates from the command line #}

{{
  config(
    materialized = 'incremental',
    )
}}

{% set execution_date = get_execution_date() %}

select 
    user_id,
    account_id,
    first_name,
    last_name,
    email,
    age,
    username,
    {{ execution_date }} as created_at,
    {{ execution_date }} as updated_at
     
from {{ ref('stg_users') }} as accounts 
where date_added = {{ execution_date }}