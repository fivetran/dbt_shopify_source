with source as (

    select * from {{ source('shopify', 'collection') }}
    where _fivetran_deleted = False

),

renamed as (

    select
        id as collection_id,
        title,
        handle,
        updated_at as updated_timestamp,
        published_at as published_timestamp,
        published_scope,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed

