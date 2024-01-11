{% test expression_is_true(model, expression, where_clause) %}
    {% set meta = get_model_meta(model.name) %} 

    {% if meta %}
        {% set columns = meta['uniqueness']%} 
    {% else %}
         {# Default if no model meta is defined  #}
        {% set columns = ['1'] %}
    {% endif %}

select 
    {{ columns | join(', ')}} 
{# Using this instead of dbt's config.where so we can get the table name #}
from (
    select * from {{ model }}
    {% if where_clause %}
        where {{ where_clause }}
    {% endif %}
) as subquery
where not ({{ expression }})

{% endtest %}
