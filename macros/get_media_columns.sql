
{% macro get_media_columns() %}

{% set columns = [
    {"name": "id", "datatype": dbt.type_bigint()},
    {"name": "status", "datatype": dbt.type_string()}, 
    {"name": "created_at", "datatype": dbt.type_timestamp()}, 
    {"name": "updated_at", "datatype": dbt.type_timestamp()} 
] %}

{{ return(columns) }}

{% endmacro %}
