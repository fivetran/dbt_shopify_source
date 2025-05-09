{%- macro does_table_exist(table_name) -%}
{{ adapter.dispatch('does_table_exist', 'stripe_source')(table_name) }}
{%- endmacro %}

{%- macro default__does_table_exist(table_name) -%}
    {%- if execute -%}
        {%- set source_relation = adapter.get_relation(
            database=var('shopify_database', target.database),
            schema=var('shopify_schema', 'shopify'),
            identifier=var('shopify_' ~ table_name ~ '_identifier', table_name)
            ) -%}
        {{ return('exists' if source_relation is not none) }}
    {%- endif -%}
{%- endmacro -%}