
{# No unique key means the table will simply append whatever the query produces #}
{# This allows us to easily create duplicates from the command line #}

{{
  config(
    materialized = 'incremental',
    )
}}

{% set run_at_date = get_run_at_date() %}

select 
    date as order_date,
    user_id,
    product_id,
    num_items,
    {{ run_at_date }} as created_at,
    {{ run_at_date }} as updated_at
     
from {{ ref('stg_orders') }} as orders 
where date = {{ run_at_date }}