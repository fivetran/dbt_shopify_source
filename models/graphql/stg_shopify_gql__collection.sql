
with base as (

    select * 
    from {{ ref('stg_shopify_gql__collection_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__collection_tmp')),
                staging_columns=get_graphql_collection_columns()
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
        applied_disjunctively,
        description,
        description_html,
        feedback_summary,
        handle,
        id as collection_id,
        image_alt_text,
        image_height,
        image_id,
        image_url,
        image_width,
        products_count,
        products_count_precision,
        seo_description,
        seo_title,
        sort_order,
        template_suffix,
        title,
        updated_at
    from fields
)

select *
from final
