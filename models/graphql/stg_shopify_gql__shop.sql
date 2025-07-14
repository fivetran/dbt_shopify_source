
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
        id as shop_id,
        name,
        _fivetran_deleted as is_deleted,
        billing_address_address_1 as address_1,
        billing_address_address_2 as address_2,
        billing_address_city as city,
        billing_address_province as province,
        billing_address_province_code as province_code,
        billing_address_country_code_v_2 as country, -- in REST API country = code
        billing_address_country_code_v_2 as country_code,
        billing_address_country as country_name,
        billing_address_zip as zip,
        billing_address_latitude as latitude,
        billing_address_longitude as longitude,
        {# county_taxes was deprecated #}
        currency_code as currency,
        {{ shopify_source.json_to_string("enabled_presentment_currencies", source_columns_in_relation) }} as enabled_presentment_currencies,
        contact_email as customer_email,
        email,
        primary_domain_host as domain,
        billing_address_phone as phone,
        {# timezone is presented differently #}
        timezone_abbreviation,
        {# timezone_offset is formatted like -0400 instead of -04:00 #}
        timezone_offset, 
        timezone_offset_minutes, 
        iana_timezone, 
        primary_domain_localization_default_locale as primary_locale,
        weight_unit,
        myshopify_domain,
        {# no cookie_consent_level #}
        shop_owner_name as shop_owner,
        {# source is deprecated #}
        tax_shipping as has_shipping_taxes,
        coalesce(taxes_included, false) as has_taxes_included_in_price,
        {# has_discounts and has_gift_cards are deprecated. 
        there is features_gift_cards but this reflects whether the shop can create gift cards, while has_gift_cards looks at whether any active gift cards exist for the shop. #}
        features_storefront as has_storefront,
        checkout_api_supported as has_checkout_api_supported,
        {# no eligible_for_card_reader_giveaway #}
        {# eligible_for_payments, google_apps_domain, google_apps_login_enabled are deprecated #}
        currency_formats_money_format as money_format,
        currency_formats_money_in_emails_format as money_in_emails_format,
        currency_formats_money_with_currency_format as money_with_currency_format,
        currency_formats_money_with_currency_in_emails_format as money_with_currency_in_emails_format,
        plan_display_name,
        {# plan_name is deprecated #}
        password_enabled as is_password_enabled,
        {# pre_launch_enabled and requires_extra_payments_agreement are deprecated #}
        setup_required as is_setup_required,
        {{ shopify_source.fivetran_convert_timezone(column='cast(created_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as created_at,
        {{ shopify_source.fivetran_convert_timezone(column='cast(updated_at as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as updated_at,
        {{ shopify_source.fivetran_convert_timezone(column='cast(_fivetran_synced as ' ~ dbt.type_timestamp() ~ ')', target_tz=var('shopify_timezone', "UTC"), source_tz="UTC") }} as _fivetran_synced,
        source_relation

        {# REMOVE
        
        account_owner_id,
        billing_address_company,
        billing_address_coordinates_validated,
        billing_address_id,
        countries_in_shipping_zones_country_codes,
        countries_in_shipping_zones_include_rest_of_world,
        customer_accounts,
        customer_accounts_login_links_visible_on_storefront_checkout,
        customer_accounts_login_required_at_checkout,
        customer_accounts_url,
        customer_accounts_version,
        description,
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
        marketing_sms_consent_enabled_at_checkout,
        order_number_format_prefix,
        order_number_format_suffix,
        payment_settings_supported_digital_wallets,
        plan_partner_development,
        plan_shopify_plus,
        primary_domain_id,
        primary_domain_localization_alternate_locales,
        primary_domain_localization_country,
        primary_domain_ssl_enabled,
        primary_domain_url,
        resource_limits_location_limit,
        resource_limits_max_product_options,
        resource_limits_max_product_variants,
        resource_limits_redirect_limit_reached,
        rich_text_editor_url,
        ships_to_countries,
        transactional_sms_disabled,
        unit_system,
        url #}

    from fields
)

select *
from final
