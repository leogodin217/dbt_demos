
{# Acts like an import statement #}
{% set python_date = modules.datetime.date.fromisoformat %}

-- run_at_day: Simply returns the python date as a string
select 
    'run_at_day' as test_case,
    '2023-12-05' as run_at_date,
    '2023-12-05' as expected_date,
    '{{ get_model_start_date(python_date('2023-12-05'), date_logic='run_at_day') }}' as actual_date 

union all 

-- run_at_week: Get the Sunday that begins the week 
select 
    'run_at_week_start' as test_case,
    '2023-12-17' as run_at_date,
    '2023-12-17' as expected_date,
    '{{ get_model_start_date(python_date('2023-12-17'), date_logic='run_at_week') }}' as actual_date 

union all  

select 
    'run_at_week_middle' as test_case,
    '2023-12-21' as run_at_date,
    '2023-12-17' as expected_date,
    '{{ get_model_start_date(python_date('2023-12-21'), date_logic='run_at_week') }}' as actual_date 

union all 

select 
    'run_at_week_end' as test_case,
    '2023-12-23' as run_at_date,
    '2023-12-17' as expected_date,
    '{{ get_model_start_date(python_date('2023-12-23'), date_logic='run_at_week') }}' as actual_date 

union all 

-- run_at_iso_week: Get the Monday that begins our work week using iso week start and end 
select 
    'run_at_iso_week_start' as test_case,
    '2023-12-18' as run_at_date,
    '2023-12-17' as expected_date,
    '{{ get_model_start_date(python_date('2023-12-18'), date_logic='run_at_week') }}' as actual_date 

union all 
-- run_at_month: Should always return the first day of the month
 select 
    'run_at_month_start' as test_case,
    '2023-12-01' as run_at_date,
    '2023-12-01' as expected_date,
    '{{ get_model_start_date(python_date('2023-12-01'), date_logic='run_at_month') }}' as actual_date 

union all 

select 
    'run_at_month_middle' as test_case,
    '2023-12-15' as run_at_date,
    '2023-12-01' as expected_date,
    '{{ get_model_start_date(python_date('2023-12-15'), date_logic='run_at_month') }}' as actual_date 

union all 

select 
    'run_at_month_end' as test_case,
    '2023-12-31' as run_at_date,
    '2023-12-01' as expected_date,
    '{{ get_model_start_date(python_date('2023-12-31'), date_logic='run_at_month') }}' as actual_date 
