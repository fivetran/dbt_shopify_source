
with base as (

    select * 
    from {{ ref('stg_shopify__abandoned_checkout_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__abandoned_checkout_tmp')),
                staging_columns=get_abandoned_checkout_columns()
            )
        }}
    from base
),

final as (
    
    select 
[0m22:58:01  [[33mWARNING[0m]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 2 unused configuration paths:
- models.ad_reporting
- models.netsuite

[0m22:58:04          _fivetran_deleted,
        _fivetran_synced,
        abandoned_checkout_url,
        applied_discount_amount,
        applied_discount_applicable,
        applied_discount_description,
        applied_discount_non_applicable_reason,
        applied_discount_title,
        applied_discount_value,
        applied_discount_value_type,
        billing_address_address_1,
        billing_address_address_2,
        billing_address_city,
        billing_address_company,
        billing_address_country,
        billing_address_country_code,
        billing_address_first_name,
        billing_address_id,
        billing_address_is_default,
        billing_address_last_name,
        billing_address_latitude,
        billing_address_longitude,
        billing_address_name,
        billing_address_phone,
        billing_address_province,
        billing_address_province_code,
        billing_address_zip,
        buyer_accepts_marketing,
        cart_token,
        closed_at,
        completed_at,
        created_at,
        credit_card_first_name,
        credit_card_last_name,
        credit_card_month,
        credit_card_number,
        credit_card_verification_value,
        credit_card_year,
        currency,
        customer_id,
        customer_locale,
        device_id,
        email,
        gateway,
        id,
        landing_site_base_url,
        location_id,
        name,
        note,
        note_attribute_email_client_id,
        note_attribute_google_client_id,
        note_attribute_littledata_updated_at,
        note_attribute_segment_client_id,
        note_attributes,
        phone,
        presentment_currency,
        referring_site,
        shipping_address_address_1,
        shipping_address_address_2,
        shipping_address_city,
        shipping_address_company,
        shipping_address_country,
        shipping_address_country_code,
        shipping_address_first_name,
        shipping_address_id,
        shipping_address_is_default,
        shipping_address_last_name,
        shipping_address_latitude,
        shipping_address_longitude,
        shipping_address_name,
        shipping_address_phone,
        shipping_address_province,
        shipping_address_province_code,
        shipping_address_zip,
        shipping_line,
        shipping_rate_id,
        shipping_rate_price,
        shipping_rate_title,
        source,
        source_identifier,
        source_name,
        source_url,
        subtotal_price,
        taxes_included,
        token,
        total_discounts,
        total_duties,
        total_line_items_price,
        total_price,
        total_tax,
        total_weight,
        updated_at,
        user_id
    from fields
)

select *
from final
