{% macro get_end_date(execution_date, date_logic='execution_day') %}


    {# This is like a Python import statement. Makes calling these functions shorter. #}
    {% set date = modules.datetime.date %}
    {% set timedelta = modules.datetime.timedelta %}

    {# Define any date logics used by your company  #}

    {% if date_logic == 'run_at_day' %}
        {% set end_date = execution_date %}

    {% elif date_logic == 'run_at_week' %}
        {# ISO week ends on Sunday, you can use days=5 - execution_date.weekday() to end on Saturday #}
        {% set end_date = execution_date + timedelta(days = 6 - execution_date.weekday()) %}

    {% elif date_logic == 'run_at_month' %}
        {# Thanks to https://pynative.com/python-get-last-day-of-month/ #}
        {% set current_month = date(execution_date.year, execution_date.month, 28) %}
        {% set next_month = current_month + timedelta(days=4) %}
        {% set end_date = next_month - timedelta(next_month.day) %}

    {% else %}
        {{ exceptions.raise_compiler_error('get_model_end_date: Invalid date logic: ' + date_logic) }}
    {% endif %}

    {% set model_end_date  = "'" + end_date.strftime('%Y-%m-%d') + "'" %}
    {% do return(model_end_date) %}
{% endmacro %}