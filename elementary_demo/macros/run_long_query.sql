{% macro run_long_query() %}

    {# Example 1 #}
    {% if not execute %} {{ return(none) }} {% endif %}

     {# Example 2  #}
    {% if not execute %}
        return(none)
    {% endif %}

     {# Code starts here  #}

    {% set sql %}
        select 
            count(*) as num_rows
        from {{ ref('orders')}}
    {% endset %}

    {% set result = run_query(sql) %}

    {% set num_rows = result.rows[0].values()[0] %}

    {{ log('Num rows: ' + num_rows | string) }}
    {{ return(num_rows)}}

{% endmacro %}