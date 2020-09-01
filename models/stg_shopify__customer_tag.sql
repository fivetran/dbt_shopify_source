with source as (

    select * from {{ source('shopify', 'customer_tag') }}

),

renamed as (

    select
        customer_id,
        index,
        value,
        _fivetran_synced

    from source

)

select * from renamed

