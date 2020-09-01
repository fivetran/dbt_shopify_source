with source as (

    select * from {{ source('shopify', 'collect') }}

),

renamed as (

    select
        collection_id,
        id as collect_id,
        product_id,
        featured,
        position,
        created_at as created_timestamp,
        updated_at as updated_timestamp,
        _fivetran_synced

    from source

)

select * from renamed

