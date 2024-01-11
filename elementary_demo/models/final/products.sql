
{# No unique key means the table will simply append whatever the query produces #}
{# This allows us to easily create duplicates from the command line #}

{{
  config(
    materialized = 'incremental',
    )
}}

{% set run_at_date = get_run_at_date() %}

select 
    product_id,
    category,
    name,
    price,
    {{ run_at_date }} as created_at,
    {{ run_at_date }} as updated_at
     
from {{ ref('stg_products') }} as products 
where date_added = {{ run_at_date }}