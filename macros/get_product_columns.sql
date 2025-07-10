{% macro get_product_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": dbt.type_boolean()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "created_at", "datatype": dbt.type_timestamp()},
    {"name": "handle", "datatype": dbt.type_string()},
    {"name": "id", "datatype": dbt.type_numeric()},
    {"name": "product_type", "datatype": dbt.type_string()},
    {"name": "published_at", "datatype": dbt.type_timestamp()},
    {"name": "published_scope", "datatype": dbt.type_string()},
    {"name": "title", "datatype": dbt.type_string()},
    {"name": "updated_at", "datatype": dbt.type_timestamp()},
    {"name": "vendor", "datatype": dbt.type_string()},
    {"name": "status", "datatype": dbt.type_string()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('product_pass_through_columns')) }}

{{ return(columns) }}

{% endmacro %}


{% macro get_graphql_product_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": dbt.type_boolean()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "compare_at_price_range_max_variant_compare_at_price_amount", "datatype": dbt.type_float()},
    {"name": "compare_at_price_range_max_variant_compare_at_price_currency_code", "datatype": dbt.type_string()},
    {"name": "compare_at_price_range_min_variant_compare_at_price_amount", "datatype": dbt.type_float()},
    {"name": "compare_at_price_range_min_variant_compare_at_price_currency_code", "datatype": dbt.type_string()},
    {"name": "created_at", "datatype": dbt.type_timestamp()},
    {"name": "description", "datatype": dbt.type_string()},
    {"name": "description_html", "datatype": dbt.type_string()},
    {"name": "featured_media_id", "datatype": dbt.type_int()},
    {"name": "gift_card_template_suffix", "datatype": dbt.type_string()},
    {"name": "handle", "datatype": dbt.type_string()},
    {"name": "has_only_default_variant", "datatype": dbt.type_boolean()},
    {"name": "has_out_of_stock_variants", "datatype": dbt.type_boolean()},
    {"name": "has_variants_that_requires_components", "datatype": dbt.type_boolean()},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "is_gift_card", "datatype": dbt.type_boolean()},
    {"name": "legacy_resource_id", "datatype": dbt.type_int()},
    {"name": "max_variant_price_amount", "datatype": dbt.type_float()},
    {"name": "max_variant_price_currency_code", "datatype": dbt.type_string()},
    {"name": "metafield", "datatype": dbt.type_string()},
    {"name": "min_variant_price_amount", "datatype": dbt.type_float()},
    {"name": "min_variant_price_currency_code", "datatype": dbt.type_string()},
    {"name": "online_store_preview_url", "datatype": dbt.type_string()},
    {"name": "product_type", "datatype": dbt.type_string()},
    {"name": "published_at", "datatype": dbt.type_timestamp()},
    {"name": "requires_selling_plan", "datatype": dbt.type_boolean()},
    {"name": "seo_description", "datatype": dbt.type_string()},
    {"name": "seo_title", "datatype": dbt.type_string()},
    {"name": "status", "datatype": dbt.type_string()},
    {"name": "template_suffix", "datatype": dbt.type_string()},
    {"name": "title", "datatype": dbt.type_string()},
    {"name": "total_inventory", "datatype": dbt.type_int()},
    {"name": "tracks_inventory", "datatype": dbt.type_boolean()},
    {"name": "updated_at", "datatype": dbt.type_timestamp()},
    {"name": "vendor", "datatype": dbt.type_string()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('product_pass_through_columns')) }}

{{ return(columns) }}

{% endmacro %}
