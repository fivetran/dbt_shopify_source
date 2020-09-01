with source as (

    select * from {{ source('shopify', 'inventory_item') }}

),

renamed as (

    select
        id as inventory_item_id,
        sku,
        created_at as created_timestamp,
        updated_at as updated_timestamp,
        requires_shipping,
        cost,
        tracked,
        _fivetran_synced

    from source

)

select * from renamed

