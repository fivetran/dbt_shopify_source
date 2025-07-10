{% macro get_collection_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": dbt.type_boolean()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "disjunctive", "datatype": dbt.type_boolean()},
    {"name": "handle", "datatype": dbt.type_string()},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "published_at", "datatype": dbt.type_timestamp()},
    {"name": "published_scope", "datatype": dbt.type_string()},
    {"name": "rules", "datatype": dbt.type_string()},
    {"name": "sort_order", "datatype": dbt.type_string()},
    {"name": "title", "datatype": dbt.type_string()},
    {"name": "updated_at", "datatype": dbt.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}


{% macro get_graphql_collection_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": dbt.type_boolean()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "applied_disjunctively", "datatype": dbt.type_boolean()},
    {"name": "description", "datatype": dbt.type_string()},
    {"name": "description_html", "datatype": dbt.type_string()},
    {"name": "feedback_summary", "datatype": dbt.type_string()},
    {"name": "handle", "datatype": dbt.type_string()},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "image_alt_text", "datatype": dbt.type_string()},
    {"name": "image_height", "datatype": dbt.type_int()},
    {"name": "image_id", "datatype": dbt.type_int()},
    {"name": "image_url", "datatype": dbt.type_string()},
    {"name": "image_width", "datatype": dbt.type_int()},
    {"name": "products_count", "datatype": dbt.type_int()},
    {"name": "products_count_precision", "datatype": dbt.type_string()},
    {"name": "seo_description", "datatype": dbt.type_string()},
    {"name": "seo_title", "datatype": dbt.type_string()},
    {"name": "sort_order", "datatype": dbt.type_string()},
    {"name": "template_suffix", "datatype": dbt.type_string()},
    {"name": "title", "datatype": dbt.type_string()},
    {"name": "updated_at", "datatype": dbt.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}