with source as (

    select * from {{ source('shopify', 'abandoned_checkout_shipping_line') }}

),

renamed as (

    select
        checkout_id,
        index,
        id,
        code,
        price,
        source,
        title,
        phone,
        validation_context,
        markup,
        carrier_identifier,
        carrier_service_id,
        api_client_id,
        requested_fulfillment_service_id,
        delivery_category,
        discounted_price,
        _fivetran_synced

    from source

)

select * from renamed

