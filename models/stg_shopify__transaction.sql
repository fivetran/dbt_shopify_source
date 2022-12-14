with base as (

    select * from {{ ref('stg_shopify__transaction_tmp') }}

),

fields as (

    select

        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__transaction_tmp')),
                staging_columns=get_transaction_columns()
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
        refund_id,
        amount,
        created_at,
        processed_at,
        device_id,
        gateway,
        source_name,
        message,
        currency,
        location_id,
        parent_id,
        payment_avs_result_code,
        payment_credit_card_bin,
        payment_cvv_result_code,
        payment_credit_card_number,
        payment_credit_card_company,
        kind,
        receipt,
        currency_exchange_id,
        currency_exchange_adjustment,
        currency_exchange_original_amount,
        currency_exchange_final_amount,
        currency_exchange_currency,
        error_code,
        status,
        user_id,
        _fivetran_synced,
        authorization_expires_at,
        authorization_code,
        source_relation

        {{ fivetran_utils.fill_pass_through_columns('transaction_pass_through_columns') }}

    from fields
    where not coalesce(test, false)
)

select * 
from final