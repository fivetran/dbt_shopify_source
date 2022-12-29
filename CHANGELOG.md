# dbt_shopify_source v0.7.0
## 🎉 Documentation and Feature Updates
- Updated README documentation updates for easier navigation and setup of the dbt package
- Included `shopify_[source_table_name]_identifier` variable for additional flexibility within the package when source tables are named differently.
- The following fields have been added to their respective staging models:
  - `stg_shopify__order`:
    - `total_discounts_set`
    - `total_line_items_price_set`
    - `total_price_usd`
    - `total_price_set`
    - `total_tax_set`
    - `total_tip_received`
    - `is_deleted`
    - `app_id`
    - `checkout_id`
    - `client_details_user_agent`
    - `customer_locale`
    - `order_status_url`
    - `presentment_currency`
    - `is_inventory_confirmed`
  - `stg_shopify__customer`:
    - `note`
    - `lifetime_duration`
    - `currency`
    - `marketing_consent_state` (coalescing of `email_marketing_consent_state` and deprecated `accepts_marketing` field)
    - `marketing_opt_in_level` (coalescing of `email_marketing_consent_opt_in_level` and deprecated `marketing_opt_in_level` field)
    - `marketing_consent_updated_at` (coalescing of `email_marketing_consent_consent_updated_at` and deprecated `accepts_marketing_updated_at` field)
  - `stg_shopify__order_line_refund`:
    - `subtotal_set`
    - `total_tax_set`
  - `stg_shopify__order_line`:
    - `pre_tax_price_set`
    - `price_set`
    - `tax_code`
    - `total_discount_set`
    - `variant_title`
    - `variant_inventory_management`
    - `vendor`
    - `properties`

## 🚨 Breaking Changes 🚨:
[PR #36](https://github.com/fivetran/dbt_shopify_source/pull/36) includes the following breaking changes:
- Dispatch update for dbt-utils to dbt-core cross-db macros migration. Specifically `{{ dbt_utils.<macro> }}` have been updated to `{{ dbt.<macro> }}` for the below macros:
    - `any_value`
    - `bool_or`
    - `cast_bool_to_text`
    - `concat`
    - `date_trunc`
    - `dateadd`
    - `datediff`
    - `escape_single_quotes`
    - `except`
    - `hash`
    - `intersect`
    - `last_day`
    - `length`
    - `listagg`
    - `position`
    - `replace`
    - `right`
    - `safe_cast`
    - `split_part`
    - `string_literal`
    - `type_bigint`
    - `type_float`
    - `type_int`
    - `type_numeric`
    - `type_string`
    - `type_timestamp`
    - `array_append`
    - `array_concat`
    - `array_construct`
- For `current_timestamp` and `current_timestamp_in_utc` macros, the dispatch AND the macro names have been updated to the below, respectively:
    - `dbt.current_timestamp_backcompat`
    - `dbt.current_timestamp_in_utc_backcompat`
- Dependencies on `fivetran/fivetran_utils` have been upgraded, previously `[">=0.3.0", "<0.4.0"]` now `[">=0.4.0", "<0.5.0"]`.
- The following fields have been removed as they have been deprecated:
  - 

[PR #40](https://github.com/fivetran/dbt_shopify_source/pull/40) includes the following breaking changes:
- The `is_requiring_shipping` field in `stg_shopify__order_line` has been renamed to `is_shipping_required`, just because it sounds better :)
## Updates:
[PR #40](https://github.com/fivetran/dbt_shopify_source/pull/40) includes the following changes:
- By default, if the refunds table does not exist, the package will create an empty `stg_shopify__refunds` model. This can still be overwritten by setting `shopify__using_refund` to `false`. We did this because the refunds table is only created once your Shopify account has processed its first refund, and it is unnecessary overhead to have to monitor this and change your dbt_project accordingly. Thus, we took the approach of having this refund table be one that syncs as empty if it is not populated, then seamlessly switches to the source table once it exists.
- TODO more stuff - new tables, fields, passthrough columns, timezone etc.

[PR #38](https://github.com/fivetran/dbt_shopify_source/pull/38) includes the following changes:
- Ensured Postgres compatibility.
- README updated for easier package use and navigation.
- `shopify_<default_source_table_name>_identifier` variables added if an individual source table has a different name than the package expects.

[PR #41](https://github.com/fivetran/dbt_shopify_source/pull/41) includes the following change:
- Addition of the `shopify_timezone` variable, which converts ALL timestamps included in the package (including `_fivetran_synced`) to a single target timezone (in IANA Database format, ie "America/Los_Angeles").

# dbt_shopify_source v0.6.0
🎉 dbt v1.0.0 Compatibility 🎉
## 🚨 Breaking Changes 🚨
- Adjusts the `require-dbt-version` to now be within the range [">=1.0.0", "<2.0.0"]. Additionally, the package has been updated for dbt v1.0.0 compatibility. If you are using a dbt version <1.0.0, you will need to upgrade in order to leverage the latest version of the package.
  - For help upgrading your package, I recommend reviewing this GitHub repo's Release Notes on what changes have been implemented since your last upgrade.
  - For help upgrading your dbt project to dbt v1.0.0, I recommend reviewing dbt-labs [upgrading to 1.0.0 docs](https://docs.getdbt.com/docs/guides/migration-guide/upgrading-to-1-0-0) for more details on what changes must be made.
- Upgrades the package dependency to refer to the latest `dbt_fivetran_utils`. The latest `dbt_fivetran_utils` package also has a dependency on `dbt_utils` [">=0.8.0", "<0.9.0"].
  - Please note, if you are installing a version of `dbt_utils` in your `packages.yml` that is not in the range above then you will encounter a package dependency error.

- The `union_schemas` and `union_databases` variables have been replaced with `shopify_union_schemas` and `shopify_union_databases` respectively. This allows for multiple packages with the union ability to be used and not locked to a single variable that is used across packages.

# dbt_shopify_source v0.5.2
## Under the Hood
- Rearranged the ordering of the columns within the `get_order_columns` macro. This ensure the output of the models within the downstream [Shopify Holistic Reporting](https://github.com/fivetran/dbt_shopify_holistic_reporting) package are easier to understand and interpret. ([#29](https://github.com/fivetran/dbt_shopify_source/pull/29))

# dbt_shopify_source v0.1.0 -> v0.5.1
Refer to the relevant release notes on the Github repository for specific details for the previous releases. Thank you!
