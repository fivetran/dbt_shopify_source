with source as (

    select * from {{ source('shopify', 'inventory_level') }}

),

renamed as (

    select
        inventory_item_id,
        location_id,
        available,
        updated_at as updated_timestamp,
        _fivetran_synced

    from source

)

select * from renamed

