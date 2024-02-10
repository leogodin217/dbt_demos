{% test expression_is_true(model, expression, where_clause) %}

    {% if not execute %} {{ return('') }} {% endif %}
    {% set meta = get_model_meta(model.name) %} 
    {{ log(meta, info=true)}}
    {% set columns = meta['uniqueness'] %} 
    {% set date_column = meta['date_column'] %}
    {% set date_logic = meta['date_logic'] %}

    {# Get the start and end dates used to query the source model #}
    {% set run_at_date = get_run_at_date() %} 
    {% set start_date = get_model_start_date(run_at_date, date_logic) %}
    {% set end_date = get_model_end_date(run_at_date, date_logic) %} 

    {# If set to true, we will not filter on dates #}
    {% set test_full_table = var('test_full_table', false) %}

select 
    {{ columns | join(', ')}} 
{# Using this instead of dbt's config.where so we can get the table name #}
from (
    select * from {{ model }}
    where 1 = 1
    {% if where_clause %}
        and  ({{ where_clause }})
    {% endif %}
    {% if not test_full_table %}
        and ({{date_column }} between '{{ start_date }}' and '{{ end_date }}')
    {% endif %}  
) as subquery
where not ({{ expression }})

{% endtest %}
