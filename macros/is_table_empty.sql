{%- macro is_table_empty(table_name) -%}

{{ adapter.dispatch('is_table_empty', 'shopify_source') (table_name) }}

{%- endmacro %}

{%- macro default__is_table_empty(table_name) -%}
    {%- if execute and flags.WHICH in ('run', 'build') %}
        {% set row_count_query %}
            select 1 from {{ table_name }} limit 1
        {% endset %}
        {% set results = run_query(row_count_query) %}
        {% if results.rows | length == 0 %}
            {{ return("empty") }}
        {% endif %}
    {% endif -%}
{%- endmacro -%}