with source as (

    select * from {{ source('shopify', 'collection') }}

),

renamed as (

    select
        id,
        title,
        handle,
        updated_at,
        published_at,
        published_scope,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed

