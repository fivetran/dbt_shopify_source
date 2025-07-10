
with base as (

    select * 
    from {{ ref('stg_shopify_gql__media_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__media_tmp')),
                staging_columns=get_graphql_media_columns()
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
        alt,
        created_at,
        file_status,
        id as media_id,
        media_content_type,
        preview_image_alt_text,
        preview_image_height,
        preview_image_id,
        preview_image_url,
        preview_image_width,
        preview_status,
        status,
        updated_at
    from fields
)

select *
from final
