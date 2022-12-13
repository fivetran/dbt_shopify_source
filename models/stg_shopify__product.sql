with base as (

    select * 
    from {{ ref('stg_shopify__product_tmp') }}

),

fields as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__product_tmp')),
                staging_columns=get_product_columns()
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
        created_at,
        handle,
        id as product_id,
        product_type,
        published_at,
        published_scope,
        title,
        updated_at,
        vendor,
        status,
        _fivetran_deleted as is_deleted,
        _fivetran_synced,
        source_relation

        {{ fivetran_utils.fill_pass_through_columns('product_pass_through_columns') }}

from fields

)

select * 
from final