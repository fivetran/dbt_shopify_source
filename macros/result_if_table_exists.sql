{%- macro result_if_table_exists(table_ref, result_statement, if_empty) -%}

{{ adapter.dispatch('result_if_table_exists', 'shopify_source') (table_ref, result_statement, if_empty) }}

{%- endmacro -%}

{%- macro default__result_if_table_exists(table_ref, result_statement, if_empty) -%}
    {%- set is_empty_result = shopify_source.is_table_empty(table_ref) -%} 
    {%- if is_empty_result == "empty" %}
        {{ if_empty }}
    {%- else %}
        {{ result_statement }}
    {%- endif %}
{%- endmacro %}