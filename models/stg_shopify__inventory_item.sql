with source as (

    select * from {{ source('shopify', 'inventory_item') }}

),

renamed as (

    select
        id,
        sku,
        created_at,
        updated_at,
        requires_shipping,
        cost,
        tracked,
        _fivetran_synced

    from source

)

select * from renamed

