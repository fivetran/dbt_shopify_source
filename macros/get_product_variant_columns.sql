{% macro get_product_variant_columns() %}

{% set columns = [
    {"name": "id", "datatype": dbt.type_numeric()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "created_at", "datatype": dbt.type_timestamp()},
    {"name": "updated_at", "datatype": dbt.type_timestamp()},
    {"name": "product_id", "datatype": dbt.type_numeric()},
    {"name": "inventory_item_id", "datatype": dbt.type_numeric()},
    {"name": "image_id", "datatype": dbt.type_numeric()},
    {"name": "title", "datatype": dbt.type_string()},
    {"name": "price", "datatype": dbt.type_float()},
    {"name": "sku", "datatype": dbt.type_string()},
    {"name": "position", "datatype": dbt.type_numeric()},
    {"name": "inventory_policy", "datatype": dbt.type_string()},
    {"name": "compare_at_price", "datatype": dbt.type_float()},
    {"name": "taxable", "datatype": "boolean"},
    {"name": "barcode", "datatype": dbt.type_string()},
    {"name": "old_inventory_quantity", "datatype": dbt.type_numeric()},
    {"name": "inventory_quantity", "datatype": dbt.type_numeric()},
    {"name": "tax_code", "datatype": dbt.type_string()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('product_variant_pass_through_columns')) }}

{{ return(columns) }}

{% endmacro %}