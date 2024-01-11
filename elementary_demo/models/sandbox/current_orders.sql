{{
  config(
    materialized = 'view',
    )
}}

{% set run_at_date = get_run_at_date() %}

select 
    *
from {{ ref('orders') }}
where order_date = {{ run_at_date }}
