{% macro get_product_image_columns() %}

{# Columns below line 14 to be deprecated. #}
{% set columns = [
    {"name": "_fivetran_deleted", "datatype": dbt.type_boolean()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "height", "datatype": dbt.type_int()},
    {"name": "id", "datatype": dbt.type_bigint()},
    {"name": "product_id", "datatype": dbt.type_bigint()},
    {"name": "width", "datatype": dbt.type_int()},
    {"name": "media_id", "datatype": dbt.type_bigint()},
    {"name": "status", "datatype": dbt.type_string()},
    {"name": "url", "datatype": dbt.type_string()}
    , 
    {"name": "created_at", "datatype": dbt.type_timestamp()},
    {"name": "position", "datatype": dbt.type_int()},
    {"name": "updated_at", "datatype": dbt.type_timestamp()},
    {"name": "src", "datatype": dbt.type_string()},
    {"name": "variant_ids", "datatype": dbt.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
