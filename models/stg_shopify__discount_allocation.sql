with source as (

    select * from {{ source('shopify', 'discount_allocation') }}

),

renamed as (

    select
        order_line_id,
        index,
        discount_application_index,
        amount,
        amount_set_shop_money_amount,
        amount_set_shop_money_currency_code,
        amount_set_presentment_money_amount,
        amount_set_presentment_money_currency_code,
        _fivetran_synced

    from source

)

select * from renamed

