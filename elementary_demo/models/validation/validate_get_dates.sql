{% if execute %}
    {% set python_date = modules.datetime.date.fromisoformat %}
    {% set run_at_date = var('run_at_date') %}
    {% set test_case = var('test_case') %}
    {% set expected_date = var('expected_date') %}
    {% set date_logic = var('date_logic') %}

    select 
        '{{ test_case }}' as test_case,
        '{{ run_at_date }}' as run_at_date,
        '{{ expected_date }}' as expected_date,
        '{{ get_model_start_date(python_date(run_at_date), date_logic=date_logic) }}' as actual_start_date,
        '{{ get_model_end_date(python_date(run_at_date), date_logic=date_logic) }}' as actual_end_date 
{% endif %}


