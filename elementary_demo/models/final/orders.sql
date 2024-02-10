
{# No unique key means the table will simply append whatever the query produces #}
{# This allows us to easily create duplicates from the command line #}

{{
  config(
    materialized = 'incremental',
    )
}}

{% if execute %} -- Prevent this from running before the model is compiled

  {# Get the meta config for this model #}
  {% set meta = get_model_meta(this.name) %}
  {{ log(this | string + meta | string, info=true)}} {# For demonstration purposes #}
  {% set date_logic = meta['date_logic'] %}

  {# Get the start and end dates used to update this model #}
  {% set run_at_date = get_run_at_date() %} 
  {% set start_date = get_model_start_date(run_at_date, date_logic) %}
  {% set end_date = get_model_end_date(run_at_date, date_logic) %} 

{% endif %}

select 
    date as order_date,
    user_id,
    product_id,
    num_items,
    current_timestamp() as created_at,
    current_timestamp() as updated_at
from {{ ref('stg_orders') }} as orders 
where date between '{{ start_date }}' and '{{ end_date }}' 