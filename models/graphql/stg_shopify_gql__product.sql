
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
        id as product_id,
        handle,
        product_type,
        {# no published_scope #}
        title,
        vendor,
        status,
        _fivetran_deleted as is_deleted,
        {{ shopify_source.fivetran_convert_timezone(column='cast(created_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as created_timestamp,
        {{ shopify_source.fivetran_convert_timezone(column='cast(updated_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as updated_timestamp,
        {{ shopify_source.fivetran_convert_timezone(column='cast(published_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as published_timestamp,
        {{ shopify_source.fivetran_convert_timezone(column='cast(_fivetran_synced as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as _fivetran_synced,
        source_relation

        {{ fivetran_utils.fill_pass_through_columns('product_pass_through_columns') }}

        {# TODO: remove
        
        compare_at_price_range_max_variant_compare_at_price_amount,
        compare_at_price_range_max_variant_compare_at_price_currency_code,
        compare_at_price_range_min_variant_compare_at_price_amount,
        compare_at_price_range_min_variant_compare_at_price_currency_code,
        created_at,
        description,
        description_html,
        featured_media_id,
        gift_card_template_suffix,
        has_only_default_variant,
        has_out_of_stock_variants,
        has_variants_that_requires_components,
        is_gift_card,
        legacy_resource_id,
        max_variant_price_amount,
        max_variant_price_currency_code,
        metafield,
        min_variant_price_amount,
        min_variant_price_currency_code,
        online_store_preview_url,
        requires_selling_plan,
        seo_description,
        seo_title,
        template_suffix,
        total_inventory,
        tracks_inventory #}

    from fields
)

select *
from final
