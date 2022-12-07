
with base as (

    select * 
    from {{ ref('stg_shopify__inventory_item_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__inventory_item_tmp')),
                staging_columns=get_inventory_item_columns()
            )
        }}
    from base
),

final as (
    
    select 
        id as inventory_item_id,
        sku,
        _fivetran_deleted as is_deleted, -- won't filter out for now
        cost,
        country_code_of_origin,
        province_code_of_origin,
        requires_shipping as does_require_shipping,
        tracked as is_inventory_quantity_tracked,
        created_at,
        updated_at,
        _fivetran_synced

    from fields
)

select *
from final
