with base as (

    select * 
    from {{ ref('stg_shopify__fulfillment_order_line_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__fulfillment_order_line_tmp')),
                staging_columns=get_fulfillment_order_line_columns()
            )
        }}
    from base
),

final as (
    
    select -- may remove this model
        _fivetran_synced,
        fulfillable_quantity,
        fulfillment_id,
        fulfillment_service,
        gift_card,
        grams,
        name,
        order_id,
        order_line_id,
        price,
        price_set,
        product_id,
        properties,
        property_pre_order_date,
        quantity,
        requires_shipping,
        sku,
        taxable,
        title,
        variant_id,
        variant_title,
        vendor
    from fields
)

select *
from final
