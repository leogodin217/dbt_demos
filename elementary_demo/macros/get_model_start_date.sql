{% macro get_model_start_date(run_at_date, date_logic='run_at_day') %}

    {# This is like a Python import statement. Makes calling these functions shorter. #}
    {% set date = modules.datetime.date %}
    {% set timedelta = modules.datetime.timedelta %}

    {# Define any date logics used by your company  #}

    {% if date_logic == 'run_at_day' %}
        {% set start_date = run_at_date %}

    {% elif date_logic == 'run_at_week' %}
        {# Get the beginning of the week, which is always Sunday #}
        {# ISO weeks start on Monday, so we need to go back one more day #} 
        {% set start_date = run_at_date - timedelta(days = run_at_date.weekday() + 1) %}

    {% elif date_logic == 'run_at_month' %}
         {# Build a date using year and month from execution date  #}
        {% set start_date = date(run_at_date.year, run_at_date.month, 1) %}

    {% else %}
        {{ exceptions.raise_compiler_error('get_start_dates: Invalid date logic: ' + date_logic) }}
    {% endif %}

    {% set model_start_date  = "'" + start_date.strftime('%Y-%m-%d') + "'" %}
    {% do return(model_start_date) %}
{% endmacro %}