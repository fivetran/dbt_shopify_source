with source as (

    select * from {{ source('shopify', 'customer') }}

),

renamed as (

    select
        id as customer_id,
        first_name,
        last_name,
        email,
        phone,
        state,
        orders_count,
        total_spent,
        created_at as created_timestamp,
        updated_at as updated_timestamp,
        accepts_marketing,
        tax_exempt,
        verified_email,
        default_address_id,
        _fivetran_synced

    from source

)

select * from renamed

