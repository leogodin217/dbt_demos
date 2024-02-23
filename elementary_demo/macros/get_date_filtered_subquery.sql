{# Uses meta config to generate a date-filtered subquery #}
{% macro get_date_filtered_subquery(source_model, target_model, run_at_date) %}

    {% if not execute %} {{ return('') }} {% endif %}

    {# 1. Get meta config for the source model to get the date column #}
    {% set source_meta = get_resource_meta(source_model.name) %}
    {% set source_model_meta = source_meta['model_meta'] %}
    {% set date_column = source_model_meta['date_column'] %}

    {# Get config for the parent model to get the date logic #}
    {% set target_meta = get_resource_meta(target_model.name) %}
    {% set target_model_meta = target_meta['model_meta']%}
    {% set date_logic = target_model_meta['date_logic'] %}

    {# 2. Check if this is an incremental run on an incremental model #}
    {% set materialized = get_model_materialized(target_model.name) %}
    {% set is_materialized_incremental = materialized == 'incremental' %}
    {% set is_incremental_run = is_incremental() and is_materialized_incremental %}
    {{ log('Is incremental run: ' + is_incremental_run | string, info=true) }}

    {# 3. Get the start and end dates used to query the source model #}
    {% set start_date = get_model_start_date(run_at_date, date_logic) %}
    {% set end_date = get_model_end_date(run_at_date, date_logic) %} 

    {# 4. Generate the subquery #}
    {% set subquery %}
        (
            select 
                *
            from {{ ref(source_model.name) }}
            {# We only want this on incremental models if it is an incremental run #}
            {% if is_incremental_run or not is_materialized_incremental %}
                where {{ date_column }} between '{{ start_date }}' and '{{ end_date }}'
            {% endif %}
        ) as {{ source_model.name }}
    {% endset %}

    {{ return(subquery) }} 
{% endmacro %}