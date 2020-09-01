with source as (

    select * from {{ source('shopify', 'discount_application') }}

),

renamed as (

    select
        order_id,
        index,
        type,
        title,
        code,
        description,
        value,
        value_type,
        allocation_method,
        target_selection,
        target_type,
        _fivetran_synced

    from source

)

select * from renamed

