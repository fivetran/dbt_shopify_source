
{% macro get_media_columns() %}

{% set columns = [
    {"name": "id", "datatype": dbt.type_bigint()},
    {"name": "status", "datatype": dbt.type_string()}, 
    {"name": "created_at", "datatype": dbt.type_timestamp()}, 
    {"name": "updated_at", "datatype": dbt.type_timestamp()} 
] %}

{{ return(columns) }}

{% endmacro %}


{% macro get_graphql_media_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "alt", "datatype": dbt.type_string()},
    {"name": "created_at", "datatype": dbt.type_timestamp()},
    {"name": "file_status", "datatype": dbt.type_string()},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "media_content_type", "datatype": dbt.type_string()},
    {"name": "preview_image_alt_text", "datatype": dbt.type_string()},
    {"name": "preview_image_height", "datatype": dbt.type_int()},
    {"name": "preview_image_id", "datatype": dbt.type_int()},
    {"name": "preview_image_url", "datatype": dbt.type_string()},
    {"name": "preview_image_width", "datatype": dbt.type_int()},
    {"name": "preview_status", "datatype": dbt.type_string()},
    {"name": "status", "datatype": dbt.type_string()},
    {"name": "updated_at", "datatype": dbt.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}