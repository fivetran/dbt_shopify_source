with source as (

    select * from {{ source('shopify', 'draft_order_line') }}

),

renamed as (

    select
        draft_order_id,
        index,
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
        custom,
        variant_title,
        applied_discount_description,
        applied_discount_value_type,
        applied_discount_value,
        applied_discount_amount,
        applied_discount_title,
        _fivetran_synced

    from source

)

select * from renamed

