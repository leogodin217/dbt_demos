{# Generates a string to be be used in date logic #}
{% macro get_run_at_date() %}

    {% if not execute %}{{return('')}}{% endif %}

    {# Use your default date here. current_date() - 1 is common in nightly runs #}
    {% set run_at_date = var('run_at_date', 'current_date() - 1') %}
    
    {% if 'current_date()' in run_at_date %}
        {{ log(run_at_date, info=true) }} {# For demonstration purposes #}
        {{ return(run_at_date) }}
    {% else %}

    {# We use cast here, but it may not be needed in your DW. #}
    {% set run_at_date_string = "cast('" + run_at_date + "' as date)" %} 

    {{ log(run_at_date_string, info=true) }} {# for demonstration purposes #} 

    {{ return(run_at_date_string) }} 
    {% endif %}

{% endmacro %}