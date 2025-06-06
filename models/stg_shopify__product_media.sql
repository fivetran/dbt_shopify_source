with base as (

    select * 
    from {{ ref('stg_shopify__product_media_tmp') }}
),


fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__product_media_tmp')),
                staging_columns=get_product_media_columns()
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
        product_id,
        media_id,
        source_relation

    from fields
)

select *
from final
