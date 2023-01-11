-- this model will be all NULL until you create a discount code in Shopify

{%- set source_relation = adapter.get_relation(
        database=source('shopify', 'discount_code').database,
        schema=source('shopify', 'discount_code').schema,
        identifier=source('shopify', 'discount_code').name) -%}

{% set table_exists=source_relation is not none  %}

{% if table_exists %}

{{
    fivetran_utils.union_data(
        table_identifier='discount_code', 
        database_variable='shopify_database', 
        schema_variable='shopify_schema', 
        default_database=target.database,
        default_schema='shopify',
        default_variable='discount_code_source',
        union_schema_variable='shopify_union_schemas',
        union_database_variable='shopify_union_databases'
    )
}}

{% else %}

select
    cast(null as {{ dbt.type_timestamp() }}) as _fivetran_synced,
    cast(null as {{ dbt.type_string() }}) as code,
    cast(null as {{ dbt.type_timestamp() }}) as created_at,
    cast(null as {{ dbt.type_int() }}) as id,
    cast(null as {{ dbt.type_int() }}) as price_rule_id,
    cast(null as {{ dbt.type_timestamp() }}) as updated_at,
    cast(null as {{ dbt.type_float() }}) as usage_count,
    cast(null as {{ dbt.type_string() }}) as _dbt_source_relation

{% endif %}