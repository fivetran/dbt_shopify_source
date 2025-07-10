
with base as (

    select * 
    from {{ ref('stg_shopify_gql__transaction_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__transaction_tmp')),
                staging_columns=get_graphql_transaction_columns()
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
        account_number,
        amount_rounding_set_pres_amount,
        amount_rounding_set_pres_currency_code,
        amount_rounding_set_shop_amount,
        amount_rounding_set_shop_currency_code,
        amount_set_pres_amount,
        amount_set_pres_currency_code,
        amount_set_shop_amount,
        amount_set_shop_currency_code,
        authorization_code,
        authorization_expires_at,
        created_at,
        error_code,
        extended_authorization_expires_at,
        formatted_gateway,
        gateway,
        id as transaction_id,
        kind,
        manual_payment_gateway,
        manually_capturable,
        maximum_refundable_amount,
        maximum_refundable_currency_code,
        multi_capturable,
        order_id,
        parent_id,
        payment_avs_result_code,
        payment_credit_card_bin,
        payment_credit_card_company,
        payment_credit_card_expiration_month,
        payment_credit_card_expiration_year,
        payment_credit_card_name,
        payment_credit_card_number,
        payment_credit_card_wallet,
        payment_cvv_result_code,
        payment_descriptor,
        payment_icon_alt_text,
        payment_icon_height,
        payment_icon_id,
        payment_icon_url,
        payment_icon_width,
        payment_id,
        payment_method_name,
        processed_at,
        receipt_json,
        refund_id,
        refund_set_acquirer_reference_number,
        settlement_currency,
        settlement_currency_rate,
        staff_member_id,
        standard_authorization_expires_at,
        status,
        test,
        total_unsettled_set_pres_amount,
        total_unsettled_set_pres_currency_code,
        total_unsettled_set_shop_amount,
        total_unsettled_set_shop_currency_code
    from fields
)

select *
from final
