
{{
  config(
    materialized = 'incremental',
    )
}}

select 
    date as order_date,
    user_id,
    product_id,
    num_items,
    current_timestamp() as created_at,
    current_timestamp() as updated_at
from {{ get_date_filtered_subquery(source_model = ref('stg_orders'), target_model = this) }}