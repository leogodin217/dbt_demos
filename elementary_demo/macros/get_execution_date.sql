i{% macro get_execution_date() %}

{% if not execute %}{{return('')}}{% endif %}

{% set execution_date = var('execution_date', 'current_date() - 1') %}
{% if 'current_date()' in execution_date %}
    {{ return(execution_date) }}
{% else %}
   {{ return("'" + execution_date + "'") }} 
{% endif %}

{% endmacro %}