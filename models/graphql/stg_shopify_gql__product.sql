
with base as (

    select * 
    from {{ ref('stg_shopify_gql__product_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__product_tmp')),
                staging_columns=get_graphql_product_columns()
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
        _fivetran_deleted,
        _fivetran_synced,
        compare_at_price_range_max_variant_compare_at_price_amount,
        compare_at_price_range_max_variant_compare_at_price_currency_code,
        compare_at_price_range_min_variant_compare_at_price_amount,
        compare_at_price_range_min_variant_compare_at_price_currency_code,
        created_at,
        description,
        description_html,
        featured_media_id,
        gift_card_template_suffix,
        handle,
        has_only_default_variant,
        has_out_of_stock_variants,
        has_variants_that_requires_components,
        id as product_id,
        is_gift_card,
        legacy_resource_id,
        max_variant_price_amount,
        max_variant_price_currency_code,
        metafield,
        min_variant_price_amount,
        min_variant_price_currency_code,
        online_store_preview_url,
        product_type,
        published_at,
        requires_selling_plan,
        seo_description,
        seo_title,
        status,
        template_suffix,
        title,
        total_inventory,
        tracks_inventory,
        updated_at,
        vendor
    from fields
)

select *
from final
