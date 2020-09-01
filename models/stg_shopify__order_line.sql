with source as (

    select * from {{ source('shopify', 'order_line') }}

),

renamed as (

    select
        order_id,
        id,
        product_id,
        variant_id,
        name,
        title,
        vendor,
        price,
        quantity,
        grams,
        sku,
        fulfillable_quantity,
        fulfillment_service,
        gift_card,
        requires_shipping,
        taxable,
        index,
        total_discount,
        pre_tax_price,
        fulfillment_status,
        _fivetran_synced,
        property_for_shipping_jan_3_rd_2020,
        property_charge_interval_frequency,
        property_shipping_interval_unit_type,
        property_shipping_interval_frequency,
        property_subscription_id

    from source

)

select * from renamed