
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
        processed_at,
        _fivetran_synced,

    from fields
    where not coalesce(test, false)
)

select *
from final
