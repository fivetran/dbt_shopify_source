-- this model will be all NULL until you have made an order adjustment in Shopify

{%- set source_relation = adapter.get_relation(
        database=source('shopify', 'order_adjustment').database,
        schema=source('shopify', 'order_adjustment').schema,
        identifier=source('shopify', 'order_adjustment').name) -%}

{% set table_exists=source_relation is not none  %}

{% if (table_exists or var('shopify_union_schemas',[]) != [] or var('shopify_union_databases',[]) != []) and var('shopify__using_order_adjustment', True) %}

{{
    fivetran_utils.union_data(
        table_identifier='order_adjustment', 
        database_variable='shopify_database', 
        schema_variable='shopify_schema', 
        default_database=target.database,
        default_schema='shopify',
        default_variable='order_adjustment_source',
        union_schema_variable='shopify_union_schemas',
        union_database_variable='shopify_union_databases'
    )
}}

{% else %}

select
    cast(null as {{ dbt.type_timestamp() }}) as _fivetran_synced,
    cast(null as {{ dbt.type_numeric() }}) as id,
    cast(null as {{ dbt.type_numeric() }}) as order_id,
    cast(null as {{ dbt.type_numeric() }}) as refund_id,
    cast(null as {{ dbt.type_float() }}) as amount,
    cast(null as {{ dbt.type_string() }}) as amount_set,
    cast(null as {{ dbt.type_float() }}) as tax_amount,
    cast(null as {{ dbt.type_string() }}) as tax_amount_set,
    cast(null as {{ dbt.type_string() }}) as kind,
    cast(null as {{ dbt.type_string() }}) as reason,
    cast(null as {{ dbt.type_string() }}) as _dbt_source_relation

{% endif %}