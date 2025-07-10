
with base as (

    select * 
    from {{ ref('stg_shopify_gql__shop_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_shopify_gql__shop_tmp')),
                staging_columns=get_graphql_shop_columns()
            )
        }}
        {{ fivetran_utils.source_relation(
            union_schema_variable='shopify_union_schemas', 
            union_database_variable='shopify_union_databases') 
        }}
    from base
),

final as (
    
    select 
        source_relation, 
        _fivetran_deleted,
        _fivetran_synced,
        account_owner_id,
        billing_address_address_1,
        billing_address_address_2,
        billing_address_city,
        billing_address_company,
        billing_address_coordinates_validated,
        billing_address_country,
        billing_address_country_code_v_2,
        billing_address_id,
        billing_address_latitude,
        billing_address_longitude,
        billing_address_phone,
        billing_address_province,
        billing_address_province_code,
        billing_address_zip,
        checkout_api_supported,
        contact_email,
        countries_in_shipping_zones_country_codes,
        countries_in_shipping_zones_include_rest_of_world,
        created_at,
        currency_code,
        currency_formats_money_format,
        currency_formats_money_in_emails_format,
        currency_formats_money_with_currency_format,
        currency_formats_money_with_currency_in_emails_format,
        customer_accounts,
        customer_accounts_login_links_visible_on_storefront_checkout,
        customer_accounts_login_required_at_checkout,
        customer_accounts_url,
        customer_accounts_version,
        description,
        email,
        enabled_presentment_currencies,
        features_avalara_avatax,
        features_branding,
        features_bundles_eligible_for_bundles,
        features_bundles_ineligibility_reason,
        features_bundles_sells_bundles,
        features_captcha,
        features_cart_transform_eligible_operations_expand_operation,
        features_cart_transform_eligible_operations_merge_operation,
        features_cart_transform_eligible_operations_update_operation,
        features_dynamic_remarketing,
        features_eligible_for_subscription_migration,
        features_eligible_for_subscriptions,
        features_gift_cards,
        features_harmonized_system_code,
        features_international_price_overrides,
        features_international_price_rules,
        features_legacy_subscription_gateway_enabled,
        features_live_view,
        features_paypal_express_subscription_gateway_status,
        features_reports,
        features_sells_subscriptions,
        features_show_metrics,
        features_storefront,
        iana_timezone,
        id as shop_id,
        marketing_sms_consent_enabled_at_checkout,
        myshopify_domain,
        name as shop_name,
        order_number_format_prefix,
        order_number_format_suffix,
        password_enabled,
        payment_settings_supported_digital_wallets,
        plan_display_name,
        plan_partner_development,
        plan_shopify_plus,
        primary_domain_host,
        primary_domain_id,
        primary_domain_localization_alternate_locales,
        primary_domain_localization_country,
        primary_domain_localization_default_locale,
        primary_domain_ssl_enabled,
        primary_domain_url,
        resource_limits_location_limit,
        resource_limits_max_product_options,
        resource_limits_max_product_variants,
        resource_limits_redirect_limit_reached,
        rich_text_editor_url,
        setup_required,
        ships_to_countries,
        shop_owner_name,
        tax_shipping,
        taxes_included,
        timezone_abbreviation,
        timezone_offset,
        timezone_offset_minutes,
        transactional_sms_disabled,
        unit_system,
        updated_at,
        url,
        weight_unit
    from fields
)

select *
from final
