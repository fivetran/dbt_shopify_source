with source as (

    select * from {{ source('shopify', 'fulfillment') }}

),

renamed as (

    select
        id,
        order_id,
        location_id,
        created_at,
        updated_at,
        status,
        tracking_company,
        tracking_number,
        _fivetran_synced

    from source

)

select * from renamed

