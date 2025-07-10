
with base as (

    select * 
    from {{ ref('stg_shopify_gql__order_shipping_tax_line_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__order_shipping_tax_line_tmp')),
                staging_columns=get_graphql_order_shipping_tax_line_columns()
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
        channel_liable,
        index,
        order_shipping_line_id,
        price_set_pres_amount,
        price_set_pres_currency_code,
        price_set_shop_amount,
        price_set_shop_currency_code,
        rate,
        rate_percentage,
        source,
        title
    from fields
)

select *
from final
