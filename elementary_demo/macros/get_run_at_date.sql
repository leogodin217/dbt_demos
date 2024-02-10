{# 
    Generates a python date object from the passed in variable run_at_date or defaults to the current date - 1 day.
 #}
{% macro get_run_at_date() %}
    {% set run_at_date_input = var('run_at_date', False) %}

    {% if run_at_date_input %}
        {% set run_at_date = modules.datetime.date.fromisoformat(run_at_date_input) %}
    {% else %}
        {# Get the current timestamp according to the time zone your DAG will run in #}
        {# We use the project variable run_started_at so each model uses the same date. #}
        {% set utc_current_timestamp = run_started_at.astimezone(modules.pytz.utc) %} 
        {% set local_current_timestamp = utc_current_timestamp.astimezone(modules.pytz.timezone('America/Los_Angeles')) %}

        {# Convert to a date using one of the two options. Uncomment the one you want #}

        {#  Actual current date. #}
        {# {% set run_at_date = local_current_timestamp.date %} #}

        {# Yesterday's date is common in ETL/ELT for nightly runs. #}
        {% set run_at_date = local_current_timestamp.date() - modules.datetime.timedelta(days = 1) %} 
    {% endif %}
    {% do return(run_at_date) %}
{% endmacro %}