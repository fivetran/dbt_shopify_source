with source as (

    select * from {{ source('shopify', 'order_discount_code') }}

),

renamed as (

    select
        order_id,
        index,
        code,
        amount,
        _fivetran_synced

    from source

)

select * from renamed

