
with base as (

    select * 
    from {{ ref('stg_shopify__collection_product_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__collection_product_tmp')),
                staging_columns=get_collection_product_columns()
            )
        }}
    from base
),

final as (
    
    select 
        _fivetran_synced,
        collection_id,
        product_id
        
    from fields
)

select *
from final
