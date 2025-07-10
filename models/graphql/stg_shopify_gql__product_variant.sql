
with base as (

    select * 
    from {{ ref('stg_shopify_gql__product_variant_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__product_variant_tmp')),
                staging_columns=get_graphql_product_variant_columns()
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
        available_for_sale,
        barcode,
        compare_at_price,
        created_at,
        display_name,
        id as product_variant_id,
        image_id,
        inventory_item_id,
        inventory_policy,
        inventory_quantity,
        legacy_resource_id,
        metafield,
        position,
        price,
        product_id,
        requires_components,
        sellable_online_quantity,
        sku,
        tax_code,
        taxable,
        title,
        updated_at
    from fields
)

select *
from final
