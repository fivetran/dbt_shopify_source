{% macro get_product_image_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "height", "datatype": dbt.type_int()},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "product_id", "datatype": dbt.type_int()},
    {"name": "src", "datatype": dbt.type_string()},
    {"name": "url", "datatype": dbt.type_string()},
    {"name": "width", "datatype": dbt.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}
