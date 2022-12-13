--To disable this model, set the shopify__using_refund variable within your dbt_project.yml file to False.
{{ config(enabled=var('shopify__using_refund', True)) }}

{%- set source_relation = adapter.get_relation(
        database=source('shopify', 'refund').database,
        schema=source('shopify', 'refund').schema,
        identifier=source('shopify', 'refund').name) -%}

{% set table_exists=source_relation is not none  %}

{% if table_exists %}

{{
    fivetran_utils.union_data(
        table_identifier='refund', 
        database_variable='shopify_database', 
        schema_variable='shopify_schema', 
        default_database=target.database,
        default_schema='shopify',
        default_variable='refund_source',
        union_schema_variable='shopify_union_schemas',
        union_database_variable='shopify_union_databases'
    )
}}

{% else %}

select
    cast(null as {{ dbt.type_timestamp() }}) as _fivetran_synced,
    cast(null as {{ dbt.type_timestamp() }}) as created_at,
    cast(null as {{ dbt.type_numeric() }}) as id,
    cast(null as {{ dbt.type_string() }}) as note,
    cast(null as {{ dbt.type_numeric() }}) as order_id,
    cast(null as {{ dbt.type_timestamp() }}) as processed_at,
    cast(null as boolean) as restock,
    cast(null as {{ dbt.type_string() }}) as total_duties_set,
    cast(null as {{ dbt.type_numeric() }}) as user_id,
    cast(null as {{ dbt.type_string() }}) as _dbt_source_relation

{% endif %}