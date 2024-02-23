{# 
    Generates a python date object from the passed in variable run_at_date or defaults to the current date - 1 day.
 #}
{% macro get_run_at_date() %}

    {# Acts like a python import. This shortens the lines and makes it more
       readable on blogs. Use this as you want. #}
    {% set python_date = modules.datetime.date.fromisoformat %}
    {% set time_delta =  modules.datetime.timedelta %}
    {% set utc = modules.pytz.utc %}
    {% set los_angeles = modules.pytz.timezone('America/Los_Angeles') %}

    {% set run_at_date_input = var('run_at_date', False) %}

    {% if run_at_date_input %}
        {% set run_at_date = python_date(run_at_date_input) %}
    {% else %}
        {# Get the current timestamp according to the time zone your DAG will run in #}
        {% set utc_timestamp = run_started_at.astimezone(utc) %} 
        {% set local_timestamp = utc_timestamp.astimezone(los_angeles) %}

        {# Convert to a date using one of the two options. Uncomment the one you want #}

        {#  Actual current date. #}
        {# {% set run_at_date = local_current_timestamp.date %} #}

        {# Yesterday's date is common in ETL/ELT for nightly runs. #}
        {% set run_at_date = (local_timestamp.date() - time_delta(days = 1)) %} 
    {% endif %}
    {% do return(run_at_date) %}
{% endmacro %}