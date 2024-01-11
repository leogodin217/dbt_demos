{% macro generate_columns() %}
    {% if not execute %}
        return('')
    {% endif %}

    {# Defaults to false #}
    {% set info = var('debug', False) %} 

    {# Contrived code to select columns from a table #}
    {% set metrics = [
        'total_sales',
        'yoy_sales',
        'ytd_sales'
    ]%} 

    {% set columns %}
        {% for metric in metrics %}
            {# Control whether we log to console or not #}
            {{ log('Generating ' + metric, info=info) }}
            {{ metric }} {% if not loop.last %},{% endif %}
        {% endfor%} 
    {% endset %}

    {{ return(columns) }}
{% endmacro %}