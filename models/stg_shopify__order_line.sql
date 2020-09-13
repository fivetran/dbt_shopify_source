with source as (

    select * from {{ var('order_line_source') }}

),

renamed as (

    select
        order_id,
        id as order_line_id,
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
        _fivetran_synced

    from source

)

select * from renamed