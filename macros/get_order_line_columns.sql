{% macro get_order_line_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "fulfillable_quantity", "datatype": dbt.type_numeric()},
    {"name": "fulfillment_status", "datatype": dbt.type_string()},
    {"name": "gift_card", "datatype": dbt.type_boolean()},
    {"name": "grams", "datatype": dbt.type_numeric()},
    {"name": "id", "datatype": dbt.type_numeric()},
    {"name": "index", "datatype": dbt.type_numeric()},
    {"name": "name", "datatype": dbt.type_string()},
    {"name": "order_id", "datatype": dbt.type_numeric()},
    {"name": "pre_tax_price", "datatype": dbt.type_float()},
    {"name": "pre_tax_price_set", "datatype": dbt.type_string()},
    {"name": "price", "datatype": dbt.type_float()},
    {"name": "price_set", "datatype": dbt.type_string()},
    {"name": "product_id", "datatype": dbt.type_numeric()},
    {"name": "quantity", "datatype": dbt.type_numeric()},
    {"name": "requires_shipping", "datatype": dbt.type_boolean()},
    {"name": "sku", "datatype": dbt.type_string()},
    {"name": "taxable", "datatype": dbt.type_boolean()},
    {"name": "tax_code", "datatype": dbt.type_string()},
    {"name": "title", "datatype": dbt.type_string()},
    {"name": "total_discount", "datatype": dbt.type_float()},
    {"name": "total_discount_set", "datatype": dbt.type_string()},
    {"name": "variant_id", "datatype": dbt.type_numeric()},
    {"name": "variant_title", "datatype": dbt.type_string()},
    {"name": "variant_inventory_management", "datatype": dbt.type_string()},
    {"name": "vendor", "datatype": dbt.type_string()},
    {"name": "properties", "datatype": dbt.type_string()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('order_line_pass_through_columns')) }}

{{ return(columns) }}

{% endmacro %}


{% macro get_graphql_order_line_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "current_quantity", "datatype": dbt.type_int()},
    {"name": "discounted_total_set_pres_amount", "datatype": dbt.type_float()},
    {"name": "discounted_total_set_pres_currency_code", "datatype": dbt.type_string()},
    {"name": "discounted_total_set_shop_amount", "datatype": dbt.type_float()},
    {"name": "discounted_total_set_shop_currency_code", "datatype": dbt.type_string()},
    {"name": "discounted_unit_price_after_all_disc_set_pres_amount", "datatype": dbt.type_float()},
    {"name": "discounted_unit_price_after_all_disc_set_pres_currency_code", "datatype": dbt.type_string()},
    {"name": "discounted_unit_price_after_all_disc_set_shop_amount", "datatype": dbt.type_float()},
    {"name": "discounted_unit_price_after_all_disc_set_shop_currency_code", "datatype": dbt.type_string()},
    {"name": "discounted_unit_price_set_pres_amount", "datatype": dbt.type_float()},
    {"name": "discounted_unit_price_set_pres_currency_code", "datatype": dbt.type_string()},
    {"name": "discounted_unit_price_set_shop_amount", "datatype": dbt.type_float()},
    {"name": "discounted_unit_price_set_shop_currency_code", "datatype": dbt.type_string()},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "image_alt_text", "datatype": dbt.type_string()},
    {"name": "image_height", "datatype": dbt.type_int()},
    {"name": "image_id", "datatype": dbt.type_int()},
    {"name": "image_url", "datatype": dbt.type_string()},
    {"name": "image_width", "datatype": dbt.type_int()},
    {"name": "is_gift_card", "datatype": dbt.type_boolean()},
    {"name": "line_item_group_id", "datatype": dbt.type_int()},
    {"name": "line_item_group_quantity", "datatype": dbt.type_int()},
    {"name": "line_item_group_title", "datatype": dbt.type_string()},
    {"name": "line_item_group_variant_id", "datatype": dbt.type_int()},
    {"name": "line_item_group_variant_sku", "datatype": dbt.type_string()},
    {"name": "merchant_editable", "datatype": dbt.type_boolean()},
    {"name": "name", "datatype": dbt.type_string()},
    {"name": "non_fulfillable_quantity", "datatype": dbt.type_int()},
    {"name": "order_id", "datatype": dbt.type_int()},
    {"name": "original_total_set_pres_amount", "datatype": dbt.type_float()},
    {"name": "original_total_set_pres_currency_code", "datatype": dbt.type_string()},
    {"name": "original_total_set_shop_amount", "datatype": dbt.type_float()},
    {"name": "original_total_set_shop_currency_code", "datatype": dbt.type_string()},
    {"name": "original_unit_price_set_pres_amount", "datatype": dbt.type_float()},
    {"name": "original_unit_price_set_pres_currency_code", "datatype": dbt.type_string()},
    {"name": "original_unit_price_set_shop_amount", "datatype": dbt.type_float()},
    {"name": "original_unit_price_set_shop_currency_code", "datatype": dbt.type_string()},
    {"name": "product_id", "datatype": dbt.type_int()},
    {"name": "quantity", "datatype": dbt.type_int()},
    {"name": "refundable_quantity", "datatype": dbt.type_int()},
    {"name": "requires_shipping", "datatype": dbt.type_boolean()},
    {"name": "restockable", "datatype": dbt.type_boolean()},
    {"name": "selling_plan_id", "datatype": dbt.type_int()},
    {"name": "selling_plan_name", "datatype": dbt.type_string()},
    {"name": "sku", "datatype": dbt.type_string()},
    {"name": "staff_member_id", "datatype": dbt.type_int()},
    {"name": "taxable", "datatype": dbt.type_boolean()},
    {"name": "title", "datatype": dbt.type_string()},
    {"name": "total_discount_set_pres_amount", "datatype": dbt.type_float()},
    {"name": "total_discount_set_pres_currency_code", "datatype": dbt.type_string()},
    {"name": "total_discount_set_shop_amount", "datatype": dbt.type_float()},
    {"name": "total_discount_set_shop_currency_code", "datatype": dbt.type_string()},
    {"name": "unfulfilled_discounted_total_set_pres_amount", "datatype": dbt.type_float()},
    {"name": "unfulfilled_discounted_total_set_pres_currency_code", "datatype": dbt.type_string()},
    {"name": "unfulfilled_discounted_total_set_shop_amount", "datatype": dbt.type_float()},
    {"name": "unfulfilled_discounted_total_set_shop_currency_code", "datatype": dbt.type_string()},
    {"name": "unfulfilled_original_total_set_pres_amount", "datatype": dbt.type_float()},
    {"name": "unfulfilled_original_total_set_pres_currency_code", "datatype": dbt.type_string()},
    {"name": "unfulfilled_original_total_set_shop_amount", "datatype": dbt.type_float()},
    {"name": "unfulfilled_original_total_set_shop_currency_code", "datatype": dbt.type_string()},
    {"name": "unfulfilled_quantity", "datatype": dbt.type_int()},
    {"name": "variant_id", "datatype": dbt.type_int()},
    {"name": "variant_title", "datatype": dbt.type_string()},
    {"name": "vendor", "datatype": dbt.type_string()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('order_line_pass_through_columns')) }}

{{ return(columns) }}

{% endmacro %}
