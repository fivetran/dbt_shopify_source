with source as (

    select * from {{ source('shopify', 'abandoned_checkout_line') }}

),

renamed as (

    select
        checkout_id,
        index,
        variant_id,
        product_id,
        id,
        key,
        compare_at_price,
        destination_location_id,
        fulfillment_service,
        grams,
        line_price,
        origin_location_id,
        price,
        quantity,
        requires_shipping,
        sku,
        taxable,
        title,
        vendor,
        tax_code,
        _fivetran_synced,
        property_shipping_interval_unit_type,
        property_shipping_interval_frequency,
        property_subscription_id

    from source

)

select * from renamed

