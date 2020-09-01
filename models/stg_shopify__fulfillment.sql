with source as (

    select * from {{ source('shopify', 'fulfillment') }}

),

renamed as (

    select
        id as fulfillment_id,
        order_id,
        location_id,
        created_at as created_timestamp,
        updated_at as updated_timestamp,
        status,
        tracking_company,
        tracking_number,
        _fivetran_synced

    from source

)

select * from renamed

