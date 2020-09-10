with source as (

    select * from {{ var('order_line_refund_source') }}

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

