{{ config(enabled=var('shopify_api', 'rest') == var('shopify_api_override','graphql')) }}

with base as (

    select * 
    from {{ ref('stg_shopify_gql__order_line_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__order_line_tmp')),
                staging_columns=get_graphql_order_line_columns()
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
        id as order_line_id,
        {# recreating this, though it may not be exact #}
        row_number() over(partition by order_id, source_relation order by id asc) as index,
        name,
        order_id,
        unfulfilled_quantity as fulfillable_quantity, -- actually maybe use fulfillment_line_item.remaining_quantity? https://shopify.dev/docs/api/admin-graphql/latest/objects/LineItem#field-LineItem.fields.fulfillableQuantity
        case 
            when unfulfilled_quantity = 0 then 'fulfilled'
            when unfulfilled_quantity > 0 and unfulfilled_quantity < quantity then 'partial'
            when unfulfilled_quantity = quantity then 'unfulfilled'
            else null 
        end as fulfillment_status,
        is_gift_card,
        {# no grams - maybe join in fulfillment_order_line_item.weight and weight_unit #}
        {# pre_tax has been removed #}
        {# price has been split #}
        original_total_set_pres_amount as price_pres_amount,
        original_total_set_pres_currency_code as price_pres_currency_code,
        original_total_set_shop_amount as price_shop_amount,
        original_total_set_shop_currency_code as price_shop_currency_code,
        product_id,
        quantity,
        requires_shipping as is_shipping_required,
        sku,
        taxable as is_taxable,
        {# no tax code - join in product_variant.tax_code #}
        title,
        {# total_discount is broken out #}
        total_discount_set_pres_amount as total_discount_pres_amount,
        total_discount_set_pres_currency_code as total_discount_pres_currency_code,
        total_discount_set_shop_amount as total_discount_shop_amount,
        total_discount_set_shop_currency_code as total_discount_shop_currency_code,
        variant_id,
        variant_title,
        {# variant_inventory_management is deprecated #}
        vendor,
        {# no properties #}
        {{ shopify_source.fivetran_convert_timezone(column='cast(_fivetran_synced as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as _fivetran_synced,
        source_relation
        
    {{ fivetran_utils.fill_pass_through_columns('order_line_pass_through_columns') }}

    from fields
)

select *
from final
