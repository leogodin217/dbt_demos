{% test duplicate_accounts(model, column_name) %}

    select 
        account_id,
        company_name,
        created_at,
        updated_at
    from {{ model }}
    qualify count(account_id) over (partition by account_id) > 1
    order by account_id, updated_at 
{% endtest %}