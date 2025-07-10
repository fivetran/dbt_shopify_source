{% macro get_customer_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "accepts_marketing", "datatype": dbt.type_boolean()},
    {"name": "created_at", "datatype": dbt.type_timestamp()},
    {"name": "default_address_id", "datatype": dbt.type_numeric()},
    {"name": "email", "datatype": dbt.type_string()},
    {"name": "first_name", "datatype": dbt.type_string()},
    {"name": "id", "datatype": dbt.type_numeric()},
    {"name": "last_name", "datatype": dbt.type_string()},
    {"name": "orders_count", "datatype": dbt.type_numeric()},
    {"name": "phone", "datatype": dbt.type_string()},
    {"name": "state", "datatype": dbt.type_string()},
    {"name": "tax_exempt", "datatype": dbt.type_boolean()},
    {"name": "total_spent", "datatype": dbt.type_float()},
    {"name": "updated_at", "datatype": dbt.type_timestamp()},
    {"name": "verified_email", "datatype": dbt.type_boolean()},
    {"name": "email_marketing_consent_consent_updated_at", "datatype": dbt.type_timestamp()},
    {"name": "email_marketing_consent_opt_in_level", "datatype": dbt.type_string()},
    {"name": "email_marketing_consent_state", "datatype": dbt.type_string()},
    {"name": "note", "datatype": dbt.type_string()},
    {"name": "accepts_marketing_updated_at", "datatype": dbt.type_timestamp()},
    {"name": "marketing_opt_in_level", "datatype": dbt.type_string()},
    {"name": "currency", "datatype": dbt.type_string()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('customer_pass_through_columns')) }}

{{ return(columns) }}

{% endmacro %}


{% macro get_graphql_customer_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": dbt.type_boolean()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "can_delete", "datatype": dbt.type_boolean()},
    {"name": "created_at", "datatype": dbt.type_timestamp()},
    {"name": "currency", "datatype": dbt.type_string()},
    {"name": "data_sale_opt_out", "datatype": dbt.type_boolean()},
    {"name": "display_name", "datatype": dbt.type_string()},
    {"name": "email", "datatype": dbt.type_string()},
    {"name": "email_marketing_consent_opt_in_level", "datatype": dbt.type_string()},
    {"name": "email_marketing_consent_state", "datatype": dbt.type_string()},
    {"name": "email_marketing_consent_updated_at", "datatype": dbt.type_timestamp()},
    {"name": "first_name", "datatype": dbt.type_string()},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "image_alt_text", "datatype": dbt.type_string()},
    {"name": "image_height", "datatype": dbt.type_int()},
    {"name": "image_id", "datatype": dbt.type_int()},
    {"name": "image_url", "datatype": dbt.type_string()},
    {"name": "image_width", "datatype": dbt.type_int()},
    {"name": "is_data_sale_opt_out", "datatype": dbt.type_boolean()},
    {"name": "last_name", "datatype": dbt.type_string()},
    {"name": "last_order_id", "datatype": dbt.type_int()},
    {"name": "lifetime_duration", "datatype": dbt.type_string()},
    {"name": "locale", "datatype": dbt.type_string()},
    {"name": "multipass_identifier", "datatype": dbt.type_string()},
    {"name": "note", "datatype": dbt.type_string()},
    {"name": "number_of_orders", "datatype": dbt.type_int()},
    {"name": "orders_count", "datatype": dbt.type_int()},
    {"name": "phone", "datatype": dbt.type_string()},
    {"name": "product_subscriber_status", "datatype": dbt.type_string()},
    {"name": "sms_marketing_consent_collected_from", "datatype": dbt.type_string()},
    {"name": "sms_marketing_consent_opt_in_level", "datatype": dbt.type_string()},
    {"name": "sms_marketing_consent_state", "datatype": dbt.type_string()},
    {"name": "sms_marketing_consent_updated_at", "datatype": dbt.type_timestamp()},
    {"name": "state", "datatype": dbt.type_string()},
    {"name": "statistics_predicted_spend_tier", "datatype": dbt.type_string()},
    {"name": "tax_exempt", "datatype": dbt.type_boolean()},
    {"name": "total_spent", "datatype": dbt.type_float()},
    {"name": "unsubscribe_url", "datatype": dbt.type_string()},
    {"name": "updated_at", "datatype": dbt.type_timestamp()},
    {"name": "valid_email_address", "datatype": dbt.type_boolean()},
    {"name": "verified_email", "datatype": dbt.type_boolean()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('customer_pass_through_columns')) }}

{{ return(columns) }}

{% endmacro %}