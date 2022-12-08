
with base as (

    select * 
    from {{ ref('stg_shopify__shop_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify__shop_tmp')),
                staging_columns=get_shop_columns()
            )
        }}
    from base
),

final as (
    
    select 
        id as shop_id,
        name,
        _fivetran_deleted as is_deleted,
        address_1,
        address_2,
        city,
        province,
        province_code,
        country,
        country_code,
        country_name,
        zip,
        latitude,
        longitude,
        ifnull(county_taxes, false) as has_county_taxes,
        currency,
        enabled_presentment_currencies,
        customer_email,
        email,
        domain,
        phone,
        timezone,
        iana_timezone,
        primary_locale,
        weight_unit,
        myshopify_domain,
        cookie_consent_level,
        shop_owner,
        source,
        tax_shipping as has_shipping_taxes,
        ifnull(taxes_included, false) as has_taxes_included_in_price,
        has_discounts,
        has_gift_cards,
        has_storefront,
        checkout_api_supported as has_checkout_api_supported,
        eligible_for_card_reader_giveaway as is_eligible_for_card_reader_giveaway,
        eligible_for_payments as is_eligible_for_payments,
        google_apps_domain,
        ifnull(google_apps_login_enabled, false) as is_google_apps_login_enabled,
        money_format,
        money_in_emails_format,
        money_with_currency_format,
        money_with_currency_in_emails_format,
        plan_display_name,
        plan_name,
        password_enabled as is_password_enabled,
        pre_launch_enabled as is_pre_launch_enabled,
        requires_extra_payments_agreement as does_require_extra_payments_agreement,
        setup_required as is_setup_required,
        created_at,
        updated_at,
        _fivetran_synced

    from fields
)

select *
from final
