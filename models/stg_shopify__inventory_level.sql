
with base as (

    select * 
    from {{ ref('stg_shopify__inventory_level_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__inventory_level_tmp')),
                staging_columns=get_inventory_level_columns()
            )
        }}
    from base
),

final as (
    
    select 
        inventory_item_id,
        location_id,
        available as available_quantity,
        updated_at,
        _fivetran_synced
        
    from fields
)

select *
from final