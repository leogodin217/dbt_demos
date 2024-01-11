{# Gets the meta dict from the graph for a specific model #}
{% macro get_model_meta(model_name) %}
    
    {% if not execute %} {{ return('') }} {% endif %}

    {# Get the model definition from the graph #}
    {% set model_defs = graph.nodes.values() %} 

    {% set model_node = model_defs | selectattr('name', 'equalto', model_name) | list %} 

    {% if not model_node %}
        {{ return(None) }}
    {% endif %} 

    {# Get the meta configuration  #}
    {% set model_config = model_node[0].get('config') %}
    {% set model_meta = model_config.meta['model_meta'] %}
    {{ return(model_meta) }}
    

{% endmacro %}