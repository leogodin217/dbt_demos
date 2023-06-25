{% if execute %}
  {{ log("***** Hey, we're executing here! *****", info=true) }}
{% else %}
  {{ log("***** Just hanging out, building the dag *****", info=true )}}
{% endif %}

select
    *
from {{ ref('no_log_message') }} 