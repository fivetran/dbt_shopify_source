
with base as (

    select * 
    from {{ ref('stg_shopify__order_url_tag_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__order_url_tag_tmp')),
                staging_columns=get_order_url_tag_columns()
            )
        }}
    from base
),

final as (
    
    select 
        _fivetran_synced,
        key,
        order_id,
        value
        
    from fields
)

select *
from final
