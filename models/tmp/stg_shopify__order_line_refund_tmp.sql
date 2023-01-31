-- this model will be all NULL until you have made an order line refund in Shopify

{%- set source_relation = adapter.get_relation(
        database=source('shopify', 'order_line_refund').database,
        schema=source('shopify', 'order_line_refund').schema,
        identifier=source('shopify', 'order_line_refund').name) -%}

{% set table_exists=source_relation is not none  %}

{% if table_exists %}

{{
    fivetran_utils.union_data(
        table_identifier='order_line_refund', 
        database_variable='shopify_database', 
        schema_variable='shopify_schema', 
        default_database=target.database,
        default_schema='shopify',
        default_variable='order_line_refund_source',
        union_schema_variable='shopify_union_schemas',
        union_database_variable='shopify_union_databases'
    )
}}

{% else %}

select
    cast(null as {{ dbt.type_timestamp() }}) as _fivetran_synced,
    cast(null as {{ dbt.type_numeric() }}) as id,
    cast(null as {{ dbt.type_numeric() }}) as location_id,
    cast(null as {{ dbt.type_numeric() }}) as order_line_id,
    cast(null as {{ dbt.type_numeric() }}) as subtotal,
    cast(null as {{ dbt.type_string() }}) as subtotal_set,
    cast(null as {{ dbt.type_numeric() }}) as total_tax,
    cast(null as {{ dbt.type_string() }}) as total_tax_set,
    cast(null as {{ dbt.type_float() }}) as quantity,
    cast(null as {{ dbt.type_numeric() }}) as refund_id,
    cast(null as {{ dbt.type_string() }}) as restock_type,
    cast(null as {{ dbt.type_string() }}) as _dbt_source_relation

{% endif %}