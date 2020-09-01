with source as (

    select * from {{ source('shopify', 'draft_order') }}

),

renamed as (

    select
        id as draft_order_id,
        note,
        email,
        taxes_included,
        currency,
        subtotal_price,
        total_tax,
        total_price,
        created_at as created_timestamp,
        updated_at as updated_timestamp,
        name,
        shipping_address_name,
        shipping_address_first_name,
        shipping_address_last_name,
        shipping_address_company,
        shipping_address_phone,
        shipping_address_address_1,
        shipping_address_address_2,
        shipping_address_city,
        shipping_address_country,
        shipping_address_country_code,
        shipping_address_province,
        shipping_address_province_code,
        shipping_address_zip,
        shipping_address_latitude,
        shipping_address_longitude,
        billing_address_name,
        billing_address_first_name,
        billing_address_last_name,
        billing_address_company,
        billing_address_phone,
        billing_address_address_1,
        billing_address_address_2,
        billing_address_city,
        billing_address_country,
        billing_address_country_code,
        billing_address_province,
        billing_address_province_code,
        billing_address_zip,
        billing_address_latitude,
        billing_address_longitude,
        order_id,
        customer_id,
        invoice_sent_at as invoice_sent_timestamp,
        tax_exempt,
        completed_at as completed_timestamp,
        status,
        invoice_url,
        admin_graphql_api_id,
        applied_discount_description,
        applied_discount_value_type,
        applied_discount_value,
        applied_discount_amount,
        applied_discount_title,
        shipping_line_custom,
        shipping_line_price,
        shipping_line_title,
        shipping_line_handle,
        _fivetran_synced

    from source

)

select * from renamed

