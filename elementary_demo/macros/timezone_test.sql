{% macro timezone_test() %}

    {% set dt = modules.datetime.datetime(2002, 10, 27, 6, 0, 0) %}
    {% set dt_local = modules.pytz.timezone('US/Eastern').localize(dt) %}
    {{ log(dt_local | string, info=true)}}
{% endmacro %}