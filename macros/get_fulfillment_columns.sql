{% macro get_fulfillment_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "created_at", "datatype": dbt.type_timestamp()},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "location_id", "datatype": dbt.type_int()},
    {"name": "name", "datatype": dbt.type_string()},
    {"name": "order_id", "datatype": dbt.type_int()},
    {"name": "service", "datatype": dbt.type_string()},
    {"name": "shipment_status", "datatype": dbt.type_string()},
    {"name": "status", "datatype": dbt.type_string()},
    {"name": "tracking_company", "datatype": dbt.type_string()},
    {"name": "tracking_number", "datatype": dbt.type_string()},
    {"name": "tracking_numbers", "datatype": dbt.type_string()},
    {"name": "tracking_urls", "datatype": dbt.type_string()},
    {"name": "updated_at", "datatype": dbt.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}


{% macro get_graphql_fulfillment_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "created_at", "datatype": dbt.type_timestamp()},
    {"name": "delivered_at", "datatype": dbt.type_timestamp()},
    {"name": "display_status", "datatype": dbt.type_string()},
    {"name": "estimated_delivery_at", "datatype": dbt.type_timestamp()},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "in_transit_at", "datatype": dbt.type_timestamp()},
    {"name": "location_id", "datatype": dbt.type_int()},
    {"name": "name", "datatype": dbt.type_string()},
    {"name": "order_id", "datatype": dbt.type_int()},
    {"name": "origin_address_1", "datatype": dbt.type_string()},
    {"name": "origin_address_2", "datatype": dbt.type_string()},
    {"name": "origin_address_city", "datatype": dbt.type_string()},
    {"name": "origin_address_country_code", "datatype": dbt.type_string()},
    {"name": "origin_address_province_code", "datatype": dbt.type_string()},
    {"name": "origin_address_zip", "datatype": dbt.type_string()},
    {"name": "requires_shipping", "datatype": dbt.type_boolean()},
    {"name": "service_id", "datatype": dbt.type_string()},
    {"name": "status", "datatype": dbt.type_string()},
    {"name": "total_quantity", "datatype": dbt.type_int()},
    {"name": "updated_at", "datatype": dbt.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}
