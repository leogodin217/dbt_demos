select 
    id as product_id,
    category,
    name,
    price,
    date_added 
from {{ source('production', 'products_base') }}
  