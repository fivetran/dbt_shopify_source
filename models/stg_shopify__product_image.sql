with source as (

    select * from {{ source('shopify', 'product_image') }}

),

renamed as (

    select
        product_id,
        id,
        position,
        width,
        height,
        created_at,
        updated_at,
        src,
        _fivetran_deleted,
        alt,
        _fivetran_synced

    from source

)

select * from renamed

