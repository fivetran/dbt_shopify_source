with source as (

    select * from {{ source('shopify', 'transaction') }}

),

renamed as (

    select
        id as transaction_id,
        order_id,
        refund_id,
        amount,
        authorization,
        created_at as created_timestamp,
        processed_at as processed_timestamp,
        device_id,
        gateway,
        source_name,
        message,
        currency,
        location_id,
        parent_id,
        payment_avs_result_code,
        payment_credit_card_bin,
        payment_cvv_result_code,
        payment_credit_card_number,
        payment_credit_card_company,
        kind,
        receipt,
        currency_exchange_id,
        currency_exchange_adjustment,
        currency_exchange_original_amount,
        currency_exchange_final_amount,
        currency_exchange_currency,
        error_code,
        status,
        test,
        user_id,
        _fivetran_synced

    from source

)

select * from renamed

