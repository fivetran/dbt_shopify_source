
with base as (

    select * 
    from {{ ref('stg_shopify_gql__order_line_refund_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__order_line_refund_tmp')),
                staging_columns=get_graphql_order_line_refund_columns()
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
        id as order_line_refund_id,
        location_id,
        order_line_id,
        price_set_pres_amount,
        price_set_pres_currency_code,
        price_set_shop_amount,
        price_set_shop_currency_code,
        quantity,
        refund_id,
        restock_type,
        restocked,
        subtotal_set_pres_amount,
        subtotal_set_pres_currency_code,
        subtotal_set_shop_amount,
        subtotal_set_shop_currency_code,
        total_tax_set_pres_amount,
        total_tax_set_pres_currency_code,
        total_tax_set_shop_amount,
        total_tax_set_shop_currency_code
    from fields
)

select *
from final
