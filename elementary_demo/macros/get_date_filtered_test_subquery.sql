{# Uses meta config to generate a date-filtered subquery #}
{% macro get_date_filtered_test_subquery(model, run_at_date) %}

    {% if not execute %} {{ return('') }} {% endif %}

    {# 1. Get meta config for the model #}
    {% set meta = get_resource_meta(model.name) %}
    {% set model_meta = meta['model_meta'] %}
    {% set date_column = model_meta['date_column'] %}
    {% set date_logic = model_meta['date_logic'] %}

    {# 2. See if we need to create a date filter #}
    {% set test_full_table = var('test_full_table', false) %}
    {% set prevent_date_filter = test_full_table or date_logic == 'all' %}

    {# 3. Get the start and end dates used to query the model model #}
    {% if not prevent_date_filter %}
        {% set start_date = get_model_start_date(run_at_date, date_logic) %}
        {% set end_date = get_model_end_date(run_at_date, date_logic) %} 
    {% endif %} 

    {# 4. Generate the subquery #}
    {% set subquery %}
        (
            select 
                *
            from {{ model }}
            {% if not prevent_date_filter %}
                where {{ date_column }} between '{{ start_date }}' and '{{ end_date }}'
            {% endif %}
        ) as {{ model.name }}
    {% endset %}

    {{ return(subquery) }} 
{% endmacro %}