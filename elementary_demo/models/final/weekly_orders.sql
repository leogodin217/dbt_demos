
{{
    config(
        materialized = 'incremental',
        unique_key = ['order_date', 'user_id', 'product_id'],
    )
}}

select 
    date as order_date,
    user_id,
    product_id,
    num_items,
    sum(num_items) over (partition by user_id) as total_weekly_items,
    current_timestamp() as created_at,
    current_timestamp() as updated_at
from {{ get_date_filtered_subquery(
            source_model=ref('stg_orders'), 
            target_model=this, 
            run_at_date=get_run_at_date()) }} 