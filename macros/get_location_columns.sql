{% macro get_location_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": dbt.type_boolean()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "active", "datatype": dbt.type_boolean()},
    {"name": "address_1", "datatype": dbt.type_string()},
    {"name": "address_2", "datatype": dbt.type_string()},
    {"name": "city", "datatype": dbt.type_string()},
    {"name": "country", "datatype": dbt.type_string()},
    {"name": "country_code", "datatype": dbt.type_string()},
    {"name": "country_name", "datatype": dbt.type_string()},
    {"name": "created_at", "datatype": dbt.type_timestamp()},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "legacy", "datatype": dbt.type_boolean()},
    {"name": "localized_country_name", "datatype": dbt.type_string()},
    {"name": "localized_province_name", "datatype": dbt.type_string()},
    {"name": "name", "datatype": dbt.type_string()},
    {"name": "phone", "datatype": dbt.type_string()},
    {"name": "province", "datatype": dbt.type_string()},
    {"name": "province_code", "datatype": dbt.type_string()},
    {"name": "updated_at", "datatype": dbt.type_timestamp()},
    {"name": "zip", "datatype": dbt.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}


{% macro get_graphql_location_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": dbt.type_boolean()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "activatable", "datatype": dbt.type_boolean()},
    {"name": "address_1", "datatype": dbt.type_string()},
    {"name": "address_2", "datatype": dbt.type_string()},
    {"name": "address_verified", "datatype": dbt.type_boolean()},
    {"name": "city", "datatype": dbt.type_string()},
    {"name": "country", "datatype": dbt.type_string()},
    {"name": "country_code", "datatype": dbt.type_string()},
    {"name": "created_at", "datatype": dbt.type_timestamp()},
    {"name": "deactivatable", "datatype": dbt.type_boolean()},
    {"name": "deactivated_at", "datatype": dbt.type_timestamp()},
    {"name": "deletable", "datatype": dbt.type_boolean()},
    {"name": "fulfillment_service_id", "datatype": dbt.type_int()},
    {"name": "fulfills_online_orders", "datatype": dbt.type_boolean()},
    {"name": "has_active_inventory", "datatype": dbt.type_boolean()},
    {"name": "has_unfulfilled_orders", "datatype": dbt.type_boolean()},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "is_active", "datatype": dbt.type_boolean()},
    {"name": "is_fulfillment_service", "datatype": dbt.type_boolean()},
    {"name": "latitude", "datatype": dbt.type_float()},
    {"name": "local_pickup_settings_instructions", "datatype": dbt.type_string()},
    {"name": "local_pickup_settings_pickup_time", "datatype": dbt.type_string()},
    {"name": "longitude", "datatype": dbt.type_float()},
    {"name": "name", "datatype": dbt.type_string()},
    {"name": "phone", "datatype": dbt.type_string()},
    {"name": "province", "datatype": dbt.type_string()},
    {"name": "province_code", "datatype": dbt.type_string()},
    {"name": "ships_inventory", "datatype": dbt.type_boolean()},
    {"name": "updated_at", "datatype": dbt.type_timestamp()},
    {"name": "zip", "datatype": dbt.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}