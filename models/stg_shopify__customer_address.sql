with source as (

    select * from {{ source('shopify', 'customer_address') }}

),

renamed as (

    select
        customer_id,
        id as customer_address_id,
        name,
        first_name,
        last_name,
        company,
        phone,
        address_1,
        address_2,
        city,
        country,
        country_code,
        province,
        province_code,
        zip,
        latitude,
        longitude,
        _fivetran_synced

    from source

)

select * from renamed

