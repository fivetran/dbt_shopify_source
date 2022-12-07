
with base as (

    select * 
    from {{ ref('stg_shopify__product_tag_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__product_tag_tmp')),
                staging_columns=get_product_tag_columns()
            )
        }}
    from base
),

final as (
    
    select 
        product_id,
        index,
        value,
        _fivetran_synced

    from fields
)

select *
from final
