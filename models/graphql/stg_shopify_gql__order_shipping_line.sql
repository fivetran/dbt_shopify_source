
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
        source_relation, 
        _fivetran_synced,
        carrier_identifier,
        code,
        current_discounted_price_set_pres_amount,
        current_discounted_price_set_pres_currency_code,
        current_discounted_price_set_shop_amount,
        current_discounted_price_set_shop_currency_code,
        custom,
        delivery_category,
        discounted_price_set_pres_amount,
        discounted_price_set_pres_currency_code,
        discounted_price_set_shop_amount,
        discounted_price_set_shop_currency_code,
        id as order_shipping_line_id,
        is_removed,
        order_id,
        original_price_set_pres_amount,
        original_price_set_pres_currency_code,
        original_price_set_shop_amount,
        original_price_set_shop_currency_code,
        phone,
        shipping_rate_handle,
        source,
        title
    from fields
)

select *
from final
