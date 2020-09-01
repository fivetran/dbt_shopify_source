with source as (

    select * from {{ source('shopify', 'product_tag') }}

),

renamed as (

    select
        product_id,
        index,
        value,
        _fivetran_synced

    from source

)

select * from renamed

