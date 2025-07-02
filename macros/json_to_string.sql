{%- macro json_to_string(column, model) -%}
    {{ return(adapter.dispatch('json_to_string', 'shopify_source')(column, model)) }}
{%- endmacro -%}

{%- macro default__json_to_string(column, model) -%}
    {{ column }}
{%- endmacro -%}

{%- macro bigquery__json_to_string(column, model) -%}
    {%- set columns = adapter.get_columns_in_relation(model) -%}
    {%- set ns = namespace(column_type='string') -%}

    {%- for col in columns -%}
        {%- if col.name|lower == column|lower -%}
            {%- set ns.column_type = col.dtype|lower -%}
        {%- endif -%}
    {%- endfor -%}

    {%- if ns.column_type == 'json' -%}
        to_json_string({{ column }})
    {%- else -%}
        {{ column }}
    {%- endif -%}
{%- endmacro -%}
