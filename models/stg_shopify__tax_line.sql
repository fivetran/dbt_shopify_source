with source as (

    select * from {{ source('shopify', 'tax_line') }}

),

renamed as (

    select
        order_line_id,
        index,
        title,
        price,
        rate,
        _fivetran_synced

    from source

)

select * from renamed

