with source as (

    select * from {{ source('shopify', 'product_option') }}

),

renamed as (

    select
        id,
        product_id,
        name,
        position,
        "VALUES",
        _fivetran_synced

    from source

)

select * from renamed

