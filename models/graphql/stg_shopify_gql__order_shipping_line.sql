{{ config(enabled=var('shopify_api', 'rest') == var('shopify_api_override','graphql')) }}

with base as (

    select * 
    from {{ ref('stg_shopify_gql__order_shipping_line_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__order_shipping_line_tmp')),
                staging_columns=get_graphql_order_shipping_line_columns()
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
        id as order_shipping_line_id,
        order_id,
        carrier_identifier,
        code,
        delivery_category,
        {# discounted_price and _set are broken out #}
        discounted_price_set_pres_amount,
        discounted_price_set_pres_currency_code,
        discounted_price_set_shop_amount,
        discounted_price_set_shop_currency_code,
        phone,
        {# price and price_set are broken out #}
        original_price_set_pres_amount as price_set_pres_amount,
        original_price_set_pres_currency_code as price_set_pres_currency_code,
        original_price_set_shop_amount as price_set_shop_amount,
        original_price_set_shop_currency_code as price_set_shop_currency_code,
        {# requested_fulfillment_service_id is no longer used in Shopify #}
        source,
        title,
        {{ shopify_source.fivetran_convert_timezone(column='cast(_fivetran_synced as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as _fivetran_synced,
        source_relation

        {# REMOVE
        current_discounted_price_set_pres_amount,
        current_discounted_price_set_pres_currency_code,
        current_discounted_price_set_shop_amount,
        current_discounted_price_set_shop_currency_code,
        custom,
        is_removed,
        shipping_rate_handle #}


    from fields
)

select *
from final
