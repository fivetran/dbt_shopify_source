with source as (

    select * from {{ source('shopify', 'refund') }}

),

renamed as (

    select
        id as refund_id,
        created_at as created_timestamp,
        processed_at as processed_timestamp,
        note,
        restock,
        user_id,
        _fivetran_synced

    from source

)

select * from renamed

