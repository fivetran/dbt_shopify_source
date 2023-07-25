{% macro get_discount_allocation_columns() %}

{% set columns = [
    {"name": "index", "datatype": dbt.type_string()},
    {"name": "order_line_id", "datatype": dbt.type_string},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "amount", "datatype": dbt.type_numeric()},
    {"name": "amount_set_presentment_money_amount", "datatype": dbt.type_numeric()},
    {"name": "amount_set_presentment_money_currency_code", "datatype": dbt.type_string()},
    {"name": "amount_set_shop_money_amount", "datatype": dbt.type_numeric()},
    {"name": "amount_set_shop_money_currency_code", "datatype": dbt.type_string()},
    {"name": "discount_application_index", "datatype": dbt.type_string()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('customer_pass_through_columns')) }}

{{ return(columns) }}

{% endmacro %}
