{{ config(enabled=var('shopify_api', 'rest') == var('shopify_api_override','graphql')) }}

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
        id as transaction_id,
        order_id,
        refund_id,
        {# amount is split out #}
        amount_set_pres_amount as amount_pres,
        amount_set_shop_amount as amount_shop,
        {# no device_id rn #}
        gateway,
        {# no source_name - join from order #}
        {# no message #}
        amount_set_pres_currency_code as amount_pres_currency_code,
        amount_set_shop_currency_code as amount_shop_currency_code,
        {# no location_id - join in from order #}
        parent_id,
        payment_avs_result_code,
        payment_credit_card_bin,
        payment_cvv_result_code,
        payment_credit_card_number,
        payment_credit_card_company,
        lower(kind) as kind, -- lower in REST api
        {{ shopify_source.json_to_string("receipt_json", source_columns_in_relation) }} as receipt,
        {# no currency_exchange_ fields rn #}
        error_code,
        lower(status) as status, -- lower in REST api
        staff_member_id as user_id,
        authorization_code,
        {{ shopify_source.fivetran_convert_timezone(column='cast(created_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as created_timestamp,
        {{ shopify_source.fivetran_convert_timezone(column='cast(processed_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as processed_timestamp,
        {{ shopify_source.fivetran_convert_timezone(column='cast(authorization_expires_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as authorization_expires_at,
        {{ shopify_source.fivetran_convert_timezone(column='cast(_fivetran_synced as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as _fivetran_synced,
        source_relation

        {{ fivetran_utils.fill_pass_through_columns('transaction_pass_through_columns') }}

        {# TODO - remove these fields from here + macro
        account_number,
        amount_rounding_set_pres_amount,
        amount_rounding_set_pres_currency_code,
        amount_rounding_set_shop_amount,
        amount_rounding_set_shop_currency_code,
        extended_authorization_expires_at,
        formatted_gateway,
        manual_payment_gateway,
        manually_capturable,
        maximum_refundable_amount,
        maximum_refundable_currency_code,
        multi_capturable,
        payment_credit_card_expiration_month,
        payment_credit_card_expiration_year,
        payment_credit_card_name,
        payment_credit_card_wallet,
        payment_descriptor,
        payment_icon_alt_text,
        payment_icon_height,
        payment_icon_id,
        payment_icon_url,
        payment_icon_width,
        payment_id,
        payment_method_name,
        receipt_json,
        refund_set_acquirer_reference_number,
        settlement_currency,
        settlement_currency_rate,
        standard_authorization_expires_at,
        total_unsettled_set_pres_amount,
        total_unsettled_set_pres_currency_code,
        total_unsettled_set_shop_amount,
        total_unsettled_set_shop_currency_code #}

    from fields
    where not coalesce(test, false)
)

select *
from final
