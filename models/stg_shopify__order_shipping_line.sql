with source as (

    select * from {{ source('shopify', 'order_shipping_line') }}

),

renamed as (

    select
        order_id,
        id,
        code,
        price,
        source,
        title,
        carrier_identifier,
        requested_fulfillment_service_id,
        phone,
        delivery_category,
        discounted_price,
        _fivetran_synced

    from source

)

select * from renamed

