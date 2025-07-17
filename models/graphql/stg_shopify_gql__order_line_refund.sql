{{ config(enabled=var('shopify_api', 'rest') == var('shopify_api_override','graphql')) }}

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
        id as order_line_refund_id,
        location_id,
        order_line_id,
        {# subtotal and subtotal_set are split out #}
        subtotal_set_pres_amount as subtotal_pres_amount,
        subtotal_set_pres_currency_code as subtotal_pres_currency_code,
        subtotal_set_shop_amount as subtotal_shop_amount,
        subtotal_set_shop_currency_code as subtotal_shop_currency_code,
        {# total_tax and total_tax_set are split out #}
        total_tax_set_pres_amount as total_tax_pres_amount,
        total_tax_set_pres_currency_code as total_tax_pres_currency_code,
        total_tax_set_shop_amount as total_tax_shop_amount,
        total_tax_set_shop_currency_code as total_tax_shop_currency_code,
        quantity,
        refund_id,
        lower(restock_type) as restock_type, -- match rest API casing
        {{ shopify_source.fivetran_convert_timezone(column='cast(_fivetran_synced as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as _fivetran_synced,
        source_relation
        
        {# new fields - remove so people can use passthru var
        price_set_pres_amount,
        price_set_pres_currency_code,
        price_set_shop_amount,
        price_set_shop_currency_code,
        restocked #}

        {{ fivetran_utils.fill_pass_through_columns('order_line_refund_pass_through_columns') }}

    from fields
)

select *
from final
