{% macro get_product_variant_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "barcode", "datatype": dbt.type_string()},
    {"name": "compare_at_price", "datatype": dbt.type_float()},
    {"name": "created_at", "datatype": dbt.type_timestamp()},
    {"name": "fulfillment_service", "datatype": dbt.type_string()},
    {"name": "grams", "datatype": dbt.type_float()},
    {"name": "id", "datatype": dbt.type_numeric()},
    {"name": "image_id", "datatype": dbt.type_numeric()},
    {"name": "inventory_item_id", "datatype": dbt.type_numeric()},
    {"name": "inventory_management", "datatype": dbt.type_string()},
    {"name": "inventory_policy", "datatype": dbt.type_string()},
    {"name": "inventory_quantity", "datatype": dbt.type_numeric()},
    {"name": "old_inventory_quantity", "datatype": dbt.type_numeric()},
    {"name": "option_1", "datatype": dbt.type_string()},
    {"name": "option_2", "datatype": dbt.type_string()},
    {"name": "option_3", "datatype": dbt.type_string()},
    {"name": "position", "datatype": dbt.type_numeric()},
    {"name": "price", "datatype": dbt.type_float()},
    {"name": "product_id", "datatype": dbt.type_numeric()},
    {"name": "sku", "datatype": dbt.type_string()},
    {"name": "tax_code", "datatype": dbt.type_string()},
    {"name": "taxable", "datatype": dbt.type_boolean()},
    {"name": "title", "datatype": dbt.type_string()},
    {"name": "updated_at", "datatype": dbt.type_timestamp()},
    {"name": "weight", "datatype": dbt.type_float()},
    {"name": "weight_unit", "datatype": dbt.type_string()},
    {"name": "available_for_sale", "datatype": dbt.type_boolean()},
    {"name": "display_name", "datatype": dbt.type_string()},
    {"name": "legacy_resource_id", "datatype": dbt.type_bigint()},
    {"name": "requires_components", "datatype": dbt.type_boolean()},
    {"name": "sellable_online_quantity", "datatype": dbt.type_int()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('product_variant_pass_through_columns')) }}

{{ return(columns) }}

{% endmacro %}