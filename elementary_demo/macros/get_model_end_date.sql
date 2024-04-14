{% macro get_model_end_date(run_at_date, date_logic='execution_day') %}


    {# 1. Make our life easier by setting variables for the Python classes. #}
    {% set date = modules.datetime.date %}
    {% set timedelta = modules.datetime.timedelta %}

    {# Define any date logics used by your company  #}
    {% if date_logic == 'all' %}
        {% set end_date = None %}

    {% elif date_logic == 'run_at_day' %}
        {% set end_date = run_at_date %}

    {% elif date_logic == 'run_at_week' %}
        {% set week_day = run_at_date.weekday() %}

        {# This would work for ISO weeks that start on Monday #}
        {# {% set end_date = run_at_date + timedelta(days=6 - weekday) %} #}

        {% if week_day == 6 %}
            {# The beginning of the week. A Sunday.#}
            {% set end_date = run_at_date + timedelta(days=6) %}
        {% else %}
            {% set end_date = run_at_date + timedelta(days=5 - week_day) %}
        {% endif %}

    {% elif date_logic == 'run_at_month' %}
        {# Thanks to https://pynative.com/python-get-last-day-of-month/ #}
        {% set current_month = date(
            run_at_date.year, run_at_date.month, 28) %}
        {% set next_month = current_month + timedelta(days=4) %}
        {% set end_date = next_month - timedelta(next_month.day) %}

    {% else %}
        {{ exceptions.raise_compiler_error(
            'get_model_end_date: Invalid date logic: ' + date_logic) }}
    {% endif %}

    {% set model_end_date  = end_date.strftime('%Y-%m-%d') %}
    {% do return(model_end_date) %}
{% endmacro %}