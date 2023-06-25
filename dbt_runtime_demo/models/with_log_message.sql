{{
  config(
    materialized = 'table',
    pre_hook = "{{ log('***** Hello from the pre-hook *****', info=true) }}",
    post_hook = "{{ log('***** Hello from the post-hook *****', info=true) }}",
    )
}}

{{ log('***** Hello from inside the file *****', info=true) }}

select 1 as id