with source as (

    select * from {{ source('shopify', 'product_variant') }}

),

renamed as (

    select
        id,
        product_id,
        inventory_item_id,
        title,
        price,
        sku,
        position,
        inventory_policy,
        compare_at_price,
        fulfillment_service,
        inventory_management,
        created_at,
        updated_at,
        taxable,
        barcode,
        grams,
        image_id,
        inventory_quantity,
        weight,
        weight_unit,
        old_inventory_quantity,
        requires_shipping,
        _fivetran_synced

    from source

)

select * from renamed

