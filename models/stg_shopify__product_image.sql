with source as (

    select * from {{ source('shopify', 'product_image') }}
    where _fivetran_deleted = False

),

renamed as (

    select
        product_id,
        id as product_image_id,
        position,
        width,
        height,
        created_at as created_timestamp,
        updated_at as updated_timestamp,
        src,
        _fivetran_deleted,
        alt,
        _fivetran_synced

    from source

)

select * from renamed

