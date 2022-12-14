
with base as (

    select * 
    from {{ ref('stg_shopify__tender_transaction_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__tender_transaction_tmp')),
                staging_columns=get_tender_transaction_columns()
            )
        }}

        {{ fivetran_utils.source_relation(
            union_schema_variable='shopify_union_schemas', 
            union_database_variable='shopify_union_databases') 
        }}

    from base
),

final as (
    
    select 
        id as transaction_id,
        order_id,
        amount,
        currency,
        payment_method,
        remote_reference,
        user_id,
        cast(processed_at as {{ dbt.type_timestamp() }}) as processed_at,
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        source_relation

    from fields
    where not coalesce(test, false)
)

select *
from final
