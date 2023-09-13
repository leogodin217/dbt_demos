
{# No unique key means the table will simply append whatever the query produces #}
{# This allows us to easily create duplicates from the command line #}

{{
  config(
    materialized = 'incremental',
    )
}}

{% set execution_date = get_execution_date() %}

select 
    product_id,
    category,
    name,
    price,
    {{ execution_date }} as created_at,
    {{ execution_date }} as updated_at
     
from {{ ref('stg_products') }} as products 
where date_added = {{ execution_date }}