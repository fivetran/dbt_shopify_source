with source as (

    select * from {{ source('shopify', 'product') }}
    where _fivetran_deleted = False

),

renamed as (

    select
        id as product_id,
        title,
        handle,
        product_type,
        vendor,
        created_at as created_timestamp,
        updated_at as updated_timestamp,
        published_at as published_timestamp,
        published_scope,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed

