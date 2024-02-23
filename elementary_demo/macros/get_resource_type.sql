{% macro get_resource_type(resource_name) %}
    {% if not execute %} {{ return('') }} {% endif %}

    {# Get all nodes and sources from the graph #}
    {% set resource_defs = graph.nodes.values() | list %} 
    {% set source_defs = graph.sources.values() | list %} 
    {% set all_defs = resource_defs + source_defs %}

    {# Get the specific node definition. #}
    {% set resource_node = resource_defs | selectattr('name', 'equalto', resource_name) | list %} 
    
    {% if not resource_node %}
        {{ return(None) }}
    {% endif %} 

    {# Get the resource's type  #}
    {% set resource_type = resource_node[0].get('resource_type') %}
    {{ return(resource_type) }} 
{% endmacro %}