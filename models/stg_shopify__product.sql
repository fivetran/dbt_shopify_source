with source as (

    select * from {{ source('shopify', 'product') }}

),

renamed as (

    select
        id,
        title,
        handle,
        product_type,
        vendor,
        created_at,
        updated_at,
        published_at,
        published_scope,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed

