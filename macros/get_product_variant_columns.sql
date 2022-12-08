{% macro get_product_variant_columns() %}

{% set columns = [
    {"name": "id", "datatype": dbt.type_numeric(), "alias": "variant_id"},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "created_at", "datatype": dbt.type_timestamp(), "alias": "created_timestamp"},
    {"name": "updated_at", "datatype": dbt.type_timestamp(), "alias": "updated_timestamp"},
    {"name": "product_id", "datatype": dbt.type_numeric()},
    {"name": "inventory_item_id", "datatype": dbt.type_numeric()},
    {"name": "image_id", "datatype": dbt.type_numeric()},
    {"name": "title", "datatype": dbt.type_string()},
    {"name": "price", "datatype": dbt.type_float()},
    {"name": "sku", "datatype": dbt.type_string()},
    {"name": "position", "datatype": dbt.type_numeric()},
    {"name": "inventory_policy", "datatype": dbt.type_string()},
    {"name": "compare_at_price", "datatype": dbt.type_float()},
    {"name": "fulfillment_service", "datatype": dbt.type_string()},
    {"name": "inventory_management", "datatype": dbt.type_string()},
    {"name": "taxable", "datatype": "boolean", "alias": "is_taxable"},
    {"name": "barcode", "datatype": dbt.type_string()},
    {"name": "grams", "datatype": dbt.type_float()},
    {"name": "inventory_quantity", "datatype": dbt.type_numeric()},
    {"name": "weight", "datatype": dbt.type_float()},
    {"name": "weight_unit", "datatype": dbt.type_string()},
    {"name": "option_1", "datatype": dbt.type_string()},
    {"name": "option_2", "datatype": dbt.type_string()},
    {"name": "option_3", "datatype": dbt.type_string()},
    {"name": "tax_code", "datatype": dbt.type_string()},
    {"name": "requires_shipping", "datatype": "boolean", "alias": "is_requiring_shipping"}
] %}

{{ return(columns) }}

{% endmacro %}