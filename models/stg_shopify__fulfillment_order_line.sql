with source as (

    select * from {{ source('shopify', 'fulfillment_order_line') }}

),

renamed as (

    select
        fulfillment_id,
        order_line_id,
        _fivetran_synced

    from source

)

select * from renamed

