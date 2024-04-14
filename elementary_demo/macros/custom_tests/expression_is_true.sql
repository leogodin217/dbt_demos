{% test expression_is_true(model, expression, where_clause) %}

    {% if not execute %} {{ return('') }} {% endif %}

    {# 1. Get uniqueness columns from the model's meta #}
    {% set meta = get_resource_meta(model.name) %}
    {% set model_meta = meta['model_meta'] %}
    {% set uniqueness_columns = model_meta['uniqueness'] %} 

    {# 2. Selecting uniqueness columns allows us to identify failed rows #}
    {# We can add other columns as needed for a specific test. #}
    select 
        {{ uniqueness_columns | join(', ') }},
        '{{ expression }}' as expression,
        {{ expression }} as result 

    {# 3. Use a macro to automatically filter on dates #}
    from {{ get_date_filtered_test_subquery(model, get_run_at_date()) }}
    where not ({{ expression }})
    
    {# 4. Add the configured where clause if one exists #}
    {% if where_clause %}
        and  ({{ where_clause }})
    {% endif %}

{% endtest %}
