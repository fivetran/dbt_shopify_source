
with base as (

    select * 
    from {{ ref('stg_shopify__fulfillment_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__fulfillment_tmp')),
                staging_columns=get_fulfillment_columns()
            )
        }}
    from base
),

final as (
    
    select 
        _fivetran_synced,
        created_at,
        id as fulfillment_id,
        location_id,
        name,
        order_id,
        service,
        shipment_status,
        status,
        tracking_company,
        tracking_number,
        tracking_numbers,
        tracking_urls,
        updated_at
        
    from fields
)

select *
from final
