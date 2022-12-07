
with base as (

    select * 
    from {{ ref('stg_shopify__product_image_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__product_image_tmp')),
                staging_columns=get_product_image_columns()
            )
        }}
    from base
),

final as (
    
    select 
        id as product_image_id,
        product_id,
        height,
        position,
        src,
        variant_ids,
        width,
        created_at,
        updated_at,
        _fivetran_synced

    from fields
    where not coalesce(_fivetran_deleted, false)
)

select *
from final
