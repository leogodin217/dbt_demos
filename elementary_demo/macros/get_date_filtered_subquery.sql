{% macro get_date_filtered_subquery(source_model, target_model) %}

    {% if not execute %} {{ return('') }} {% endif %}

    {# Get meta config for the source model to get the date column #}
    {% set source_meta = get_model_meta(source_model.name) %}
    {% set date_column = source_meta['date_column'] %}

    {# Get meta config for the parent model to get the date logic #}
    {% set target_meta = get_model_meta(target_model.name) %}
    {% set date_logic = target_meta['date_logic'] %}

    {# Get the start and end dates used to query the source model #}
    {% set run_at_date = get_run_at_date() %} 
    {% set start_date = get_model_start_date(run_at_date, date_logic) %}
    {% set end_date = get_model_end_date(run_at_date, date_logic) %} 

    {% set subquery %}
        (
        select 
            *
        from {{ ref(source_model.name) }}
        where {{ date_column }} between '{{ start_date }}' and '{{ end_date }}'
        ) as {{ source_model.name }}
    {% endset %}

    {{ return(subquery) }} 
{% endmacro %}