{% macro get_resource_meta(resource_name) %}
    {% if not execute %} {{ return('') }} {% endif %}

    {# Get the resource definition from the graph #}
    {% set resource_defs = graph.nodes.values() | list %} 
    {% set source_defs = graph.sources.values() | list %} 
    {% set all_defs = resource_defs + source_defs %}

    {# Get the specific resource definition. #}
    {% set resource_node = resource_defs | selectattr('name', 'equalto', resource_name) | list %} 
    
    {% if not resource_node %}
        {{ return(None) }}
    {% endif %} 

    {# Get the meta configuration  #}
    {% set resource_config = resource_node[0].get('config') %}
    {% set resource_meta = resource_config.get('meta') %}
    {{ return(resource_meta) }}
    
{% endmacro %}