{% macro get_model_start_date(run_at_date, date_logic='run_at_day') %}
    {% if not execute %} {{ return('') }} {% endif %}
    {# 
        This is like a Python import statement. Makes calling these functions 
        shorter. 
    #}
    {% set date = modules.datetime.date %}
    {% set timedelta = modules.datetime.timedelta %}
    {# Define any date logics used by your company  #}
    
    {% if date_logic == 'all' %}
        {% set start_date = None %}

    {% elif date_logic == 'run_at_day' %}
        {% set start_date = run_at_date %}

    {% elif date_logic == 'run_at_week' %}
        {# Get the beginning of the week. #}
        {% set weekday = run_at_date.weekday() %}

        {# This works for ISO weeks starting on Monday #}
        {# {% set start_date = run_at_date - timedelta(days = weekday) %} #}

        {# Our weeks start on Sunday, so different logic is needed. #}
        {% if weekday == 6 %}
            {# It's a sunday. That's the start of the week. #}
            {% set start_date = run_at_date %} 
        {% else %}
            {# One day earlier than the ISO date. #}
            {% set start_date = run_at_date - timedelta(days=weekday + 1) %}
        {% endif %}

    {% elif date_logic == 'run_at_month' %}
         {# Build a date using year and month from execution date  #}
        {% set start_date = date(run_at_date.year, run_at_date.month, 1) %}

    {% else %}
        {{ exceptions.raise_compiler_error(
            'get_start_dates: Invalid date logic: ' + date_logic) }}
    {% endif %}

    {% set model_start_date  = start_date.strftime('%Y-%m-%d') %}
    {% do return(model_start_date) %}
{% endmacro %}