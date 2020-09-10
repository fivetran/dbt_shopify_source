with source as (

    select * from {{ source('shopify', 'order_line_refund') }}

),

renamed as (

    select
        id as order_line_refund_id,
        location_id,
        refund_id,
        restock_type,
        quantity,
        order_line_id,
        _fivetran_synced

    from source

)

select * from renamed

