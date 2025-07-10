
with base as (

    select * 
    from {{ ref('stg_shopify_gql__tender_transaction_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__tender_transaction_tmp')),
                staging_columns=get_graphql_tender_transaction_columns()
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
        source_relation, 
        _fivetran_synced,
        amount,
        currency_code,
        id as tender_transaction_id,
        order_id,
        payment_method,
        processed_at,
        remote_reference,
        test,
        transaction_details_credit_card_company,
        transaction_details_credit_card_number,
        user_id
    from fields
)

select *
from final
