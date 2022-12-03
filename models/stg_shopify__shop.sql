
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
[0m22:57:14  [[33mWARNING[0m]: Configuration paths exist in your dbt_project.yml file which do not apply to any resources.
There are 2 unused configuration paths:
- models.ad_reporting
- models.netsuite

[0m22:57:17          _fivetran_deleted,
        _fivetran_synced,
        address_1,
        address_2,
        auto_configure_tax_inclusivity,
        checkout_api_supported,
        city,
        cookie_consent_level,
        country,
        country_code,
        country_name,
        county_taxes,
        created_at,
        currency,
        customer_email,
        domain,
        eligible_for_card_reader_giveaway,
        eligible_for_payments,
        email,
        enabled_presentment_currencies,
        force_ssl,
        google_apps_domain,
        google_apps_login_enabled,
        has_discounts,
        has_gift_cards,
        has_storefront,
        iana_timezone,
        id,
        latitude,
        longitude,
        money_format,
        money_in_emails_format,
        money_with_currency_format,
        money_with_currency_in_emails_format,
        multi_location_enabled,
        myshopify_domain,
        name,
        password_enabled,
        phone,
        plan_display_name,
        plan_name,
        pre_launch_enabled,
        primary_locale,
        primary_location_id,
        province,
        province_code,
        requires_extra_payments_agreement,
        setup_required,
        shop_owner,
        source,
        tax_shipping,
        taxes_included,
        timezone,
        updated_at,
        visitor_tracking_consent_preference,
        weight_unit,
        zip
    from fields
)

select *
from final
