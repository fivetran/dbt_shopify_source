with source as (

    select * from {{ source('shopify', 'collect') }}

),

renamed as (

    select
        collection_id,
        id,
        product_id,
        featured,
        position,
        created_at,
        updated_at,
        _fivetran_synced

    from source

)

select * from renamed

