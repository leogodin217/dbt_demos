from datetime import date
from datetime.datetime import timedelta 

sql_template = '''
    select 
        {{ test_case }} as test_case,
        {{ run_at_date }} as run_at_date,
        {{ expected_date }} as expected_date,
        {{ actual_date }} as actual_date
'''

yaml_template = '''
    version: 2

    models:
      - name: validate_get_start_date_python
        tests:
          {{ tests }} 
'''

test_yaml_template = '''
            - expression_is_true:
                name: {{ name }} 
                expression: {{ expression }} 
                where_clause: {{ where_clause }}
'''

# Days