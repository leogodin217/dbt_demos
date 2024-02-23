{# Get the materialized definition for a model #}
{% macro get_model_materialized(model_name) %}
  {% if not execute %} {{ return('') }} {% endif %}

    {# Get the model definition from the graph #}
    {% set model_defs = graph.nodes.values() | list %} 
    {% set source_defs = graph.sources.values() | list %} 
    {% set all_defs = model_defs + source_defs %}

    {# Get the specific node definition. #}
    {% set model_node = model_defs | selectattr('name', 'equalto', model_name) | list %} 
    
    {% if not model_node %}
        {{ return(None) }}
    {% endif %} 

    {# Get the model's materialization  #}
    {% set model_config = model_node[0].get('config') %}
    {% set model_materialized = model_config.get('materialized') %}
    {{ return(model_materialized) }} 
{% endmacro %}