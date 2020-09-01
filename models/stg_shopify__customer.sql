with source as (

    select * from {{ source('shopify', 'customer') }}

),

renamed as (

    select
        id,
        first_name,
        last_name,
        email,
        phone,
        state,
        orders_count,
        total_spent,
        created_at,
        updated_at,
        accepts_marketing,
        tax_exempt,
        verified_email,
        default_address_id,
        _fivetran_synced

    from source

)

select * from renamed

